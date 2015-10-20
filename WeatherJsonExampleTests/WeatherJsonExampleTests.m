//
//  WeatherJsonExampleTests.m
//  WeatherJsonExampleTests
//
//  Created by Robert Vo on 10/19/15.
//  Copyright © 2015 Robert Vo. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSString+Utilities.h"

@interface WeatherJsonExampleTests : XCTestCase

@end

@implementation WeatherJsonExampleTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)canaryTest {
    XCTAssertTrue(true);
}

- (void)testCreateHoustonOpenMapApiUrl {
    NSString *url = [NSString createURL:@"Houston" unit:@"Celsius"];
    XCTAssertTrue([url isEqualToString:@"http://api.openweathermap.org/data/2.5/weather?q=Houston&appid=e5e82b27942eb6b9b2e43e2b945e0704&units=Metric"]);
}

- (void)testCreateLondonUKOpenMapApiUrl {
    NSString *url = [NSString createURL:@"London, UK" unit:@"Fahrenheit"];
    XCTAssertTrue([url isEqualToString:@"http://api.openweathermap.org/data/2.5/weather?q=London, UK&appid=e5e82b27942eb6b9b2e43e2b945e0704&units=Imperial"]);

}

@end
