//
//  ViewController.m
//  WeatherJsonExample
//
//  Created by Robert Vo on 10/19/15.
//  Copyright © 2015 Robert Vo. All rights reserved.
//

#import "HomeViewController.h"

//You need this import to create and manipulate Weather objects.
#import "Weather.h"

//This import is needed to include the category, NSString+Utilities.
//This includes the createURL method used to set up the URL to contact.
#import "NSString+Utilities.h"

//Import the next view controller, WeatherDetailViewController, so that you can call segue destinationViewController on it.
//This is to transition to the next view and pass the values to there.
#import "WeatherDetailViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

@synthesize cityField, weatherForCity, weatherDataResponse, UnitsSegmentedControl, searchFailures;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Allocated and initialized the weatherForCity Weather object.
    weatherForCity = [[Weather alloc] init];
    
    //Setting initial search failures to zero.
    searchFailures = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*  loadWeatherDataForGivenCity contacts the Open Weather Map API and expects a response,
 *  in the form of a JSON format, and sets the weatherForCity attributes accordingly.
 *  Success or not, it will go to the prepareForSegue method.
 */
-(IBAction)loadWeatherDataForGivenCity:(id)sender {
    
    //Checks what the user has selected.
    NSString *selectedUnit = [UnitsSegmentedControl titleForSegmentAtIndex:UnitsSegmentedControl.selectedSegmentIndex];
    
    //Created the URL based on the city the user has inputted and the unit the user has selected.
    NSString *url = [NSString createURL:cityField.text unit:selectedUnit];
    
    //Creates a session.
    NSURLSession *session = [NSURLSession sharedSession];
    
    //This variable to check when the block has finished running.
    __block BOOL jsonParsingCompleted = NO;

    //Start of block
    [[session dataTaskWithURL:[NSURL URLWithString:url] completionHandler:^(NSData *data,
                                                                            NSURLResponse *response,
                                                                            NSError *error) {
        //If the error is not nil, meaning that an error exists.
        if (error != nil) {
            weatherForCity = nil;
            jsonParsingCompleted = YES;
        }
        //else, there is no error.
        else {
            //Obligatory celebratory message.
            NSLog(@"valid json. yay!");
            
            //Initializes the response.
            weatherDataResponse = [[NSDictionary alloc] init];
            
            
            weatherDataResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            weatherForCity.temperature = [[weatherDataResponse objectForKey:@"main"] objectForKey:@"temp"];
            weatherForCity.pressure = [[weatherDataResponse objectForKey:@"main"] objectForKey:@"pressure"];
            weatherForCity.humidity = [[weatherDataResponse objectForKey:@"main"] objectForKey:@"humidity"];
            weatherForCity.maximumTemperature = [[weatherDataResponse objectForKey:@"main"] objectForKey:@"temp_max"];
            weatherForCity.minimumTemperature = [[weatherDataResponse objectForKey:@"main"] objectForKey:@"temp_min"];
            weatherForCity.weatherDescription = [[[weatherDataResponse objectForKey:@"weather"] objectAtIndex:0] objectForKey:@"description"];
            weatherForCity.temperatureUnit = [NSString stringWithFormat:@"%c", [selectedUnit characterAtIndex:0]];
            jsonParsingCompleted = YES;
        }
    }] resume];
    
    while(!jsonParsingCompleted) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
    
    [self performSegueWithIdentifier:@"weatherVC" sender:nil];

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if(weatherForCity != nil) {
        WeatherDetailViewController* vc = [segue destinationViewController];
        vc.weatherDetail = weatherForCity;
        vc.searchedCity = cityField.text;
    }
    else {
        searchFailures = searchFailures + 1;
        NSString *alertMessage = [NSString stringWithFormat:@"Unable to find any weather data for %@", cityField.text];
        
        if(searchFailures > 5) {
            alertMessage = @"You haven't been able to find any weather data now. Try closing and reopening this app!";
        }
        
        UIAlertController *alert = [UIAlertController
                                      alertControllerWithTitle:@"Error"
                                      message: alertMessage
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okayButton = [UIAlertAction
                                     actionWithTitle:@"Okay"
                                     style:UIAlertActionStyleDefault
                                     handler:^(UIAlertAction * action) {
                                         [alert dismissViewControllerAnimated:YES completion:nil];
                                     }];
        [alert addAction:okayButton];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

@end
