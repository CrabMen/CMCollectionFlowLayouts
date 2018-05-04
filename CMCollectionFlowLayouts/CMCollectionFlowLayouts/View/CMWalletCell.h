//
//  CMWalletCell.h
//  CMCollectionFlowLayouts
//
//  Created by 智借iOS on 2018/5/2.
//  Copyright © 2018年 CrabMan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CMWalletCell;

@protocol CMWalletCellDelegate <NSObject>

@required

- (void)collectionViewCell:(CMWalletCell *)cell handleLongPressGestureRecognizer:(UILongPressGestureRecognizer *)gesture ;



@end

@interface CMWalletCell : UICollectionViewCell


/**
 cell的标题内容
 */
@property (nonatomic,copy) NSString *title;


@property (nonatomic, assign) NSTimeInterval longPressInterval;

@property (nonatomic, weak) id <CMWalletCellDelegate> delegate;


@end
