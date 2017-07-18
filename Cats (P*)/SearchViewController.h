//
//  SearchViewController.h
//  Cats (P*)
//
//  Created by Thiago Hissa on 2017-07-18.
//  Copyright © 2017 Thiago Hissa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
@import CoreLocation;

@protocol SearchItemDelegate <NSObject>

-(void)searchString:(NSString *)string;

-(void)searchString:(NSString *)string withLat:(double)lat andLon:(double)lon;

@end



@interface SearchViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (nonatomic, strong) id <SearchItemDelegate> delegate;
@property (weak, nonatomic) IBOutlet UISwitch *switchLocation;
@property (nonatomic) CLLocationManager *   locationManager;
@end
