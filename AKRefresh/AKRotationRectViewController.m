//
//  AKRotationRectViewController.m
//  AKRefresh
//
//  Created by Aston Z on 15/12/19.
//  Copyright © 2015年 Aston. All rights reserved.
//

#import "AKRotationRectViewController.h"

@implementation AKRotationRectViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    __weak typeof(self) wkSelf = self;

    self.tableView.refreshHeader = [[AKRefreshHeaderView alloc] initWithScrollView:self.tableView registerAnimatedHeaderViewClass:NSClassFromString(@"AKRotateRectAnimateView") extentionView: self.hasExtView? NSClassFromString(@"AKHeightLabelExtView"):nil refreshAction:^(AKRefreshHeaderView *headerView) {
        [wkSelf actionRefresh];
    }];
}

@end
