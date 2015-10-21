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

    /*  Start of block
     *  If you are copying this code, make sure to edit your Info.plist file.
     *  Add an entry - NSAppTransportSecurity with type Dictionary.
     *  Insert a value into the NSAppTransportSecurity Dictionary - NSAllowsArbitraryLoads, as a boolean with value YES
    */
    
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
            
            //Sets the weatherDataResponse to the response obtained (data).
            //NSJSONSerialization is used to parse through the data as a key/value structure.
            weatherDataResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            //Looking at the JSON structure from this example request here, http://api.openweathermap.org/data/2.5/weather?q=Houston&appid=e5e82b27942eb6b9b2e43e2b945e0704
            /*
            ...
            "weather": [
                        {
                            "id": 800,
                            "main": "Clear",
                            "description": "Sky is Clear",
                            "icon": "01n"
                        }
                        ],
            "base": "cmc stations",
            "main": {
                "temp": 297.868,
                "pressure": 1030.12,
                "humidity": 75,
                "temp_min": 297.868,
                "temp_max": 297.868,
                "sea_level": 1031.6,
                "grnd_level": 1030.12
            }
            The data we want are the description, temp, pressure, humidity, temp_min, temp_max fields.
            For description, we have to get the value of the key "weather", get the 0th element of the array, and then get the value of the key "description".
            For the rest, we need to grab the value of the key "main", and then grab the value of the key $var$ for var is temp, pressure, humidity, temp_min, temp_max, of that result.
            */
            
            weatherForCity.temperature = [[weatherDataResponse objectForKey:@"main"] objectForKey:@"temp"];
            weatherForCity.pressure = [[weatherDataResponse objectForKey:@"main"] objectForKey:@"pressure"];
            weatherForCity.humidity = [[weatherDataResponse objectForKey:@"main"] objectForKey:@"humidity"];
            weatherForCity.maximumTemperature = [[weatherDataResponse objectForKey:@"main"] objectForKey:@"temp_max"];
            weatherForCity.minimumTemperature = [[weatherDataResponse objectForKey:@"main"] objectForKey:@"temp_min"];
            weatherForCity.weatherDescription = [[[weatherDataResponse objectForKey:@"weather"] objectAtIndex:0] objectForKey:@"description"];
            weatherForCity.temperatureUnit = [NSString stringWithFormat:@"%c", [selectedUnit characterAtIndex:0]];
            
            //This changes the value to YES, so that the below while loop will exit, denoting that the block has completed execution.
            jsonParsingCompleted = YES;
        }
    }] resume];
    
    //This will keep running until the block has hit the line with "jsonParsingCompleted = YES".
    while(!jsonParsingCompleted) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
    
    //Perform prepare for segue to the weatherVC (WeatherDetailViewController).
    [self performSegueWithIdentifier:@"weatherVC" sender:nil];

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    //If a weather is found
    if(weatherForCity != nil) {
        
        //Set the destination view controller as the WeatherDetailViewController.
        //This is why we need to #import "WeatherDetailViewController.h".
        WeatherDetailViewController* vc = [segue destinationViewController];
        
        //Sets the value of weatherDetail in the WeatherDetailViewController to weatherForCity,
        //which is the value obtained through the Open Weather Map API.
        vc.weatherDetail = weatherForCity;
        
        //Passes the city the user queried for over.
        vc.searchedCity = cityField.text;
    }
    //else (no weather has been found)
    else {
        //Increment searchFailures by one. Once the user hits 5, the alert will be different.
        searchFailures = searchFailures + 1;
        
        //Define alert message.
        NSString *alertMessage = [NSString stringWithFormat:@"Unable to find any weather data for %@", cityField.text];
        
        //New alert mesasge if the user has failed to find any weather data after 5 times.
        if(searchFailures > 5) {
            alertMessage = @"You haven't been able to find any weather data now. Try closing and reopening this app!";
        }
        
        //Prepares and displays alert.
        UIAlertController *alert = [UIAlertController
                                      alertControllerWithTitle:@"Error"
                                      message: alertMessage
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okayButton = [UIAlertAction
                                     actionWithTitle:@"Okay"
                                     style:UIAlertActionStyleDefault
                                     handler:^(UIAlertAction * action) {
                                         //The alert is dismisses when the user hits "Okay".
                                         [alert dismissViewControllerAnimated:YES completion:nil];
                                     }];
        [alert addAction:okayButton];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

@end
