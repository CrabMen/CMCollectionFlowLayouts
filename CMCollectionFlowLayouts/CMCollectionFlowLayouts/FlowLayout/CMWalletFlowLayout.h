//
//  CMWalletFlowLayout.h
//  CMCollectionFlowLayouts
//
//  Created by CrabMan on 2018/4/30.
//  Copyright © 2018年 CrabMan. All rights reserved.
//

#import <UIKit/UIKit.h>


#define CMCollectionW (self.collectionView.frame.size.width)
#define CMCollectionH (self.collectionView.frame.size.height)

#define CMCellH 200 /// cell 高度
#define CMFoldCellMinSpace 100 // the min space between cells
#define CMExtendCellMinSpace 10
#define CMExtendedCellFooter 80

@interface CMWalletFlowLayout : UICollectionViewFlowLayout

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath ;

@end
