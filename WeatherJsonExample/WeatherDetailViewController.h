//
//  WeatherDetailViewController.h
//  WeatherJsonExample
//
//  Created by Robert Vo on 10/20/15.
//  Copyright © 2015 Robert Vo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Weather.h"

@interface WeatherDetailViewController : UIViewController

@property Weather *weatherDetail;
@property NSString *searchedCity;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *pressureLabel;
@property (weak, nonatomic) IBOutlet UILabel *humidityLabel;
@property (weak, nonatomic) IBOutlet UILabel *maxAndMinTemperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentWeatherDescriptionLabel;

@end
