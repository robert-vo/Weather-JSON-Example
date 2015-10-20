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

@synthesize cityField, weatherForCity, weatherViewController, weatherDataResponse;


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
    NSString *url = [NSString createURL:cityField.text unit:@"hi"];
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
            jsonParsingCompleted = YES;
        }     }] resume];
    
    while (CFRunLoopRunInMode(kCFRunLoopDefaultMode, 0, true) && !jsonParsingCompleted){};
    
    [self performSegueWithIdentifier:@"weatherVC" sender:nil];

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if(weatherForCity != nil) {
        WeatherDetailViewController* vc = [segue destinationViewController];
        vc.weatherDetail = weatherForCity;
        vc.searchedCity = cityField.text;
    }
    else {
        UIAlertController *alert = [UIAlertController
                                      alertControllerWithTitle:@"Error"
                                      message: [NSString stringWithFormat:@"Unable to find any weather data for %@", cityField.text]
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
