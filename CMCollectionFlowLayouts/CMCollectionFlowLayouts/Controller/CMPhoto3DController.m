//
//  CMPhoto3DController.m
//  CMCollectionFlowLayouts
//
//  Created by CrabMan on 2017/6/7.
//  Copyright © 2017年 CrabMan. All rights reserved.
//

#import "CMPhoto3DController.h"
#import "CMPhoto3DFlowLayout.h"
@interface CMPhoto3DController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@end

@implementation CMPhoto3DController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)initSubViews {

    [super initSubViews];
    
    CMPhoto3DFlowLayout *layout = [[CMPhoto3DFlowLayout alloc]init];
  
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 200) collectionViewLayout:layout];
    
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass(self.class)];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    
    self.collectionView = collectionView;
    [self.view addSubview:self.collectionView];
    

}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(self.class) forIndexPath:indexPath];
    
    for (UIView *subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
    }
    
    cell.backgroundColor = randomColor;
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:cell.contentView.bounds];
    
    imgView.image = [UIImage imageNamed:@"zilong"];
    
    [cell.contentView addSubview:imgView];

    
    return cell;
    
    
}


@end
