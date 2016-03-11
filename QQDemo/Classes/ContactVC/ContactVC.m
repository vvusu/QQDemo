//
//  ContactVC.m
//  QQDemo
//
//  Created by vvusu on 3/9/16.
//  Copyright © 2016 vvusu. All rights reserved.
//

#import "ContactVC.h"
#import "ODRefreshControl.h"
#import "ContactDataSource.h"

@interface ContactVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) ContactDataSource *contactDataSource;

@end

@implementation ContactVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.navigationItem.titleView = nil;
    self.tabBarController.navigationItem.title = @"联系人";
}

- (void)setupViews {
    self.tableView.delegate = self.contactDataSource;
    self.tableView.dataSource = self.contactDataSource;
}

- (ContactDataSource *)contactDataSource {
    if (!_contactDataSource) {
        _contactDataSource = [[ContactDataSource alloc]init];
        _contactDataSource.tableView = self.tableView;
//        __weak typeof(self) wSelf = self;
        _contactDataSource.CellDidSelectedBlock = ^(CellClickType clickType,id entity){
            switch (clickType) {
                case CellClickTypeDevice:
                    NSLog(@"我的设备被点击");
                    break;
                case CellClickTypeAddressBook:
                    NSLog(@"我的通讯录被点击");
                    break;
                case CellClickTypeContact:
                    NSLog(@"我的好友被点击");
                    break;
            }
        };
    }
    return _contactDataSource;
}

@end
