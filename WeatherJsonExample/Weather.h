//
//  Weather.h
//  WeatherJsonExample
//
//  Created by Robert Vo on 10/19/15.
//  Copyright © 2015 Robert Vo. All rights reserved.
//
//
//  Header file for Weather object to store the values of the JSON request.
//

#import <Foundation/Foundation.h>

@interface Weather : NSObject

@property NSString *temperature;
@property NSString *pressure;
@property NSString *humidity;
@property NSString *maximumTemperature;
@property NSString *minimumTemperature;
@property NSString *weatherDescription;
@property NSString *temperatureUnit;

@end
