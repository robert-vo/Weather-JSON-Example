//
//  ViewController.h
//  WeatherJsonExample
//
//  Created by Robert Vo on 10/19/15.
//  Copyright © 2015 Robert Vo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet UITextField *cityField;
@property (weak, nonatomic) IBOutlet UILabel *pressureLabel;
@property (weak, nonatomic) IBOutlet UILabel *humidityLabel;
@property (weak, nonatomic) IBOutlet UILabel *maxAndMinTemperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentWeatherDescriptionLabel;
-(IBAction)loadWeatherDataForGivenCity:(id)sender;

@end

/*Temperature
 • Pressure
 • Humidity
 • Maximum and minimum temperature
 • Current weather condition description and icon/image
 */
