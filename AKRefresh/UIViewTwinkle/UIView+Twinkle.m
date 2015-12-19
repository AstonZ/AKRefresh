//
//  UIView+Twinkle.m
//  Twinkle
//
//  Created by v－ling on 15/9/6.
//  Copyright (c) 2015年 LiuZeChen. All rights reserved.
//

#import "UIView+Twinkle.h"
#import "TwinkleLayer.h"
#import "TwinkleLayer+Anim.h"
#import <objc/runtime.h>
static const char kTinkleTimerKey;
static const char kTinkleLayerArray;
@implementation UIView (Twinkle)

- (CADisplayLink *)twinkleTimer
{
    return  objc_getAssociatedObject(self, &kTinkleTimerKey);
}

- (void)setTwinkleTimer:(CADisplayLink *)timer
{
    objc_setAssociatedObject(self, &kTinkleTimerKey, timer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableArray *)twinkleLayerArray
{
    return  objc_getAssociatedObject(self, &kTinkleLayerArray);

}

- (void)setTwinkleLayerArray:(NSMutableArray *)array
{
    objc_setAssociatedObject(self, &kTinkleLayerArray, array, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}

- (void)twinkle {

    NSMutableArray *twinkleLayers = [self twinkleLayerArray];
    if (twinkleLayers == nil) {
        twinkleLayers = [NSMutableArray array];
        [self setTwinkleLayerArray:twinkleLayers];
    }
    UInt32 upperBound = 10;
    UInt32 lowerBound = 5;
    UInt8 count = (UInt8)(arc4random_uniform(upperBound) + lowerBound);

    for (int i = 0; i < count; i++) {
        TwinkleLayer *twinkleLayer = [[TwinkleLayer alloc] init];

        CGFloat x = arc4random_uniform((UInt32)self.layer.bounds.size.width);
        CGFloat y = arc4random_uniform((UInt32)self.layer.bounds.size.height);

        twinkleLayer.position = CGPointMake(x, y);
        twinkleLayer.opacity = 0;
        [twinkleLayers addObject:twinkleLayer];
        [self.layer addSublayer:twinkleLayer];

        [twinkleLayer addPositionAnimation];
        [twinkleLayer addRotationAnimation];
        [twinkleLayer addFadeInOutAnimation:CACurrentMediaTime() + (CFTimeInterval)0.15 *(i)];
    }

    [twinkleLayers removeAllObjects];
}

- (void)startTwinkle
{
    CADisplayLink *disLinkTimer = [self twinkleTimer];
    if (disLinkTimer == nil) {
        disLinkTimer =  [CADisplayLink displayLinkWithTarget:self selector:@selector(actionEveryFrameCall)];
        disLinkTimer.frameInterval = 60;
        [disLinkTimer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
        [self setTwinkleTimer:disLinkTimer];
    }
    
    if ([disLinkTimer isPaused]) {
        disLinkTimer.paused = NO;
    }
}




//帧变化
- (void)actionEveryFrameCall
{
    NSMutableArray *twinkleLayers = [self twinkleLayerArray];
    
    if (twinkleLayers == nil) {
        twinkleLayers = [NSMutableArray array];
        [self setTwinkleLayerArray:twinkleLayers];
    }

    UInt32 upperBound = 10;
    UInt32 lowerBound = 5;
    UInt8 count = (UInt8)(arc4random_uniform(upperBound) + lowerBound);
    
    CGFloat maxWid = self.bounds.size.width;
    CGFloat maxY = self.bounds.size.height;
    
    
//    CGFloat appearHeight = 40;
//    CGFloat minY = CGRectGetMidX(self.bounds) - appearHeight/2.0;
    
    CGFloat midX = CGRectGetMidX(self.bounds);
    int range = 250;
    CGFloat startX = midX - range/2.0;

    
    for (int i = 0; i < count; i++) {
        TwinkleLayer *twinkleLayer = [[TwinkleLayer alloc] init];
        CGFloat x = arc4random_uniform((UInt32)maxWid);
        CGFloat y = arc4random()%(int)maxY ;
        y = 30 + arc4random()%20;
        x = startX + arc4random()%range;

        twinkleLayer.position = CGPointMake(x, y);
        twinkleLayer.opacity = 0;
        [twinkleLayers addObject:twinkleLayer];
        [self.layer addSublayer:twinkleLayer];
        
        [twinkleLayer addPositionAnimation];
        [twinkleLayer addRotationAnimation];
        [twinkleLayer addFadeInOutAnimation:CACurrentMediaTime() + (CFTimeInterval)0.15 *(i)];
    }
    
}






- (void)stopTwinkle
{
    NSMutableArray *twinkleArray = [self twinkleLayerArray];
    if (twinkleArray == nil || twinkleArray.count == 0) {
        return;
    }
    
    [[self twinkleTimer] invalidate];
    [self setTwinkleTimer:nil];

    [twinkleArray makeObjectsPerformSelector:@selector(removeAllAnimations)];
    
    //fade out the twinkles
    [UIView animateWithDuration:0.3 animations:^{
        for (TwinkleLayer *layer in twinkleArray) {
            layer.opacity = 0.f;
        }
        
    } completion:^(BOOL finished) {
        if (finished) {
            [twinkleArray makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
        }
    }];
    
}


@end
