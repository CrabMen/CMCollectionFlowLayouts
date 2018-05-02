//
//  CMWalletController.m
//  CMCollectionFlowLayouts
//
//  Created by CrabMan on 2018/4/30.
//  Copyright © 2018年 CrabMan. All rights reserved.
//

#import "CMWalletController.h"
#import "CMWalletCell.h"
#import "CMWalletFlowLayout.h"
@interface CMWalletController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation CMWalletController
- (void)viewDidLoad {
    [super viewDidLoad];
}



- (void)initSubViews {
    
    [super initSubViews];
    
    CMWalletFlowLayout *layout = [[CMWalletFlowLayout alloc]init];
    
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64) collectionViewLayout:layout];
    self.collectionView.contentInset = UIEdgeInsetsMake(20, 10, 20, 10);
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView registerClass:[CMWalletCell class] forCellWithReuseIdentifier:NSStringFromClass(self.class)];
    
    [self.view addSubview:self.collectionView];
    
    
    
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    
    return self.dataCount;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CMWalletCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(self.class) forIndexPath:indexPath];
    
    
    for (UIView *subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
    }
    cell.title = [NSString stringWithFormat:@"第%ld个Cell",(long)indexPath.row];
    

    return cell;
    
    
}




@end
