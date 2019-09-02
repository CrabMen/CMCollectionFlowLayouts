//
//  CMCollectionFlowLayouts.m
//  CMCollectionFlowLayouts
//
//  Created by zhijie on 第242天 Aug的第5周.
//

#import "CMCollectionFlowLayouts.h"

@implementation CMCollectionFlowLayouts

+ (instancetype)layoutWithStyle:(CMCollectionFlowLayoutsStyle)style{
    
    
    
    if (style == CMCollectionFlowLayoutsStyle_Liner) {
        
    } else if (style ==CMCollectionFlowLayoutsStyle_Scale) {
        
        return [[CMCollectionFlowLayouts_Scale alloc] init];

    }else if (style ==CMCollectionFlowLayoutsStyle_Angle) {
        
        
    }else if (style ==CMCollectionFlowLayoutsStyle_Waterfall) {
       
        return [[CMCollectionFlowLayouts_Waterfall alloc] init];
    
    } else if (style == CMCollectionFlowLayoutsStyle_Emotions) {
       
        return [[CMCollectionFlowLayouts_Emotions alloc] init];
    
    }
    
    return [[super alloc] init];
    
}

- (instancetype)init {
    
    if (self = [super init]) {
     
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.minimumLineSpacing = 0;
        self.minimumInteritemSpacing = 0;
    }
    return self;
}

- (void)prepareLayout {
    [super prepareLayout];
    if (!self.collectionView) return;

    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.pagingEnabled = YES;
    
}


@end



@interface CMCollectionFlowLayouts_Angle ()

@end

@implementation CMCollectionFlowLayouts_Angle

- (void)prepareLayout {
    
    [super prepareLayout];

    
    
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





@interface CMCollectionFlowLayouts_Scale ()



@end

@implementation CMCollectionFlowLayouts_Scale



- (void)prepareLayout {
    [super prepareLayout];
    
    
    CGFloat itemH = self.collectionView.bounds.size.height * 0.8;
    CGFloat itemW = self.collectionView.bounds.size.height * 0.6;
    CGFloat margin = (self.collectionView.bounds.size.width -  itemW) * 0.5;
    self.itemSize = CGSizeMake(itemW, itemH);
    self.sectionInset = UIEdgeInsetsMake(0, margin, 0, margin);
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSArray *attrs = [super layoutAttributesForElementsInRect:rect];
    NSArray *itemAttrs = [[NSArray alloc]initWithArray:attrs copyItems:YES];
    CGFloat screenCenterX = self.collectionView.contentOffset.x + self.collectionView.bounds.size.width * 0.5;
    for (UICollectionViewLayoutAttributes *attribute in itemAttrs) {
        CGFloat deltaCenterX = fabs(screenCenterX - attribute.center.x);
        CGFloat scale = fabs(deltaCenterX/self.collectionView.bounds.size.width * 0.5 - 0.8) ;
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













@interface CMCollectionFlowLayouts_Waterfall ()

@property (nonatomic,strong) NSMutableArray *layoutAttrs;

@property (nonatomic,strong) NSMutableArray *cellHeights;

@end



@implementation CMCollectionFlowLayouts_Waterfall

- (NSMutableArray *)layoutAttrs {
    
    if (!_layoutAttrs) {
        _layoutAttrs = [NSMutableArray array];
    }
    
    return _layoutAttrs;
}

- (NSMutableArray *)cellHeights {
    
    if (!_cellHeights) {
        _cellHeights = [NSMutableArray array];
        
        for (NSInteger i = 0; i < self.cm_columnCount; i++) {
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
    
    CGFloat itemW = (self.collectionView.bounds.size.width - self.sectionInset.left - self.sectionInset.right - (self.cm_columnCount - 1)* self.minimumInteritemSpacing) / self.cm_columnCount;
    
    for (NSInteger i = self.layoutAttrs.count; i < count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        
        UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        
        CGFloat itemH = self.dataSource ? [self.dataSource cm_heightForItem:indexPath] : 0;
        
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


















@interface CMCollectionFlowLayouts_Emotions ()

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
    CGFloat interSpac =  self.minimumInteritemSpacing;//列与列之间的距离
    CGFloat interLine = self.minimumLineSpacing;//行与行之间的距离
    
    NSInteger pageCount = 0;
    NSInteger sectionCount = self.collectionView.numberOfSections;
    CGFloat itemW = (collectionW - insetLeft - insetRight - (self.cm_columnCount -1)*interSpac)*1.0/self.cm_columnCount;
    CGFloat itemH = (collectionH - insetTop - insetBottom - (self.cm_rowCount -1) * interLine)*1.0/self.cm_rowCount;
    
    for (NSInteger sectionIndex = 0; sectionIndex < sectionCount; sectionIndex++) {
        NSInteger itemCount = [self.collectionView numberOfItemsInSection:sectionIndex];
        for (NSInteger itemIndex = 0 ; itemIndex < itemCount; itemIndex++) {
            UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForItem:itemIndex inSection:sectionIndex]];
            NSInteger pageIndex = itemIndex / (self.cm_columnCount * self.cm_rowCount);
            NSInteger pageItemIndex = itemIndex % (self.cm_columnCount * self.cm_rowCount);

            NSInteger rowIndex = pageItemIndex / self.cm_columnCount;
            NSInteger colIndex = pageItemIndex % self.cm_columnCount;
            
            
            CGFloat itemX = insetLeft + colIndex * (itemW + interSpac) + (pageIndex + pageCount) * collectionW;
            CGFloat itemY = insetTop + rowIndex* (itemH + interSpac);
            
            attribute.frame = CGRectMake(itemX, itemY, itemW, itemH);
            
            [self.layoutAttrs addObject:attribute];
        }
        pageCount += (itemCount - 1) / (self.cm_rowCount * self.cm_columnCount) + 1;
    }
}


- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    return self.layoutAttrs;
}

- (CGSize)collectionViewContentSize {
    
    return CGSizeMake(pageCount * self.collectionView.bounds.size.width, 0);
    
}

@end

