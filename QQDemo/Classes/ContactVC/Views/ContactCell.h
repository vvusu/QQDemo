//
//  ContactCell.h
//  QQDemo
//
//  Created by vvusu on 3/10/16.
//  Copyright © 2016 vvusu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AuthorModel, GroupModel;
@interface ContactCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *authorImage;
@property (weak, nonatomic) IBOutlet UILabel *authorInfoLabel;
@property (weak, nonatomic) IBOutlet UIButton *netTypeBtn;

- (void)createWithAuthorModel:(AuthorModel *)item index:(NSIndexPath *)index;
@end
