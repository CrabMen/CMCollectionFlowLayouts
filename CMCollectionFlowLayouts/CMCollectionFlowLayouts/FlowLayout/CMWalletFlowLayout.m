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
@property (nonatomic,strong) NSArray *layoutAttrs;

@property (nonatomic,strong) NSIndexPath *currentIndexPath;

@property (nonatomic,assign) BOOL isExtend;

@end

@implementation CMWalletFlowLayout




- (void)prepareLayout {
    
    [super prepareLayout];
    
    UIEdgeInsets inset = self.collectionView.contentInset;
    self.itemSize = CGSizeMake(CMCollectionW - inset.right - inset.left, CMCellH);
    self.minimumLineSpacing = CMFoldCellMinSpace - CMCellH;
    
    
}


- (NSArray *)resolveCellAttributesInRect:(CGRect)rect {
    
    NSMutableArray *mutableArr = [NSMutableArray array];
    
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
        CGFloat left = (4 - shrinkCellIndex) * 5;

        //如果点击展开后的布局
        if (self.isExtend && self.currentIndexPath.item == indexPath.item) {
            cellRect = CGRectMake(0, offsetY, CMCollectionW - contentInset.right - contentInset.left, CMCollectionH - CMExtendedCellFooter);
        } else if (self.isExtend && self.currentIndexPath.item != indexPath.item) {
            
            cellRect = CGRectMake(left,offsetY + CMCollectionH - CMExtendedCellFooter + top, CMCollectionW -contentInset.left - contentInset.right - left * 2, CMCellH);
            shrinkCellIndex ++;
            shrinkCellIndex = MIN(row, 3);
        }
        
        
        att.frame = cellRect;
       // att.zIndex = row * 2;
        att.transform3D = CATransform3DMakeTranslation(0, 0, row * 2);
        
       
        
        if (CGRectIntersectsRect(cellRect, rect) || CGRectContainsRect(cellRect, rect)) {
            [mutableArr addObject:att];
        }
        
    }
    self.layoutAttrs = [mutableArr copy];
    
    return self.layoutAttrs;
}




- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    return [self resolveCellAttributesInRect:rect];
    
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
}


@end
