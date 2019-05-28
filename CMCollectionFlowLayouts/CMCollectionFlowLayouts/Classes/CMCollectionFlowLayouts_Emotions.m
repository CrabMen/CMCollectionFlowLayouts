//
//  CMEmotionsPageFlowLayout.m
//  CMCollectionWaterFall
//
//  Created by CrabMan on 2017/5/13.
//  Copyright © 2017年 CrabMan. All rights reserved.
//

#import "CMEmotionsPageFlowLayout.h"

@interface CMCollectionFlowLayouts_Emotions ()

/**数组*/
@property (nonatomic,strong) NSMutableArray *layoutAttrs;


@end

static NSInteger pageCount = 0;


@implementation CMCollectionFlowLayouts_Emotions



- (NSMutableArray *)layoutAttrs {
    
    if (!_layoutAttrs) {
        _layoutAttrs = [NSMutableArray array];
        
    }
    
    return _layoutAttrs;
}



- (void)prepareLayout {

    [super prepareLayout];
    
    if (!self.collectionView) return;
    
    CGFloat insetLeft = self.sectionInset.left;
    CGFloat insetRight = self.sectionInset.right;
    CGFloat insetTop = self.sectionInset.top;
    CGFloat insetBottom = self.sectionInset.bottom;
    CGFloat collectionH = self.collectionView.bounds.size.height;
    CGFloat collectionW = self.collectionView.bounds.size.width;
    //这个和滚动的方向有关
    CGFloat interSpac =  self.minimumInteritemSpacing;//列与列之间的距离
    CGFloat interLine = self.minimumLineSpacing;//行与行之间的距离
    
    
//    if (self.scrollDirection == UICollectionViewScrollDirectionHorizontal) {//横向的
        //        interSpac = self.minimumLineSpacing;//列与列之间的距离
        //        interLine = self.minimumInteritemSpacing;//行与行之间的距离
        //
        //    }else{//纵向滚动
        //        interSpac = self.minimumInteritemSpacing;//列与列之间的距离
        //        interLine = self.minimumLineSpacing;//行与行之间的距离
        //    }
    
    
    //计算累加的组有多少页
    NSInteger pageCount = 0;
    //获取多少组
    NSInteger sectionCount = self.collectionView.numberOfSections;
    CGFloat itemW = (collectionW - insetLeft - insetRight - (self.columnCount -1)*interSpac)*1.0/self.columnCount;
    CGFloat itemH = (collectionH - insetTop - insetBottom - (self.rowsCount -1) * interLine)*1.0/self.rowsCount;
    
    //循环遍历所有的item，并设置item的attribute
    for (NSInteger sectionIndex = 0; sectionIndex < sectionCount; sectionIndex++) {
        
        NSInteger itemCount = [self.collectionView numberOfItemsInSection:sectionIndex];
        
        for (NSInteger itemIndex = 0 ; itemIndex < itemCount; itemIndex++) {
            
            UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForItem:itemIndex inSection:sectionIndex]];
            
            
            //求出当前cell在某个section中在第几页第几个
            NSInteger pageIndex = itemIndex / (self.columnCount * self.rowsCount);
            NSInteger pageItemIndex = itemIndex % (self.columnCount * self.rowsCount);
            
            //求出当前cell在在第几行第几列
            NSInteger rowIndex = pageItemIndex / self.columnCount;
            NSInteger colIndex = pageItemIndex % self.columnCount;
            
            //计算cell的坐标
            CGFloat itemX = insetLeft + colIndex * (itemW + interSpac) + (pageIndex + pageCount) * collectionW;
            CGFloat itemY = insetTop + rowIndex* (itemH + interSpac);
            
            attribute.frame = CGRectMake(itemX, itemY, itemW, itemH);
            
            [self.layoutAttrs addObject:attribute];
            
        }
        
        pageCount += (itemCount - 1) / (self.rowsCount * self.columnCount) + 1;
        
    }

}


- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {

    
    return self.layoutAttrs;
}

- (CGSize)collectionViewContentSize {

    return CGSizeMake(pageCount * self.collectionView.bounds.size.width, 0);
    
}

@end
