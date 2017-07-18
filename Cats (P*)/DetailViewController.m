//
//  DetailViewController.m
//  Cats (P*)
//
//  Created by Thiago Hissa on 2017-07-17.
//  Copyright © 2017 Thiago Hissa. All rights reserved.
//

#import "DetailViewController.h"
@import MapKit;

@interface DetailViewController ()
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureView];
}

- (void)configureView {
    self.detailsLabel.text = self.titlePhoto;
    self.detailsSubTitle.text = self.subtitlePhoto;
  //  self.detailsImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.imagePhoto]]];
    
   // Map has to be set here
    MKCoordinateSpan span = MKCoordinateSpanMake(.5f, .5f);
    self.mapView.region = MKCoordinateRegionMake(self.coordinateDetails, span);
}

- (void)setDetailItem:(Photo *)photo {
    _titlePhoto = photo.title;
    _subtitlePhoto = photo.idAPI;
 //   _imagePhoto = photo.photoImageName;
    _lat = photo.tempLAT;
    _lon = photo.tempLON;
    _coordinateDetails = photo.coordinate;
    [self.mapView addAnnotation:photo];
    [self configureView];
}

@end
