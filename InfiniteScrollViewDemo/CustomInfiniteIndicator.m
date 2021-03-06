//
//  CustomInfiniteIndicator.m
//  InfiniteScrollViewDemo
//
//  Created by pronebird on 27/11/14.
//  Copyright (c) 2014 codeispoetry.ru. All rights reserved.
//

#import "CustomInfiniteIndicator.h"

static NSString* const kSpinAnimationKey = @"SpinAnimation";

@interface CustomInfiniteIndicator()

@property (nonatomic) CAShapeLayer* circle;

@end

@implementation CustomInfiniteIndicator

- (id)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        self.layer.contentsScale = [UIScreen mainScreen].scale;
    }
    return self;
}

- (CAShapeLayer*)circle {
    if(!_circle) {
        _circle = [CAShapeLayer layer];
        _circle.fillColor = [UIColor colorWithRed:0.173 green:0.243 blue:0.314 alpha:1].CGColor; /*#2c3e50*/
        _circle.contentsScale = self.layer.contentsScale;
        [self.layer addSublayer:_circle];
    }
    return _circle;
}

- (void)startAnimating {
    CGFloat radius = MIN(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)) * 0.5;
    CGPoint center = CGPointMake(radius, radius);
    UIBezierPath* bezierPath = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:0 endAngle:M_PI*2 clockwise:YES];
    
    self.circle.bounds = self.bounds;
    self.circle.path = bezierPath.CGPath;
    self.circle.position = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    
    CABasicAnimation* scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    CABasicAnimation* opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    CAAnimationGroup* animationGroup = [CAAnimationGroup animation];
    
    scaleAnimation.fromValue = @0.0;
    scaleAnimation.toValue = @1.0;
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    opacityAnimation.fromValue = @1.0;
    opacityAnimation.toValue = @0.0;
    opacityAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:1 :0 :0.65 :1];
    
    animationGroup.duration = 1.0;
    animationGroup.repeatCount = INFINITY;
    animationGroup.animations = @[ scaleAnimation, opacityAnimation ];
    
    [self.circle addAnimation:animationGroup forKey:kSpinAnimationKey];
}

- (void)stopAnimating {
    [self.circle removeAnimationForKey:kSpinAnimationKey];
}

@end
