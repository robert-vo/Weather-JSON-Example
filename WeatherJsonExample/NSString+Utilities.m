//
//  NSString+Utilities.m
//  WeatherJsonExample
//
//  Created by Robert Vo on 10/19/15.
//  Copyright © 2015 Robert Vo. All rights reserved.
//

#import "NSString+Utilities.h"

@implementation NSString (Utilities)

+ (NSString *) createURL :(NSString*)city unit:(NSString*)unit{
    NSString *apiKey = @"&appid=e5e82b27942eb6b9b2e43e2b945e0704";
    NSString *temperatureUnit = @"&units=";
    
    if([unit isEqualToString:@"Fahrenheit"]) {
        temperatureUnit = [temperatureUnit stringByAppendingString:@"Imperial"];
    }
    else if([unit isEqualToString:@"Celsius"]) {
        temperatureUnit = [temperatureUnit stringByAppendingString:@"Metric"];
    }
    else { //[unit isEqualToString:@"Kelvin
        temperatureUnit = [temperatureUnit stringByAppendingString:@""];
    }
    NSString *beginningOfUrl = @"http://api.openweathermap.org/data/2.5/weather?q=";
    return [NSString stringWithFormat:@"%@%@%@%@", beginningOfUrl, city, apiKey, temperatureUnit];
}

@end
