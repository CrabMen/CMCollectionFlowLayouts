//
//  CMPhotoSpecialController.m
//  CMCollectionFlowLayouts
//
//  Created by 智借iOS on 2018/4/27.
//  Copyright © 2018年 CrabMan. All rights reserved.
//

#import "CMPhotoSpecialController.h"
#import "CMPhotoSpecialFlowLayout.h"

@interface CMPhotoSpecialController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation CMPhotoSpecialController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initSubViews {
    
    [super initSubViews];
    
    CMPhotoSpecialFlowLayout *layout = [[CMPhotoSpecialFlowLayout alloc]init];

    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) collectionViewLayout:layout];
    

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
    
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(self.class) forIndexPath:indexPath];
    
    for (UIView *subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
    }
    
    cell.backgroundColor = randomColor;
//    UIImageView *imgView = [[UIImageView alloc]initWithFrame:cell.contentView.bounds];
//    
//    imgView.image = [UIImage imageNamed:@"zilong"];
//    
//    [cell.contentView addSubview:imgView];
    
    
    return cell;
    
    
}


@end
