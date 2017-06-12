//
//  CMCircleController.m
//  CMCollectionFlowLayouts
//
//  Created by CrabMan on 2017/6/9.
//  Copyright © 2017年 CrabMan. All rights reserved.
//

#import "CMCircleController.h"
#import "CMCircleFlowLayout.h"
@interface CMCircleController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation CMCircleController

- (void)viewDidLoad {

    
    [super viewDidLoad];

}


- (void)initSubViews {
    
    [super initSubViews];
    
    CMCircleFlowLayout *layout = [[CMCircleFlowLayout alloc]init];
    
//    layout.radius = self.view.bounds.size.width * 0.5;
    
    
    
//    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64) collectionViewLayout:layout];
    collectionView.showsHorizontalScrollIndicator = YES;
    
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass(self.class)];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    
    self.collectionView = collectionView;
    [self.view addSubview:self.collectionView];
    
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 7;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(self.class) forIndexPath:indexPath];
    
    for (UIView *subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
    }
    
    UILabel *label = [[UILabel alloc]initWithFrame:cell.contentView.bounds];
    label.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:14];
    label.backgroundColor = randomColor;
    [cell.contentView addSubview:label];
    
    return cell;
    
    
}

@end
