//
//  Photo.h
//  Cats (P*)
//
//  Created by Thiago Hissa on 2017-07-17.
//  Copyright © 2017 Thiago Hissa. All rights reserved.
//

#import <Foundation/Foundation.h>
@import MapKit;

@interface Photo : NSObject <MKAnnotation>
@property (nonatomic) NSString *server;
@property (nonatomic) NSString *farm;
@property (nonatomic) NSString *idAPI;
@property (nonatomic) NSString *secret;
@property (nonatomic, copy) NSString *title;
@property (nonatomic) NSString *photoImageName;
@property (nonatomic) double tempLON;
@property (nonatomic) double tempLAT;
@property(nonatomic) CLLocationCoordinate2D coordinate;
- (instancetype)initWithServer:(NSString*)server andFarm:(NSString*)farm andID:(NSString*)idAPI andSecret:(NSString*)secret andTitle:(NSString*)title;
@end
