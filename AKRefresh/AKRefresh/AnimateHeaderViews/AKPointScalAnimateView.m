//
//  AKPointScalAnimateView.m
//  AKRefresh
//
//  Created by Aston Z on 15/12/19.
//  Copyright © 2015年 Aston. All rights reserved.
//

#import "AKPointScalAnimateView.h"

@interface AKPointScalAnimateView ()

@property (nonatomic, strong) CALayer *pointLayer;

@property (nonatomic, strong) CABasicAnimation *scaleAnimation;

@end

@implementation AKPointScalAnimateView{
    BOOL _isAnimating;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self builUPUI];
    }
    return self;
}

- (void)builUPUI
{
    _pointLayer = [CALayer layer];
    _pointLayer.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:.7].CGColor;
    
    
    CGFloat pWid = 30.f;
    _pointLayer.bounds = CGRectMake(0, 0, pWid, pWid);
    _pointLayer.position = CGPointMake(CGRectGetWidth(self.bounds)/2,CGRectGetHeight(self.bounds)/2);
    _pointLayer.cornerRadius = pWid/2.f;
    [self.layer addSublayer:_pointLayer];
    
    
    
    
    
}

/** Name tells **/
- (void)startAnimation
{
    if (_isAnimating) {
        return;
    }
    _isAnimating = YES;
    self.pointLayer.transform = CATransform3DIdentity;
    
    [self.pointLayer addAnimation:self.scaleAnimation forKey:@"scale"];
}

- (void)stopAnimationCompletion:(void(^)(void))completion
{
    [self.pointLayer removeAllAnimations];
    self.pointLayer.transform = CATransform3DIdentity;
    _isAnimating = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (completion) {
            completion();
        }
    });
}

- (void)setScrollOffsetY:(CGFloat)scrollOffsetY isScrollingUP:(BOOL)isScrollingUP isUserDragging:(BOOL)isDragging
{
    
    if (_isAnimating) {
        return;
    }
    
    if (scrollOffsetY > 0) {
        if (!CATransform3DIsIdentity(self.pointLayer.transform)) {
            self.pointLayer.transform = CATransform3DIdentity;
        }
        return;
    }
    
    if ((int)scrollOffsetY %5 !=0) {
        return;
    }
    
    CGFloat scale = ABS(scrollOffsetY)/CGRectGetHeight(self.bounds);
    scale = MIN(scale, 1.5f);
    self.pointLayer.transform = CATransform3DMakeScale(scale, scale, 1.0);
    
    
    
    
}

- (CABasicAnimation *)scaleAnimation
{
    if (_scaleAnimation == nil) {
        _scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        _scaleAnimation.duration = 0.35;
        _scaleAnimation.toValue = @1.5f;
        _scaleAnimation.repeatCount = INFINITY;
        _scaleAnimation.autoreverses = YES;
        _scaleAnimation.removedOnCompletion = NO;
    }
    return _scaleAnimation;
}




@end
