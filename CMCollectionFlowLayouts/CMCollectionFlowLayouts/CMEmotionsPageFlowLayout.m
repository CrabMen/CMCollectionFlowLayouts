//
//  CMEmotionsPageFlowLayout.m
//  CMCollectionWaterFall
//
//  Created by CrabMan on 2017/5/13.
//  Copyright © 2017年 CrabMan. All rights reserved.
//

#import "CMEmotionsPageFlowLayout.h"

@interface CMEmotionsPageFlowLayout ()

/**数组*/
@property (nonatomic,strong) NSMutableArray *layoutAttrs;

/**行数*/
@property (nonatomic,assign) NSInteger rowsCount;

/**列数*/
@property (nonatomic,assign) NSInteger closCount;



@end

static NSInteger pageCount = 0;


@implementation CMEmotionsPageFlowLayout



- (NSMutableArray *)layoutAttrs {
    
    if (!_layoutAttrs) {
        _layoutAttrs = [NSMutableArray array];
        
    }
    
    return _layoutAttrs;
}



- (void)prepareLayout {

    [super prepareLayout];
    
    if (!self.collectionView) return;
    
    self.rowsCount = 5;
    
    self.closCount = 3;
    
    
    NSInteger sectionCount = [self.collectionView numberOfSections];
    
    
    CGFloat itemW  = (self.collectionView.bounds.size.width - self.sectionInset.left - self.sectionInset.right - (self.closCount - 1)* self.minimumInteritemSpacing) / self.closCount;
    
    CGFloat itemH  = (self.collectionView.bounds.size.height - self.sectionInset.top
    - self.sectionInset.bottom - (self.rowsCount - 1)* self.minimumLineSpacing) / self.rowsCount;
    
    for (NSInteger sectionIndex = 0; sectionIndex < sectionCount; sectionIndex++) {
        
        NSInteger itemCount = [self.collectionView numberOfItemsInSection:sectionIndex];
        
        for (NSInteger itemIndex = 0 ; itemIndex < itemCount; itemIndex++) {
            
            UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForItem:itemIndex inSection:sectionIndex]];
            
            
            //求出当前cell在某个section中在第几页第几个
            NSInteger pageIndex = itemIndex / (self.closCount * self.rowsCount);
            NSInteger pageItemIndex = itemIndex % (self.closCount * self.rowsCount);
            
            //求出当前cell在在第几行第几列
            NSInteger rowIndex = pageItemIndex / self.closCount;
            NSInteger cloIndex = pageItemIndex % self.closCount;
            
            //计算cell的坐标
            CGFloat itemX = self.sectionInset.left + cloIndex * (itemW + self.minimumInteritemSpacing) + (pageIndex + pageCount) * self.collectionView.bounds.size.width;
            CGFloat itemY = self.sectionInset.top + rowIndex* (itemH + self.minimumLineSpacing);
            
            attribute.frame = CGRectMake(itemX, itemY, itemW, itemH);
            
            [self.layoutAttrs addObject:attribute];
            
        }
        
        pageCount += (itemCount - 1) / (self.rowsCount * self.closCount) + 1;
        
    }

}


- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {

    
    return self.layoutAttrs;
}

- (CGSize)collectionViewContentSize {

    return CGSizeMake(pageCount * self.collectionView.bounds.size.width, 0);
    
}

@end
