//
//  ShowAllViewController.h
//  Cats (P*)
//
//  Created by Thiago Hissa on 2017-07-18.
//  Copyright © 2017 Thiago Hissa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photo.h"
@import MapKit;

@interface ShowAllViewController : UIViewController
@property (weak, nonatomic) IBOutlet MKMapView *mymap;
- (void)setMap:(NSMutableArray *)array;
@end
