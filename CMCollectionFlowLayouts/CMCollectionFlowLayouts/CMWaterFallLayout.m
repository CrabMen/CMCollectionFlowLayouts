//
//  CMCollectionCommonFlowLayout.m
//  CMCollectionWaterFall
//
//  Created by CrabMan on 2017/4/17.
//  Copyright © 2017年 CrabMan. All rights reserved.
//

#import "CMWaterFallLayout.h"

@interface CMWaterFallLayout ()

/**layoutAttribute的数组*/
@property (nonatomic,strong) NSMutableArray *layoutAttrs;

/**cell高度数组*/
@property (nonatomic,strong) NSMutableArray *cellHeights;


@end



@implementation CMWaterFallLayout

- (NSMutableArray *)layoutAttrs {

    if (!_layoutAttrs) {
        _layoutAttrs = [NSMutableArray array];
    }

    return _layoutAttrs;
}

- (NSMutableArray *)cellHeights {

    if (!_cellHeights) {
        _cellHeights = [NSMutableArray array];
        
        for (NSInteger i = 0; i < self.closCount; i++) {
            [_cellHeights addObject:@(self.sectionInset.top)];
        }

    }
    return _cellHeights;
}

- (void)prepareLayout {

    [super prepareLayout];
    

    if (!self.collectionView) return;
    
    //获取cell的个数
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    

    
    
    
    CGFloat itemW = (self.collectionView.bounds.size.width - self.sectionInset.left - self.sectionInset.right - (self.closCount - 1)* self.minimumInteritemSpacing) / self.closCount;
    
    for (NSInteger i = self.layoutAttrs.count; i < count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        
        UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        
        CGFloat itemH = self.dataSource ? [self.dataSource cm_heightForItem:indexPath] : 0;
        
//        CGFloat minH =
        
        CGFloat minH = [[self.cellHeights valueForKeyPath:@"@min.floatValue"] floatValue];
        
        NSInteger minIndex = [self.cellHeights indexOfObject:@(minH)];
        
        CGFloat itemX = self.sectionInset.left + minIndex * (itemW + self.minimumInteritemSpacing);
        
        CGFloat itemY = minH;
        
        attr.frame = CGRectMake(itemX, itemY, itemW, itemH);
    
        NSLog(@"第%ld个cell的frame：%@",i,NSStringFromCGRect(attr.frame)
);
        
        self.cellHeights[minIndex] = @(CGRectGetMaxY(attr.frame) + self.minimumLineSpacing );
        
        [self.layoutAttrs addObject:attr];
        
    }
    
    
    

}



- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {

    return self.layoutAttrs;

}

- (CGSize)collectionViewContentSize {


    return CGSizeMake(0, [[self.cellHeights valueForKeyPath:@"@max.floatValue"] floatValue] + self.sectionInset.bottom - self.minimumLineSpacing);

}






@end
