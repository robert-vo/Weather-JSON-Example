//
//  HomeViewController.h
//  WeatherJsonExample
//
//  Created by Robert Vo on 10/19/15.
//  Copyright © 2015 Robert Vo. All rights reserved.
//
//

#import <UIKit/UIKit.h>
#import "Weather.h" //You need this import to have a @property Weather.
#import "WeatherDetailViewController.h"

@interface HomeViewController : UIViewController

//This segmented control allows the user to choose between Kelvin, Fahrenheit, and Celsius.
@property (weak, nonatomic) IBOutlet UISegmentedControl *UnitsSegmentedControl;

//Stores the users input and passes it to the Open Weather Map API for parsing.
@property (weak, nonatomic) IBOutlet UITextField *cityField;

//Stores the key value pairs of the response returned by the Open Weather Map API.
@property NSDictionary *weatherDataResponse;

//This Weather object stores the weather data for the given city, as returned by the Open Weather Map API.
//weatherForCity is used to pass into the WeatherDetailViewController.
@property Weather *weatherForCity;

//searchFailures will prompt the user a different message if the user has 5 or more failed search attempts.
@property int searchFailures;

//This action is called when the "Load weather data for input city" button is clicked.
-(IBAction)loadWeatherDataForGivenCity:(id)sender;

@end
