//
//  CMBaseViewController.h
//  CMCollectionWaterFall
//
//  Created by CrabMan on 2017/6/7.
//  Copyright © 2017年 CrabMan. All rights reserved.
//

#import <UIKit/UIKit.h>


#define random(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]

#define randomColor random(arc4random_uniform(200), arc4random_uniform(200), arc4random_uniform(200), 255)
@interface CMBaseViewController : UIViewController 
/**数据源个数*/
@property (nonatomic,assign) NSInteger dataCount;



/**collectionView*/
@property (nonatomic,strong) UICollectionView *collectionView;

- (void)initSubViews ;

@end
