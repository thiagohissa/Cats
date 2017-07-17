//
//  Photo.m
//  Cats (P*)
//
//  Created by Thiago Hissa on 2017-07-17.
//  Copyright © 2017 Thiago Hissa. All rights reserved.
//

#import "Photo.h"

@implementation Photo


- (instancetype)initWithServer:(NSString*)server andFarm:(NSString*)farm andID:(NSString*)idAPI andSecret:(NSString*)secret andTitle:(NSString *)title
{
    self = [super init];
    if (self) {
        _farm = farm;
        _secret = secret;
        _server = server;
        _idAPI = idAPI;
        _title = title;
        _photoImageName = [NSString stringWithFormat:@"https://farm%@.staticflickr.com/%@/%@_%@.jpg",self.farm,self.server,self.idAPI,self.secret];
    }
    return self;
}


@end
