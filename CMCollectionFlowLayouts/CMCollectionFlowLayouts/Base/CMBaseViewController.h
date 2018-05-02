//
//  CMBaseViewController.h
//  CMCollectionWaterFall
//
//  Created by CrabMan on 2017/6/7.
//  Copyright © 2017年 CrabMan. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface CMBaseViewController : UIViewController 
/**数据源个数*/
@property (nonatomic,assign) NSInteger dataCount;



/**collectionView*/
@property (nonatomic,strong) UICollectionView *collectionView;

- (void)initSubViews ;

@end
