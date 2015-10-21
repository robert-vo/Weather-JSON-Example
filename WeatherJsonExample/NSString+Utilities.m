//
//  NSString+Utilities.m
//  WeatherJsonExample
//
//  Created by Robert Vo on 10/19/15.
//  Copyright © 2015 Robert Vo. All rights reserved.
//

#import "NSString+Utilities.h"

@implementation NSString (Utilities)

//Creates the url to use to contact the Open Weather Map API.
+ (NSString *) createURL :(NSString*)city unit:(NSString*)unit {

    //API Key to use to connect to the Open Weather Map API.
    NSString *apiKey = @"&appid=e5e82b27942eb6b9b2e43e2b945e0704";
    
    //Units query
    NSString *temperatureUnit = @"&units=";
    
    if([unit isEqualToString:@"Fahrenheit"]) { //Imperial units
        temperatureUnit = [temperatureUnit stringByAppendingString:@"Imperial"];
    }
    else if([unit isEqualToString:@"Celsius"]) { //Metric units
        temperatureUnit = [temperatureUnit stringByAppendingString:@"Metric"];
    }
    else { //[unit isEqualToString:@"Kelvin
        temperatureUnit = [temperatureUnit stringByAppendingString:@""];
    }
    
    NSString *beginningOfUrl = @"http://api.openweathermap.org/data/2.5/weather?q=";
    
    //Example return - http://api.openweathermap.org/data/2.5/weather?q=Houston&appid=e5e82b27942eb6b9b2e43e2b945e0704
    return [NSString stringWithFormat:@"%@%@%@%@", beginningOfUrl, city, apiKey, temperatureUnit];
    
}

@end
