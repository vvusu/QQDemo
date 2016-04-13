//
//  ContactDataSource.m
//  QQDemo
//
//  Created by vvusu on 3/10/16.
//  Copyright © 2016 vvusu. All rights reserved.
//

#import "ContactDataSource.h"
#import "ContactCell.h"
#import "ContactHeadCell.h"
#import "AuthorModel.h"
#import "GroupModel.h"
#import "NSObject+YYModel.h"
#import "ContactGroupView.h"
#import "LNNetworking.h"
#import "LNCache.h"
#import "ODRefreshControl.h"

@implementation ContactDataSource

- (NSArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSArray array];
        _dataArr = [LNCache cachedQQGroup];
        [self refreshQQContactWithRequest];
    }
    GroupModel *model1 = [[GroupModel alloc]init];
    model1.categoryName = @"我的设备";
    GroupModel *model2 = [[GroupModel alloc]init];
    model2.categoryName = @"我的通信录";
    NSMutableArray *arr = [@[model1,model2]mutableCopy];
    [arr addObjectsFromArray:_dataArr];
    return arr;
}

- (ODRefreshControl *)refreshcontrol {
    if (!_refreshcontrol) {
        _refreshcontrol = [[ODRefreshControl alloc] initInScrollView:self.tableView];
        [_refreshcontrol addTarget:self action:@selector(refreshcontrolAction) forControlEvents:UIControlEventValueChanged];
    }
    return _refreshcontrol;
}

- (void)refreshQQContactWithRequest {
    [self.refreshcontrol beginRefreshing];
    LNRequest *request = [[LNRequest alloc]init];
    request.urlType = kIGetGroupInfo;
    __weak typeof(self) wSelf = self;
    [LNNetworking getWithRequest:request success:^(LNResponse *response) {
        [wSelf.refreshcontrol endRefreshing];
        if (response.isSucceed) {
            NSArray *groupArr = (NSArray *)response.resultDic;
            NSMutableArray *groupModels = [NSMutableArray array];
            for (NSDictionary *temp in groupArr) {
                GroupModel *groupModel = [GroupModel yy_modelWithDictionary:[temp valueForKey:@"category"]];
                groupModel.authors = [NSArray yy_modelArrayWithClass:[AuthorModel class] json:[temp valueForKey:@"authors"]];
                groupModel.onlineNum = [NSNumber numberWithInteger:groupModel.authors.count];
                [groupModels addObject:groupModel];
            }
            [LNCache cachedQQGroupActivity:groupModels];
            wSelf.dataArr = groupModels;
            [wSelf.tableView reloadData];
        }
    } fail:^(NSError *error) {
        [self.refreshcontrol endRefreshing];
    }];
}

- (void)refreshcontrolAction {
    //网络太快为了测试
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self refreshQQContactWithRequest];
    });
}

#pragma mark - UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else {
        GroupModel *model = self.dataArr[section - 1];
        if (model.isDisplay) {
            return model.authors.count;
        } else {
            return 0;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 80;
    } else {
        return 60;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        ContactHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ContactHeadCell"];
        return cell;
    } else {
        ContactCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ContactCell"];
        AuthorModel *model = ((GroupModel *)self.dataArr[indexPath.section - 1]).authors[indexPath.row];
        [cell createWithAuthorModel:model index:indexPath];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section > 2) {
        if (self.CellDidSelectedBlock) {
            self.CellDidSelectedBlock(CellClickTypeContact, nil);
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section==0) {
        return 0.000001f;
    }else {
        return 40;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0 || section == 2) {
        return 20;
    } else {
        return 0.0000001f;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return nil;
    }
    ContactGroupView *headView = [ContactGroupView headerViewWithTableView:tableView];
    [headView createWith:self.dataArr[section - 1] inSection:section];
    headView.ContactGroupViewBlock = ^(){
        if (section == 1) {
            if (self.CellDidSelectedBlock) {
                self.CellDidSelectedBlock(CellClickTypeDevice, nil);
            }
        } else if (section == 2) {
            if (self.CellDidSelectedBlock) {
                self.CellDidSelectedBlock(CellClickTypeAddressBook, nil);
            }
        } else {
            GroupModel *model = self.dataArr[section - 1];
            model.display = !model.isDisplay;
            NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:section];
            [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
        }
    };
    return headView;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (self.CellDidSelectedBlock) {
        self.CellDidSelectedBlock(CellClickTypeHiddenKeboard,nil);
    }
}

@end
