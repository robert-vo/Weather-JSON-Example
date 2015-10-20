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

@synthesize weatherDetail;

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(weatherDetail.weatherDescription);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
