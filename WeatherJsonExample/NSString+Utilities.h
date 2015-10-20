//
//  NSString+Utilities.h
//  WeatherJsonExample
//
//  Created by Robert Vo on 10/19/15.
//  Copyright © 2015 Robert Vo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Utilities)

+ (NSString *) createURL :(NSString*)city unit:(NSString*)unit;
+ (NSString *) getUnits :(int)selectedSegment;

@end
