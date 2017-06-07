//
//  CMPhoto3DFlowLayout.m
//  CMCollectionWaterFall
//
//  Created by CrabMan on 2017/5/2.
//  Copyright © 2017年 CrabMan. All rights reserved.
//

#import "CMPhoto3DFlowLayout.h"

@implementation CMPhoto3DFlowLayout

- (void)prepareLayout {

    CGFloat itemH = self.collectionView.bounds.size.height * 0.8;
    
    CGFloat itemW = self.collectionView.bounds.size.height * 0.6;
    
    CGFloat margin = (self.collectionView.bounds.size.width -  itemW) * 0.5;
    
    self.itemSize = CGSizeMake(itemW, itemH);
    
//    self.minimumInteritemSpacing = margin * 0.5;
    
//    self.minimumLineSpacing =  10;

    
    self.sectionInset = UIEdgeInsetsMake(0, margin, 0, margin);

}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttribqutesForElementsInRect:(CGRect)rect {

    NSArray *attrs = [super layoutAttributesForElementsInRect:rect];
    
    NSArray *itemAttrs = [[NSArray alloc]initWithArray:attrs copyItems:YES];
    
    CGFloat screenCenterX = self.collectionView.contentOffset.x + self.collectionView.bounds.size.width * 0.5;
    
    for (UICollectionViewLayoutAttributes *attribute in itemAttrs) {
        
        CGFloat deltaCenterX = fabs(screenCenterX - attribute.center.x);
        
        CGFloat scale = fabs(deltaCenterX/self.collectionView.bounds.size.width * 0.5 - 1.1) ;
        
        attribute.transform = CGAffineTransformMakeScale(scale, scale);
    }
    
    return itemAttrs;


}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    
    return YES;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    NSLog(@"偏移量：%@",NSStringFromCGPoint(proposedContentOffset));
    
    CGFloat screenCenterX = proposedContentOffset.x + self.collectionView.bounds.size.width * 0.5;
    
    
    CGRect visibleRect = CGRectZero;
    visibleRect.size = self.collectionView.bounds.size;
    visibleRect.origin = proposedContentOffset;
    
    
    //获得所有的attribute数组
    NSArray *itemAttrs = [self layoutAttributesForElementsInRect:visibleRect];
    
    CGFloat minMargin = MAXFLOAT;
    
    for (UICollectionViewLayoutAttributes *attr in itemAttrs) {
        CGFloat deltaMargin = attr.center.x - screenCenterX;
      
        if (fabs(deltaMargin) < fabs(minMargin)) {
            minMargin = deltaMargin;
        }
        
    }
    
    return CGPointMake(proposedContentOffset.x +minMargin, proposedContentOffset.y);

}



@end
