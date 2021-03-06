//
//  CMWalletCell.m
//  CMCollectionFlowLayouts
//
//  Created by 智借iOS on 2018/5/2.
//  Copyright © 2018年 CrabMan. All rights reserved.
//

#import "CMWalletCell.h"
@interface CMWalletCell ()

/**
 标题label
 */
@property (nonatomic,strong) UILabel *titleLabel;


@property (nonatomic,strong) UILongPressGestureRecognizer *longGesture;


@end


@implementation CMWalletCell

- (void)setLongPressInterval:(NSTimeInterval)longPressInterval {
    
    _longPressInterval = longPressInterval;
    
    self.longGesture.minimumPressDuration = _longPressInterval;
    
    
}
- (UILongPressGestureRecognizer *)longGesture {
    
    if (!_longGesture) {
        _longGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(handleLongPressGestureRecognizer:)];
        
        _longGesture.minimumPressDuration = self.longPressInterval ? self.longPressInterval : 0.50f;
    }
    
    return _longGesture;
    
    
}

-(UILabel *)titleLabel {
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 30)];
     
        _titleLabel.textColor = [UIColor blackColor];
        
        _titleLabel.font = [UIFont systemFontOfSize:16];
    }
    
    return _titleLabel;
}

- (void)setTitle:(NSString *)title {
    
    _title = title;
    
    self.titleLabel.text = title;
    
    [self.titleLabel sizeToFit];
    
    CGPoint center = self.titleLabel.center;
    
    center.x = self.contentView.center.x;
    
    self.titleLabel.center = center;
}






- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    
    self.contentView.backgroundColor = randomColor;
    [self roundCorner];
    
    [self initSubViews];
    
    
    
    
}

- (void)initSubViews {
    [self addGestureRecognizer:self.longGesture];
    
    [self.contentView addSubview:self.titleLabel];
    
}

- (void)roundCorner {
    
    self.layer.mask = nil;

    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc]init];
    shapeLayer.frame = self.bounds;
    UIBezierPath *bezierPath = [ UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(16, 0)];

    shapeLayer.path = bezierPath.CGPath;

    self.layer.mask = shapeLayer;
    
    
//    self.layer.mask = nil;
//    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
//    layer.frame = self.bounds;
//    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(16, 0)];
//    layer.path = path.CGPath;
//    self.layer.mask = layer;
    
}


- (void)handleLongPressGestureRecognizer:(UILongPressGestureRecognizer *)gesture {
    
   
    if ([self.delegate respondsToSelector:@selector(collectionViewCell:handleLongPressGestureRecognizer:)]) {
        [self.delegate collectionViewCell:self handleLongPressGestureRecognizer:gesture];
    }
    
}



@end
