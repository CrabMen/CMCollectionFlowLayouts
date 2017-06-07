//
//  CMWaterFallController.m
//  CMCollectionWaterFall
//
//  Created by CrabMan on 2017/6/7.
//  Copyright © 2017年 CrabMan. All rights reserved.
//

#import "CMWaterFallController.h"
#import "CMWaterFallLayout.h"
@interface CMWaterFallController ()<CMWaterFallDataSource,UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation CMWaterFallController

- (void)viewDidLoad {
    [super viewDidLoad];
}



- (void)initSubViews {

    [super initSubViews];

    CMWaterFallLayout *layout = [[CMWaterFallLayout alloc]init];
    layout.closCount = 3;
    
    layout.dataSource = self;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64) collectionViewLayout:layout];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass(self.class)];
    
    [self.view addSubview:self.collectionView];
    
    

}

- (CGFloat)cm_heightForItem:(NSIndexPath *)indexPath {

    //目前为假数据，项目中是服务器返回的图片高度
        return 100 + arc4random_uniform(80);


}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    
    return self.dataCount;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(self.class) forIndexPath:indexPath];
    
    for (UIView *subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
    }
    
    cell.backgroundColor = randomColor;
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    label.text = [NSString stringWithFormat:@"%ld-%ld",indexPath.section,(long)indexPath.row];
    [label sizeToFit];
    [cell.contentView addSubview:label];
    return cell;
    
    
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    if (scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.bounds.size.height) {

        self.dataCount += 40;

        [self.collectionView reloadData];
}
}

@end
