//
//  ViewController.h
//  WeatherJsonExample
//
//  Created by Robert Vo on 10/19/15.
//  Copyright © 2015 Robert Vo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Weather.h"
#import "WeatherDetailViewController.h"

@interface HomeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *cityField;
@property NSDictionary *weatherDataResponse;
@property Weather *weatherForCity;
@property (strong, nonatomic) IBOutlet UIView *weatherViewController;
-(IBAction)loadWeatherDataForGivenCity:(id)sender;

@end
