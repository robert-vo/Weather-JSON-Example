//
//  WeatherDetailViewController.m
//  WeatherJsonExample
//
//  Created by Robert Vo on 10/20/15.
//  Copyright © 2015 Robert Vo. All rights reserved.
//

#import "WeatherDetailViewController.h"
#import "HomeViewController.h"
#import "Weather.h"

@interface WeatherDetailViewController ()

@end

@implementation WeatherDetailViewController

@synthesize weatherDetail, searchedCity, temperatureLabel, pressureLabel, humidityLabel, maxAndMinTemperatureLabel, currentWeatherDescriptionLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Sets the title and label text to their respective values.
    
    self.title = searchedCity;
    temperatureLabel.text = [NSString stringWithFormat:@"Temperature: %@°%@", weatherDetail.temperature, weatherDetail.temperatureUnit];
    pressureLabel.text = [NSString stringWithFormat:@"Pressure: %@hPa", weatherDetail.pressure];
    humidityLabel.text = [NSString stringWithFormat:@"Humidity: %@%%", weatherDetail.humidity];
    maxAndMinTemperatureLabel.text = [NSString stringWithFormat:@"Min Temp: %@°%@\nMax Temp: %@°%@", weatherDetail.maximumTemperature, weatherDetail.temperatureUnit, weatherDetail.minimumTemperature, weatherDetail.temperatureUnit];
    currentWeatherDescriptionLabel.text = [NSString stringWithFormat:@"Description: %@", weatherDetail.weatherDescription];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
