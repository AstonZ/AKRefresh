//
//  AKStaticHeaderViewController.m
//  AKRefresh
//
//  Created by Aston Z on 15/12/21.
//  Copyright © 2015年 Aston. All rights reserved.
//

#import "AKStaticHeaderViewController.h"

@implementation AKStaticHeaderViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    __weak typeof(self) wkSelf = self;
        if (self.hasExtView) {
        self.tableView.refreshHeader = [AKRefreshHeaderView refreshHeaderWithScrollView:self.tableView refreshAction:^(AKRefreshHeaderView *headerView) {
            [wkSelf actionRefresh];
        }];
    }else{
        self.tableView.refreshHeader = [AKRefreshHeaderView refreshHeaderOnlyAnimateViewWithScrollView:self.tableView refreshAction:^(AKRefreshHeaderView *headerView) {
            [wkSelf actionRefresh];
        }];
    }

}
@end
