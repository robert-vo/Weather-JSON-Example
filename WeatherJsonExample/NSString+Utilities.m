//
//  NSString+Utilities.m
//  WeatherJsonExample
//
//  Created by Robert Vo on 10/19/15.
//  Copyright © 2015 Robert Vo. All rights reserved.
//

#import "NSString+Utilities.h"

@implementation NSString (Utilities)

+ (NSString *) createURL :(NSString*)city {
    NSString *apiKey = @"&appid=e5e82b27942eb6b9b2e43e2b945e0704";
    NSString *beginningOfUrl = @"http://api.openweathermap.org/data/2.5/weather?q=";
    return [NSString stringWithFormat:@"%@%@%@", beginningOfUrl, city, apiKey];
}

@end
