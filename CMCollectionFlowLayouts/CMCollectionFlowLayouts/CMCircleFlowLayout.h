//
//  CMCircleFlowLayout.h
//  CMCollectionFlowLayouts
//
//  Created by CrabMan on 2017/6/7.
//  Copyright © 2017年 CrabMan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMCircleFlowLayout : UICollectionViewFlowLayout

/**
 *   半径
 */
@property (nonatomic, assign) CGFloat radius;
/**
 *  大小
 */
@property (nonatomic, assign) CGSize itemSize;

@end

