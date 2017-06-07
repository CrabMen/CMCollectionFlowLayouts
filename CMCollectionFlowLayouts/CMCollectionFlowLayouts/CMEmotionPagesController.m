//
//  CMEmotionPagesController.m
//  CMCollectionFlowLayouts
//
//  Created by CrabMan on 2017/6/7.
//  Copyright © 2017年 CrabMan. All rights reserved.
//

#import "CMEmotionPagesController.h"
#import "CMEmotionsPageFlowLayout.h"
@interface CMEmotionPagesController () <UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation CMEmotionPagesController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initSubViews {
    [super initSubViews];
    CMEmotionsPageFlowLayout *layout = [[CMEmotionsPageFlowLayout alloc]init];
    
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64) collectionViewLayout:layout];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.pagingEnabled = YES;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass(self.class)];
    
    
    
    [self.view addSubview:self.collectionView];

}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    
    return 4;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 22;
    } else if (section == 1) {
        
        return 26;
    } else if (section == 2) {
        
        return 29;
    } else if (section == 3) {
        
        return 17;
    } else {
        
        return 33;
        
    }
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(self.class) forIndexPath:indexPath];
    
    for (UIView *subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
    }
    
    cell.backgroundColor = randomColor;
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectZero];
    label.text = [NSString stringWithFormat:@"%ld-%ld",indexPath.section,(long)indexPath.row];
    [label sizeToFit];
    label.center = CGPointMake(cell.bounds.size.width * 0.5, cell.bounds.size.height * 0.5);
    [cell.contentView addSubview:label];
    return cell;
    
    
}

@end
