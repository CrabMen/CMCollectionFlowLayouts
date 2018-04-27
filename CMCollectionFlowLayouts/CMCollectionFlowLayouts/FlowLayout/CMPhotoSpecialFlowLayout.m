//
//  CMPhotoSpecialFlowLayout.m
//  CMCollectionFlowLayouts
//
//  Created by 智借iOS on 2018/4/27.
//  Copyright © 2018年 CrabMan. All rights reserved.
//

#import "CMPhotoSpecialFlowLayout.h"

@implementation CMPhotoSpecialFlowLayout

- (void)prepareLayout {
    
    CGFloat itemH = 100;
    
    CGFloat itemW = self.collectionView.bounds.size.width;
    
//    CGFloat margin = (self.collectionView.bounds.size.width -  itemW) * 0.5;
    
    self.itemSize = CGSizeMake(itemW, itemH);
    
    //    self.minimumInteritemSpacing = margin * 0.5;
    
    //    self.minimumLineSpacing =  10;
    
    
    self.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {

    NSArray *attrs = [super layoutAttributesForElementsInRect:rect];

    NSArray *itemAttrs = [[NSArray alloc]initWithArray:attrs copyItems:YES];

    CGFloat screenCenterY = 300;

    for (UICollectionViewLayoutAttributes *attribute in itemAttrs) {

        CGFloat deltaCenterY = fabs(screenCenterY - attribute.center.y);

        CGFloat scale = fabs(deltaCenterY/self.collectionView.bounds.size.height * 0.5 - 1) ;

        attribute.transform = CGAffineTransformMakeScale(1, scale);
    }

    return itemAttrs;


}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    
    return YES;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    NSLog(@"偏移量：%@",NSStringFromCGPoint(proposedContentOffset));
    
    CGFloat screenCenterY = proposedContentOffset.y + self.collectionView.bounds.size.height * 0.5;
    
    
    CGRect visibleRect = CGRectZero;
    visibleRect.size = self.collectionView.bounds.size;
    visibleRect.origin = proposedContentOffset;
    
    //获得所有的attribute数组
    NSArray *itemAttrs = [self layoutAttributesForElementsInRect:visibleRect];
    
    CGFloat minMargin = MAXFLOAT;
    
    for (UICollectionViewLayoutAttributes *attr in itemAttrs) {
        CGFloat deltaMargin = attr.center.y - screenCenterY;
        
        if (fabs(deltaMargin) < fabs(minMargin)) {
            minMargin = deltaMargin;
        }
        
    }
    
    return CGPointMake(proposedContentOffset.x , proposedContentOffset.y + minMargin);
    
}


@end
