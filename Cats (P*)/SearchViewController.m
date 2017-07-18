//
//  SearchViewController.m
//  Cats (P*)
//
//  Created by Thiago Hissa on 2017-07-18.
//  Copyright © 2017 Thiago Hissa. All rights reserved.
//

#import "SearchViewController.h"


@interface SearchViewController () <CLLocationManagerDelegate> {
    CLLocationManager *locationManager;
}
@end



@implementation SearchViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        [locationManager requestWhenInUseAuthorization];
    
    [locationManager startUpdatingLocation];
}

- (IBAction)searchButton:(id)sender {
    [self searchString:self.searchTextField.text];
}

// send data to delegate

-(void)searchString:(NSString *)string{
    [self.delegate searchString:self.searchTextField.text];
    [self dismissViewControllerAnimated: true completion:nil];
}



// Location Service:

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    NSLog(@"OldLocation %f %f", oldLocation.coordinate.latitude, oldLocation.coordinate.longitude);
    NSLog(@"NewLocation %f %f", newLocation.coordinate.latitude, newLocation.coordinate.longitude);
    [locationManager stopUpdatingLocation];
}



@end
