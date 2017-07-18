//
//  DetailViewController.h
//  Cats (P*)
//
//  Created by Thiago Hissa on 2017-07-17.
//  Copyright © 2017 Thiago Hissa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photo.h"

@interface DetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
//@property (weak, nonatomic) IBOutlet UIImageView *detailsImage;
@property (weak, nonatomic) IBOutlet UILabel *detailsLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailsSubTitle;
@property (nonatomic) NSString *titlePhoto;
@property (nonatomic) NSString *subtitlePhoto;
//@property (nonatomic) NSString *imagePhoto;

@property (nonatomic) double lon;
@property (nonatomic) double lat;
@property(nonatomic) CLLocationCoordinate2D coordinateDetails;


- (void)setDetailItem:(Photo *)photo;
@end
