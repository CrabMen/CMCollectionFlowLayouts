//
//  CMWalletFlowLayout.m
//  CMCollectionFlowLayouts
//
//  Created by CrabMan on 2018/4/30.
//  Copyright © 2018年 CrabMan. All rights reserved.
//

#import "CMWalletFlowLayout.h"


#define CMCollectionW (self.collectionView.frame.size.width)
#define CMCollectionH (self.collectionView.frame.size.height)

#define CMCellH 200 /// cell 高度
#define CMFoldCellMinSpace 100 // the min space between cells
#define CMExtendCellMinSpace 10
#define CMExtendedCellFooter 80

@interface CMWalletFlowLayout ()


/**保存layoutattribute的数组*/
@property (nonatomic,strong) NSMutableArray *layoutAttrs;

@property (nonatomic,strong) NSIndexPath *currentIndexPath;

@property (nonatomic,assign) BOOL isExtend;

@end

@implementation CMWalletFlowLayout

- (NSMutableArray *)layoutAttrs {
    if (!_layoutAttrs) {
        _layoutAttrs = [NSMutableArray array];
    }
    
    return _layoutAttrs;
}


- (void)prepareLayout {
    
    [super prepareLayout];
    
    UIEdgeInsets inset = self.collectionView.contentInset;
    self.itemSize = CGSizeMake(CMCollectionW - inset.right - inset.left, CMCellH);
    self.minimumLineSpacing = CMFoldCellMinSpace - CMCellH;
    
    
}


- (NSArray *)resolveCellAttributes {
    
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    
    CGFloat offsetY = self.collectionView.contentOffset.y;
    
    UIEdgeInsets contentInset = self.collectionView.contentInset;
    
    
    //展开后底部多余的index
    NSInteger shrinkCellIndex = 0;
    
    
    for (NSInteger row = 0; row < itemCount; row++) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:row inSection:0];
        UICollectionViewLayoutAttributes *att = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        CGRect cellRect = CGRectMake(0, MAX(offsetY, row * CMFoldCellMinSpace), CMCollectionW - contentInset.right - contentInset.left, CMCellH);
        
        CGFloat top = shrinkCellIndex * CMExtendCellMinSpace + 20;
        
        //如果点击展开后的布局
        if (self.isExtend && self.currentIndexPath.item == indexPath.item) {
            cellRect = CGRectMake(0, offsetY, CMCollectionW - contentInset.right - contentInset.left, CMCollectionH - CMExtendedCellFooter);
        } else if (self.isExtend && self.currentIndexPath.item != indexPath.item) {
            
            
            cellRect = CGRectMake((CMCollectionW - contentInset.right - contentInset.left)/10,offsetY + CMCollectionH - CMExtendedCellFooter + top, (CMCollectionW - contentInset.right - contentInset.left)*4/5, CMCellH);
            
            
            
            shrinkCellIndex ++;
            shrinkCellIndex = MIN(row, 3);
        }
        
        
        
        att.frame = cellRect;
        
        att.zIndex = row * 2;
        
        [self.layoutAttrs addObject:att];
        
    }
    return [self.layoutAttrs copy];
}




- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    return [self resolveCellAttributes];
    
}

- (CGSize)collectionViewContentSize {
    UIEdgeInsets contentInset = self.collectionView.contentInset;
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    CGSize contentSize = CGSizeMake(CMCollectionW - contentInset.left - contentInset.right, (itemCount - 1) * CMFoldCellMinSpace + CMCellH);
    
    return contentSize;
    
}



- (void)extendCell {
    
    self.isExtend = YES;
    [self.collectionView performBatchUpdates:^{
        
        [self invalidateLayout];
        
    } completion:^(BOOL finished) {
        self.collectionView.scrollEnabled = NO;
    }];
    
    
}

- (void)foldCell {
    
    self.isExtend = NO;
    
    [self.collectionView performBatchUpdates:^{
      
        [self invalidateLayout];
        
    } completion:^(BOOL finished) {
        self.collectionView.scrollEnabled = YES;
    }];
    
    
    
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    
    
    if (self.isExtend) {
     
        [self foldCell];
        
    } else {
        
        self.currentIndexPath = indexPath;
        [self extendCell];
        
    }
    
//  NSArray *selectedItems = [collectionView indexPathsForSelectedItems];
//    if (selectedItems.count == 0) {
//        //收起
//        self.currentIndexPath = nil;
//        [self foldCell];
//
//
//    } else {
//
//        self.currentIndexPath = selectedItems.firstObject;
//
//        //展开
//        [self extendCell];
//
//        for (NSIndexPath *selectIndexPath in selectedItems) {
//            UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:selectIndexPath];
//
//            if (![selectIndexPath isEqual:indexPath]) cell.selected = NO;
//        }
//
//
//    }
    
    
}


@end
