//
//  CMViewController.m
//  CMCollectionFlowLayouts
//
//  Created by CrabMen on 05/24/2019.
//  Copyright (c) 2019 CrabMen. All rights reserved.
//

#import "CMViewController.h"
#import "CMCollectionFlowLayouts.h"
@interface CMViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

/**default note*/
@property (nonatomic,strong) UICollectionView *collection;


@end

//屏幕尺寸
#define CM_SCREEN_W  [UIScreen mainScreen].bounds.size.width
#define CM_SCREEN_H  [UIScreen mainScreen].bounds.size.height


//是否是刘海屏
#define CM_NOTCH_SCREEN \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})

//导航栏高度
#define CM_NAVI_BAR_H (CM_NOTCH_SCREEN ? 88 : 64)

//电池条高度
#define CM_STATUE_BAR_H (CM_NOTCH_SCREEN ? 44 : 20)

//tabbar高度
#define CM_TAB_BAR_H (CM_NOTCH_SCREEN ? 83.0f: 49.0)


//随机色
#define CM_RANDOM_COLOR [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]


@implementation CMViewController

- (UICollectionView *)collection {
    if (!_collection) {
        
        CMCollectionFlowLayouts *layout = [CMCollectionFlowLayouts layoutWithStyle:CMCollectionFlowLayoutsStyle_Scale];
        layout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 200);
        layout.minimumLineSpacing = 20;
        _collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 200, [UIScreen mainScreen].bounds.size.width, 200) collectionViewLayout:layout];
        _collection.delegate = self;
        _collection.dataSource = self;
        [_collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass(self.class)];
        
    }
    
    return _collection;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.collection];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    
    return 10;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(self.class) forIndexPath:indexPath];
    cell.backgroundColor = CM_RANDOM_COLOR;
    return cell;
}


@end
