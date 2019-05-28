//
//  CMCollectionCommonFlowLayout.h
//  CMCollectionWaterFall
//
//  Created by CrabMan on 2017/4/17.
//  Copyright © 2017年 CrabMan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CMWaterFallDataSource <NSObject>

@required

- (CGFloat)cm_heightForItem:(NSIndexPath *)indexPath;



@end


@interface CMCollectionFlowLayouts_Waterfall : UICollectionViewFlowLayout


/**列数*/
@property (nonatomic,assign) NSInteger closCount;

/**数据源代理*/
@property (nonatomic,weak) id<CMWaterFallDataSource> dataSource;



@end
