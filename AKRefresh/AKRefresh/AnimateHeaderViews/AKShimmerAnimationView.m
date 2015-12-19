//
//  AKShimmerAnimationView.m
//  AKRefresh
//
//  Created by Aston Z on 15/12/16.
//  Copyright © 2015年 Aston. All rights reserved.
//

#import "AKShimmerAnimationView.h"
#import "FBShimmeringView.h"
#import "UIView+Twinkle.h"

extern 

@interface AKShimmerAnimationView ()


@property (nonatomic, strong) FBShimmeringView *shimmerView;
@property (nonatomic, weak) UILabel *logoLabel;
@end


@implementation AKShimmerAnimationView


#pragma mark -
#pragma mark ---------Init
- (instancetype)init
{
    if (self = [super init]) {
         NSLog(@"Warning ! AKShimmerAnimationView  Please Use Init With Frame Instead !!" );
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blackColor];
        _shimmerView = [[FBShimmeringView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _shimmerView.shimmering = NO;
        _shimmerView.shimmeringBeginFadeDuration = 2;
        _shimmerView.shimmeringOpacity = 1.0;
        _shimmerView.shimmeringAnimationOpacity = 1.0;
        _shimmerView.shimmeringPauseDuration = 0;
        _shimmerView.shimmeringSpeed = 200;
        _shimmerView.alpha = 0.0;
        
        CGFloat lbWid = 100;
        CGFloat lbHeight = 42;
        CGRect lbFrame = CGRectMake(CGRectGetMidX(frame) - lbWid/2.0 , CGRectGetMidY(frame) - lbHeight/2.0, lbWid, lbHeight);
        
        UILabel *label = [[UILabel alloc] initWithFrame:lbFrame];
        label.text = @" Aston ";
        label.font = [UIFont systemFontOfSize:40];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor clearColor];
        _shimmerView.contentView = label;
        [self addSubview:_shimmerView];
        _logoLabel = label;
    }
    return self;
}

#pragma mark -
#pragma mark ---------HeaderProtocol

- (void)setScrollOffsetY:(CGFloat)scrollOffsetY isScrollingUP:(BOOL)isScrollingUP isUserDragging:(BOOL)isDragging
{
    
    
    if ((int)scrollOffsetY%5!=0) {
        return;
    }
    
    if (_shimmerView.shimmering == YES) {
        self.shimmerView.alpha = 1.f;
        return;
    }

    
    if (isDragging == NO) {
        return;
    }
    
    if (scrollOffsetY >0) {
        self.shimmerView.alpha = 0;
        return;
    }

    
    
    if (!isScrollingUP && _shimmerView.shimmering == NO) {
        CGFloat Height = CGRectGetHeight(self.bounds);
        float percentage = ABS(scrollOffsetY)/Height;
        self.shimmerView.alpha = MIN(percentage, 1.0);
    }
    
    
    

}

- (void)startAnimation
{
    self.shimmerView.alpha = 1.0f;
    _shimmerView.shimmeringOpacity = 0.4;
    _shimmerView.shimmering = YES;
    [self.logoLabel startTwinkle];
}



- (void)stopAnimationCompletion:(void (^)(void))completion
{
    _shimmerView.shimmering = NO;
    [self.logoLabel stopTwinkle];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (completion) {
            completion();
        }
    });
}




@end
