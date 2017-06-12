//
//  CMCircleFlowLayout.m
//  CMCollectionFlowLayouts
//
//  Created by CrabMan on 2017/6/7.
//  Copyright © 2017年 CrabMan. All rights reserved.
//


#import "CMCircleFlowLayout.h"
// item 大小 55 * 55
#define ItemWidth 55
#define ItemHieght ItemWidth
#define RightMargin 5



#pragma mark ---- 自定义Attributes类

@interface CMCircleFlowLayoutAttributes : UICollectionViewLayoutAttributes


/** 锚点,圆圈圆心*/
@property (nonatomic, assign) CGPoint anchorPoint;
/** 角度*/
@property (nonatomic, assign) CGFloat angle;


@end


@implementation CMCircleFlowLayoutAttributes

- (instancetype)init {
    if (self = [super init]) {
        self.anchorPoint = CGPointMake(0.5, 0.5);
        self.angle = 0;
    }
    return self;
}

- (void)setAngle:(CGFloat)angle {
    _angle = angle;
    
    self.zIndex = angle * 1000000;
    // 将角度同时用做item 的旋转
    self.transform = CGAffineTransformMakeRotation(angle);
}
// UICollectionViewLayoutAttributes 实现 <NSCoping> 协议
- (id)copyWithZone:(NSZone *)zone {
    CMCircleFlowLayoutAttributes *copyAttributes = (CMCircleFlowLayoutAttributes *)[super copyWithZone:zone];
    copyAttributes.anchorPoint = self.anchorPoint;
    copyAttributes.angle = self.angle;
    return copyAttributes;
}

@end






@interface CMCircleFlowLayout ()



// 单位夹角
@property (nonatomic, assign) CGFloat anglePerItem;

/**attributes数组*/
@property (nonatomic,strong) NSMutableArray <CMCircleFlowLayoutAttributes *> *attributesArr;

/**
 *  单位偏移角度
 */
@property (nonatomic, assign) CGFloat angle;

/**
 *  总偏移角度
 */
@property (nonatomic, assign) CGFloat angleAtExtreme;

@end

@implementation CMCircleFlowLayout

- (instancetype)init {
    if (self = [super init]) {
        [self initial];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initial];
    }
    return self;
}

- (void)initial {
    self.itemSize = CGSizeMake(ItemWidth, ItemHieght);
    self.radius = (CGRectGetWidth([UIScreen mainScreen].bounds))* 0.5f - ItemWidth - RightMargin;
    self.anglePerItem = M_PI_4;

}

+ (Class)layoutAttributesClass {


    return [CMCircleFlowLayoutAttributes class];

}



- (void)prepareLayout {
    
    [super prepareLayout];
    
    if (!self.collectionView) return;
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    
    NSMutableArray *attributesList = [NSMutableArray array];
    
    CGFloat centerX = self.collectionView.contentOffset.x + CGRectGetWidth(self.collectionView.bounds) * 0.5;
    CGFloat centerY = self.collectionView.contentOffset.y + CGRectGetHeight(self.collectionView.bounds) * .5f;

    
    CGFloat anchorPointY =  -(self.radius) / self.itemSize.height;

    
    for (NSInteger i = 0; i < itemCount; i++) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        
        CMCircleFlowLayoutAttributes *attributes = [CMCircleFlowLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        
        attributes.size = self.itemSize;
        CGFloat changeAngle =  M_PI + M_PI_4;

        attributes.center = CGPointMake(
                                        centerX + self.radius * cosf(-(self.anglePerItem*i + self.offsetAngle - changeAngle)),
                                        centerY + self.radius * sinf(-(self.anglePerItem*i + self.offsetAngle - changeAngle))                                        );
        NSLog(@"cell布局的中心点X:%f;Y:%f",attributes.center.x,attributes.center.y);
        attributes.angle = self.anglePerItem * i + self.angle - changeAngle;
        attributes.anchorPoint = CGPointMake(0.5, anchorPointY);

        [attributesList addObject:attributes];
        
        
    }
    
    self.attributesArr = [attributesList copy];


}

//重新设置item的rect并返回
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {

    return self.attributesArr;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    return self.attributesArr[indexPath.row];
}

- (CGFloat)offsetAngle{
    NSInteger numberOfItems = [self.collectionView numberOfItemsInSection:0];
    if (numberOfItems > 0) {
        NSInteger lastItem = numberOfItems - 7;
        //滚动的总度数
        CGFloat angleTotal = lastItem * self.anglePerItem;
        //计算collectionView滑动的距离
        CGFloat offsetWidth = self.collectionView.contentSize.width - self.collectionView.bounds.size.width;
        //偏移的度数 ＝ 滚动的总度数 / contentOffsetX所占的比例，即 result = angleTotal * (contentOffsetX / offsetWidth)
        //(contentOffsetX / offsetWidth)为单位偏移量所占的比例
        return -angleTotal * (self.collectionView.contentOffset.x / offsetWidth);
    }
    return 0;
}


- (CGSize)collectionViewContentSize{
    NSInteger numberOfItem = [self.collectionView numberOfItemsInSection:0];
    return CGSizeMake(ItemWidth * numberOfItem, self.collectionView.bounds.size.height);
}


- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}
//- (CGFloat)angle {
//    return self.angleAtExtreme * self.collectionView.contentOffset.x / ([self collectionViewContentSize].width - CGRectGetWidth(self.collectionView.bounds)) - M_PI_2;
//}
//
//- (CGFloat)angleAtExtreme {
//    return [self.collectionView numberOfItemsInSection:0] > 0 ?
//    -([self.collectionView numberOfItemsInSection:0] - 5) * self.anglePerItem : 0;
//}


@end


