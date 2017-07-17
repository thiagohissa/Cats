//
//  DetailViewController.m
//  Cats (P*)
//
//  Created by Thiago Hissa on 2017-07-17.
//  Copyright © 2017 Thiago Hissa. All rights reserved.
//

#import "DetailViewController.h"

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
  //  self.detailsImage.image = [UIImage imageNamed:self.imagePhoto];
    self.detailsImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.imagePhoto]]];
}

- (void)setDetailItem:(Photo *)photo {
    _titlePhoto = photo.title;
    _subtitlePhoto = photo.idAPI;
    _imagePhoto = photo.photoImageName;
    [self configureView];
}



@end
