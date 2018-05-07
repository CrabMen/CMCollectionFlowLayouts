//
//  UIView+CMCommon.m
//  CMCollectionFlowLayouts
//
//  Created by 智借iOS on 2018/5/7.
//  Copyright © 2018年 CrabMan. All rights reserved.
//

#import "UIView+CMCommon.h"

@implementation UIView (CMCommon)


- (void)setCm_x:(CGFloat)cm_x
{
    CGRect frame = self.frame;
    frame.origin.x = cm_x;
    self.frame = frame;
}

- (CGFloat)cm_x
{
    return self.frame.origin.x;
}

- (void)setCm_y:(CGFloat)cm_y
{
    CGRect frame = self.frame;
    frame.origin.y = cm_y;
    self.frame = frame;
}

- (CGFloat)cm_y
{
    return self.frame.origin.y;
}

- (void)setCm_w:(CGFloat)cm_w
{
    CGRect frame = self.frame;
    frame.size.width = cm_w;
    self.frame = frame;
}

- (CGFloat)cm_w
{
    return self.frame.size.width;
}

- (void)setCm_h:(CGFloat)cm_h
{
    CGRect frame = self.frame;
    frame.size.height = cm_h;
    self.frame = frame;
}

- (CGFloat)cm_h
{
    return self.frame.size.height;
}

- (void)setCm_size:(CGSize)cm_size
{
    CGRect frame = self.frame;
    frame.size = cm_size;
    self.frame = frame;
}

- (CGSize)cm_size
{
    return self.frame.size;
}

- (void)setCm_origin:(CGPoint)cm_origin
{
    CGRect frame = self.frame;
    frame.origin = cm_origin;
    self.frame = frame;
}

- (CGPoint)cm_origin
{
    return self.frame.origin;
}

- (void)setCm_centerX:(CGFloat)cm_centerX {
    
    CGPoint center = self.center;
    center.x = cm_centerX;
    self.center = center;
    
}

- (CGFloat)cm_centerX {
    
    return self.center.x;
}


- (void)setCm_centerY:(CGFloat)cm_centerY {
    
    CGPoint center = self.center;
    center.y = cm_centerY;
    self.center = center;
    
}

- (CGFloat)cm_centerY {
    
    return self.center.y;
}


@end
