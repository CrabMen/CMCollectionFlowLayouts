//
//  CMWalletCollectionView.m
//  CMCollectionFlowLayouts
//
//  Created by 智借iOS on 2018/5/3.
//  Copyright © 2018年 CrabMan. All rights reserved.
//

#import "CMWalletCollectionView.h"
#import "CMWalletCell.h"
#import "CMWalletFlowLayout.h"
@interface CMWalletCollectionView () <UICollectionViewDelegate,UICollectionViewDataSource>


@property (nonatomic,strong) CMWalletFlowLayout *flowLayout;



@end

@implementation CMWalletCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        self.flowLayout = (CMWalletFlowLayout *)layout;
        
        [self initSubViews];
        
    }
    
    return self;
    
}


- (void)initSubViews {
    
    self.delegate = self;
    self.dataSource = self;
    
     [self registerClass:[CMWalletCell class] forCellWithReuseIdentifier:NSStringFromClass(self.class)];
    
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    
    return 10;
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    CMWalletCell * cell  = (CMWalletCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(self.class) forIndexPath:indexPath];
    
    
    for (UIView *subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
    }
    cell.title = [NSString stringWithFormat:@"第%ld个Cell",(long)indexPath.row];
    
    
    return cell;
    
    
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CMWalletCell *cell = (CMWalletCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.selected = !cell.selected;
    
    [self.flowLayout collectionView:collectionView didSelectItemAtIndexPath:indexPath];
    
    
}

@end
