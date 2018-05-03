//
//  CMWalletController.m
//  CMCollectionFlowLayouts
//
//  Created by CrabMan on 2018/4/30.
//  Copyright © 2018年 CrabMan. All rights reserved.
//

#import "CMWalletController.h"
#import "CMWalletCollectionView.h"
#import "CMWalletFlowLayout.h"
@interface CMWalletController ()
@property (nonatomic,strong) CMWalletFlowLayout *flowLayout;

@end

@implementation CMWalletController
- (void)viewDidLoad {
    [super viewDidLoad];
}



- (void)initSubViews {
    
    [super initSubViews];
    
    self.flowLayout = [[CMWalletFlowLayout alloc]init];
    
    
    self.collectionView = [[CMWalletCollectionView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64) collectionViewLayout:self.flowLayout];
    self.collectionView.contentInset = UIEdgeInsetsMake(20, 10, 20, 10);
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
   
    
    
    [self.view addSubview:self.collectionView];
    
    
    
}







@end
