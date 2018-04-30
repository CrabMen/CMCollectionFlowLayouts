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
#define CMCellSpace 100 // the min space between cells


@interface CMWalletFlowLayout ()


/**保存layoutattribute的数组*/
@property (nonatomic,strong) NSMutableArray *layoutAttrs;


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
    self.minimumLineSpacing = CMCellSpace - CMCellH;
    
}


- (NSArray *)resolveCellAttributes {
    
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    
    CGFloat offsetY = self.collectionView.contentOffset.y;
    
    UIEdgeInsets contentInset = self.collectionView.contentInset;
    
    for (NSInteger row = 0; row < itemCount; row++) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:row inSection:0];
        UICollectionViewLayoutAttributes *att = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        CGRect cellRect = CGRectMake(0, MAX(offsetY, row * CMCellSpace), CMCollectionW - contentInset.right - contentInset.left, CMCellH);
        
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
    CGSize contentSize = CGSizeMake(CMCollectionW - contentInset.left - contentInset.right, (itemCount - 1) * CMCellSpace + CMCellH);
    
    return contentSize;
    
}
@end
