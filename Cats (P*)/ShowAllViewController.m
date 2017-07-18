//
//  ShowAllViewController.m
//  Cats (P*)
//
//  Created by Thiago Hissa on 2017-07-18.
//  Copyright © 2017 Thiago Hissa. All rights reserved.
//

#import "ShowAllViewController.h"

@interface ShowAllViewController ()

@end

@implementation ShowAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)setMap:(NSMutableArray *)array {
    [self.mymap addAnnotations:array];
}

- (IBAction)dismissView:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
