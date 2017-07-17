//
//  MyTableViewCell.h
//  Cats (P*)
//
//  Created by Thiago Hissa on 2017-07-17.
//  Copyright © 2017 Thiago Hissa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *cellImage;
@property (weak, nonatomic) IBOutlet UILabel *cellTitle;
@property (weak, nonatomic) IBOutlet UILabel *cellSubtitle;

@end
