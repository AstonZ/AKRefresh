//
//  AKRefreshExtImageView.m
//  AKRefresh
//
//  Created by Aston Z on 15/12/19.
//  Copyright © 2015年 Aston. All rights reserved.
//

#import "AKRefreshExtImageView.h"
@implementation AKRefreshExtImageView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.image = [UIImage imageNamed:@"test00.jpg"];
        self.clipsToBounds = YES;
    }
    return self;
}


@end
