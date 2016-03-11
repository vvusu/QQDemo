//
//  ContactCell.m
//  QQDemo
//
//  Created by vvusu on 3/10/16.
//  Copyright © 2016 vvusu. All rights reserved.
//

#import "ContactCell.h"
#import "AuthorModel.h"
#import "GroupModel.h"
#import "UIImageView+WebCache.h"

@implementation ContactCell

- (void)awakeFromNib {
    // Initialization code
    self.authorImage.layer.cornerRadius = 20;
    self.authorImage.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)createWithAuthorModel:(AuthorModel *)item index:(NSIndexPath *)index {
    [self.authorImage sd_setImageWithURL:[NSURL URLWithString:item.avatar] placeholderImage:[UIImage imageNamed:@"addressbook_list_user"]];
    self.nameLabel.text = item.nickname;
    if ([item.followStatus isEqualToString:@"0"]) {
        NSArray *tempArr = @[@"contacts_network_2g",@"contacts_network_3g",@"contacts_network_4g",@"contacts_network_pad",@"contacts_network_wifi"];
        NSString *netImageTitle = tempArr[arc4random()%tempArr.count];
        [self.netTypeBtn setImage:[UIImage imageNamed:netImageTitle] forState:UIControlStateNormal];
        self.authorInfoLabel.text = [NSString stringWithFormat:@"[在线]%@",item.intro];
    } else {
        [self.netTypeBtn setTitle:@"" forState:UIControlStateNormal];
        self.authorInfoLabel.text = [NSString stringWithFormat:@"[离线]%@",item.intro];
    }
}

@end
