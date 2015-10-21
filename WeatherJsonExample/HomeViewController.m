//
//  ViewController.m
//  WeatherJsonExample
//
//  Created by Robert Vo on 10/19/15.
//  Copyright © 2015 Robert Vo. All rights reserved.
//

#import "HomeViewController.h"
#import "Weather.h"
#import "NSString+Utilities.h"
#import "WeatherDetailViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

@synthesize cityField, weatherForCity, weatherViewController, weatherDataResponse, UnitsSegmentedControl, searchFailures;


- (void)viewDidLoad {
    [super viewDidLoad];
    weatherForCity = [[Weather alloc] init];
    searchFailures = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(IBAction)loadWeatherDataForGivenCity:(id)sender {
    NSString *selectedUnit = [UnitsSegmentedControl titleForSegmentAtIndex:UnitsSegmentedControl.selectedSegmentIndex];
    NSString *url = [NSString createURL:cityField.text unit:selectedUnit];
    NSURLSession *session = [NSURLSession sharedSession];
    __block BOOL jsonParsingCompleted = NO;

    [[session dataTaskWithURL:[NSURL URLWithString:url] completionHandler:^(NSData *data,
                                                                            NSURLResponse *response,
                                                                            NSError *error) {
        if (error != nil) {
            weatherForCity = nil;
            jsonParsingCompleted = YES;
        }
        else {
            NSLog(@"valid json. yay!");
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
