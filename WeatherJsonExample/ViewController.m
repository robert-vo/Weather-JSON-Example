//
//  ViewController.m
//  WeatherJsonExample
//
//  Created by Robert Vo on 10/19/15.
//  Copyright © 2015 Robert Vo. All rights reserved.
//

#import "ViewController.h"
#import "Weather.h"
#import "NSString+Utilities.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize temperatureLabel, cityField, pressureLabel, humidityLabel, maxAndMinTemperatureLabel, currentWeatherDescriptionLabel, weatherForCity, weatherViewController, weatherDataResponse;


- (void)viewDidLoad {
    [super viewDidLoad];
    weatherForCity = [[Weather alloc] init];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)loadWeatherDataForGivenCity:(id)sender {
    NSString *url = [NSString createURL:cityField.text];
    NSURLSession *session = [NSURLSession sharedSession];
    
    [[session dataTaskWithURL:[NSURL URLWithString:url] completionHandler:^(NSData *data,
                                                                            NSURLResponse *response,
                                                                            NSError *error) {
        if (error != nil) {
            NSString *errorTitle = @"Error";
            NSString *message = @"Error getting JSON file.";
            UIAlertView *selectedAlert = [[UIAlertView alloc]
                                          initWithTitle:[NSString stringWithFormat:@"%@", errorTitle] message:[NSString stringWithFormat:@"%@",message] delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
            [selectedAlert show];
        }
        else {
            NSLog(@"valid json. yay!");
            weatherDataResponse = [[NSArray alloc] init];
            weatherDataResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            for(NSDictionary* weatherData in weatherDataResponse) {
                weatherForCity.temperature = [weatherData objectForKey:@"temperature"];
                weatherForCity.pressure = [weatherData objectForKey:@"pressure"];
                weatherForCity.humidity = [weatherData objectForKey:@"humidity"];
                weatherForCity.maximumTemperature = [[weatherData objectForKey:@"main"] objectForKey:@"temp_max"];
                weatherForCity.minimumTemperature = [[weatherData objectForKey:@"main"] objectForKey:@"temp_min"];
                weatherForCity.weatherDescription = [[weatherData objectForKey:@"weather"] objectAtIndex:2];
            }
        } [self.weatherViewController setNeedsDisplay];
    }] resume];
}


@end
