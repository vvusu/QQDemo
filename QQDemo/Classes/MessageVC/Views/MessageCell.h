//
//  MessageCell.h
//  QQDemo
//
//  Created by vvusu on 3/10/16.
//  Copyright © 2016 vvusu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MessageModel,LNQQBombButton;
@interface MessageCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet LNQQBombButton *messageNumBtn;
- (void)createWithGroupModel:(MessageModel *)item index:(NSIndexPath *)index;
@end
