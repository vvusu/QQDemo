//
//  MessageCell.m
//  QQDemo
//
//  Created by vvusu on 3/10/16.
//  Copyright © 2016 vvusu. All rights reserved.
//

#import "MessageCell.h"
#import "MessageModel.h"
#import "UIImageView+WebCache.h"
#import "LNQQBombButton.h"
#import "UIImage+ImageCrop.h"

@implementation MessageCell

- (void)awakeFromNib {
    // Initialization code
    self.headImage.layer.cornerRadius = 25;
    self.headImage.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)createWithGroupModel:(MessageModel *)item index:(NSIndexPath *)index {
    self.messageLabel.text = item.message;
    self.nameLabel.text = item.nickName;
    self.timeLabel.text = item.time;
    if (item.messageNum.intValue !=0) {
        self.messageNumBtn.hidden = NO;
        [self.messageNumBtn setTitle:[NSString stringWithFormat:@"%d",item.messageNum.intValue] forState:UIControlStateNormal];
    } else {
        self.messageNumBtn.hidden = YES;
    }
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:item.avatarURL] placeholderImage:[UIImage imageNamed:@"addressbook_list_user"]];
}

@end
