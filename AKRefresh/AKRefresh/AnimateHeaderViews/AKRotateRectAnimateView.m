//
//  AKRefreshAnimatingView.m
//  AKRefresh
//
//  Created by Aston Z on 15/12/10.
//  Copyright © 2015年 Aston. All rights reserved.
//

#import "AKRotateRectAnimateView.h"





@interface AKRotateRectAnimateView ()


extern CGFloat const kHeadAnimatedHeight;

@property (nonatomic, strong) CALayer *animatedLayer;
@property (nonatomic, strong) CABasicAnimation *roationAnimation;
@property (nonatomic, copy) void(^blockAnimationStopped)(void);
@end

@implementation AKRotateRectAnimateView

- (void)startAnimation
{
    [self.animatedLayer addAnimation:self.roationAnimation forKey:@"refreshing"];
}

- (void)stopAnimationCompletion:(void(^)(void))completion
{
    [self.animatedLayer removeAllAnimations];
    self.blockAnimationStopped = completion;
    [UIView animateWithDuration:0.2 animations:^{
        self.animatedLayer.transform = CATransform3DIdentity;
    }];
}


- (void)setScrollOffsetY:(CGFloat)scrollOffsetY isScrollingUP:(BOOL)isScrollingUP isUserDragging:(BOOL)isDragging;
{
    if (isDragging == NO) {
        return;
    }
    if (scrollOffsetY >= 0) {
        if (CATransform3DIsIdentity(self.animatedLayer.transform) == NO) {
            self.animatedLayer.transform = CATransform3DIdentity;
        }
        return;
    }
    
    //每拖动一个像素，滚动的角度， 拖动kHeadAnimatedHeight的时候，刚好旋转一周
     CGFloat anglePerPix = 2*M_PI/CGRectGetHeight(self.bounds);
    
     self.animatedLayer.transform = CATransform3DMakeRotation(scrollOffsetY * anglePerPix, 0, 0, 1);
}


- (CALayer *)animatedLayer
{
    if (_animatedLayer == nil) {
        _animatedLayer = [CALayer layer] ;
        _animatedLayer.backgroundColor = [UIColor redColor].CGColor;
        CGFloat veiwWidth = 40.f;
        _animatedLayer.frame = CGRectMake(CGRectGetWidth(self.bounds)/2.0 - veiwWidth/2.0, CGRectGetHeight(self.bounds)/2.0 - veiwWidth/2.0,veiwWidth , veiwWidth);
        [self.layer addSublayer:_animatedLayer];
    }
    return _animatedLayer;
}


- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (CATransform3DIsIdentity(self.animatedLayer.transform) == NO) {
        self.animatedLayer.transform = CATransform3DIdentity;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.blockAnimationStopped) {
            self.blockAnimationStopped();
        }
    });
}


- (CABasicAnimation *)roationAnimation
{
    if (_roationAnimation == nil) {
        _roationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        _roationAnimation.byValue = @(M_PI * 2);
        _roationAnimation.duration = 1.0;
        _roationAnimation.removedOnCompletion = NO;
        _roationAnimation.fillMode = kCAFillModeForwards;
        _roationAnimation.repeatCount = INFINITY;
        _roationAnimation.delegate  = self;
    }
    return _roationAnimation;
}

+ (CGFloat)heightForAnimatingView
{
    return 120.f;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
