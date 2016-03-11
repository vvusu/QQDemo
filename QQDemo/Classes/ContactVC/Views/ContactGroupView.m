//
//  ContactGroupView.m
//  QQDemo
//
//  Created by vvusu on 3/10/16.
//  Copyright © 2016 vvusu. All rights reserved.
//

#import "ContactGroupView.h"
#import "GroupModel.h"

@interface ContactGroupView ()
@property (weak, nonatomic) UIButton *contactGroupBtn;
@property (weak, nonatomic) UILabel *contactGroupNumLabel;
@property (weak, nonatomic) UIView *line;
@property (weak, nonatomic) GroupModel *groupModel;
@end

@implementation ContactGroupView

+ (instancetype)headerViewWithTableView:(UITableView *)tableView {
    static NSString *contactGroupViewID = @"ContactGroupView";
    ContactGroupView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:contactGroupViewID];
    if (!headerView) {
        headerView = [[ContactGroupView alloc] initWithReuseIdentifier:contactGroupViewID];
    }
    return headerView;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        UIButton *btn = [[UIButton alloc]init];
        [btn setAdjustsImageWhenHighlighted:NO];
        btn.backgroundColor = [UIColor whiteColor];
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"buddy_header_arrow"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(contactGroupBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentRight;
        label.font = [UIFont systemFontOfSize:12];
        label.textColor = [UIColor grayColor];
        [self addSubview:label];
        
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self addSubview:line];
        self.line = line;
        self.contactGroupBtn = btn;
        self.contactGroupNumLabel = label;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.line.frame = CGRectMake(0, self.frame.size.height - 0.5, self.frame.size.width, 0.3);
    self.contactGroupBtn.frame = CGRectMake(0, 0, self.frame.size.width,self.frame.size.height);
    self.contactGroupNumLabel.frame = CGRectMake(self.frame.size.width - 80, 0, 70, self.frame.size.height);
}

- (void)didMoveToSuperview {
    if (self.groupModel.isDisplay) {
        [UIView animateWithDuration:0.3 animations:^{
            self.contactGroupBtn.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
        }];
    } else {
        [UIView animateWithDuration:0.3 animations:^{
            self.contactGroupBtn.imageView.transform = CGAffineTransformMakeRotation(0);
        }];
    }
}

- (void)createWith:(GroupModel *)item inSection:(NSInteger)section {
    self.groupModel = item;
    [self.contactGroupBtn setTitle:item.categoryName forState:UIControlStateNormal];
    if (section == 2) {
        self.contactGroupNumLabel.text = @"未开通";
    } else {
        self.contactGroupNumLabel.text = [NSString stringWithFormat:@"%d/%lu",item.onlineNum.intValue,(unsigned long)item.authors.count];
    }
}

- (void)contactGroupBtnClick {
    if (self.ContactGroupViewBlock) {
        self.ContactGroupViewBlock();
    }
}

@end
