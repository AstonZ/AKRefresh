//
//  AKShimmerViewController.m
//  AKRefresh
//
//  Created by Aston Z on 15/12/19.
//  Copyright © 2015年 Aston. All rights reserved.
//

#import "AKShimmerViewController.h"

@implementation AKShimmerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    __weak typeof(self) wkSelf = self;
    self.tableView.refreshHeader = [AKRefreshHeaderView
                                    refreshHeaderWithScrollView:self.tableView
                                    registerAnimatedHeaderViewClass:NSClassFromString(@"AKShimmerAnimationView")
                                    extentionView: self.hasExtView? NSClassFromString(@"AKRefreshExtImageView"):nil
                                    refreshAction:^(AKRefreshHeaderView *headerView) {
            [wkSelf actionRefresh];
        }];


    

}





@end
