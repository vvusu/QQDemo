//
//  ContactGroupView.h
//  QQDemo
//
//  Created by vvusu on 3/10/16.
//  Copyright © 2016 vvusu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GroupModel;
@interface ContactGroupView : UITableViewHeaderFooterView
@property (nonatomic, copy) void(^ContactGroupViewBlock)();

+ (instancetype)headerViewWithTableView:(UITableView *)tableView;
- (void)createWith:(GroupModel *)item inSection:(NSInteger)section;
@end
