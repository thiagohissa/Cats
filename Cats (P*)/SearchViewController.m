//
//  SearchViewController.m
//  Cats (P*)
//
//  Created by Thiago Hissa on 2017-07-18.
//  Copyright © 2017 Thiago Hissa. All rights reserved.
//

#import "SearchViewController.h"


@interface SearchViewController () <CLLocationManagerDelegate> {
  //  CLLocationManager *locationManager;
    double currentLat;
    double currentLon;
}
@end



@implementation SearchViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = 5;
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
}

- (IBAction)searchButton:(id)sender {
    if(self.switchLocation.on){
        [self searchString:self.searchTextField.text withLat:currentLat andLon:currentLon];
    }
    else if(!self.switchLocation.on){
        [self searchString:self.searchTextField.text];
    }
    
}

// send data to delegate

-(void)searchString:(NSString *)string{
    [self.delegate searchString:self.searchTextField.text];
    [self dismissViewControllerAnimated: true completion:nil];
}

-(void)searchString:(NSString *)string withLat:(double)lat andLon:(double)lon{
    [self.delegate searchString:self.searchTextField.text withLat:currentLat andLon:currentLon];
    [self dismissViewControllerAnimated: true completion:nil];
}



// Location Service:

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
//    NSLog(@"OldLocation %f %f", oldLocation.coordinate.latitude, oldLocation.coordinate.longitude);
    NSLog(@"NewLocation %f %f", newLocation.coordinate.latitude, newLocation.coordinate.longitude);
    currentLat = newLocation.coordinate.latitude;
    currentLon = newLocation.coordinate.longitude;
    [self.locationManager stopUpdatingLocation];
}



@end
