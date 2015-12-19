//
//  AKScalPointViewController.m
//  AKRefresh
//
//  Created by Aston Z on 15/12/19.
//  Copyright © 2015年 Aston. All rights reserved.
//

#import "AKScalPointViewController.h"

@implementation AKScalPointViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    __weak typeof(self) wkSelf = self;

    self.tableView.refreshHeader = [[AKRefreshHeaderView alloc] initWithScrollView:self.tableView registerAnimatedHeaderViewClass:NSClassFromString(@"AKPointScalAnimateView") extentionView: self.hasExtView? NSClassFromString(@"AKRefreshExtImageView"):nil refreshAction:^(AKRefreshHeaderView *headerView) {
        [wkSelf actionRefresh];
    }];
    
    
    
}


@end
