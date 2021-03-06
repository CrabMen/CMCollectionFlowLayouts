//
//  CMWalletCollectionView.m
//  CMCollectionFlowLayouts
//
//  Created by 智借iOS on 2018/5/3.
//  Copyright © 2018年 CrabMan. All rights reserved.
//

#import "CMWalletCollectionView.h"
#import "CMWalletCell.h"
#import "CMWalletFlowLayout.h"

#define EqualOrLargerThan9_0 ([UIDevice.currentDevice.systemVersion compare:@"9.0" options:NSNumericSearch] != NSOrderedAscending)

@interface CMWalletCollectionView () <CMWalletCellDelegate,UICollectionViewDelegate,UICollectionViewDataSource>


@property (nonatomic,strong) CMWalletFlowLayout *flowLayout;


@property (nonatomic,strong) CMWalletCell *activeCell;

@property (nonatomic,strong) UIView *snapShootCell;

@property (nonatomic,strong) NSIndexPath *activeIndexPath;

@property (nonatomic,assign) CGPoint centerOffset;

@property (nonatomic,assign) CGPoint longPressLastLocation;

@property (nonatomic,assign) CGPoint longPressStartLocation;


/**
 当前是否正在jiao'huan
 */
@property (nonatomic,assign) BOOL isMoving;

@end

@implementation CMWalletCollectionView




- (void)setCanEdit:(BOOL)canEdit {
    _canEdit = canEdit;
    
    if (_canEdit) {
        

    }
    

    
}


- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        self.flowLayout = (CMWalletFlowLayout *)layout;
        
        [self initSubViews];
        
    }
    
    return self;
    
}


- (void)initSubViews {
    
    self.delegate = self;
    self.dataSource = self;
    
     [self registerClass:[CMWalletCell class] forCellWithReuseIdentifier:NSStringFromClass(self.class)];
    
}


#pragma mark --- CMWalletCellDelegate


- (void)collectionViewCell:(CMWalletCell *)cell handleLongPressGestureRecognizer:(UILongPressGestureRecognizer *)gesture {    
    
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan: {
            [self collectionViewCell:cell handleEditingMoveWhenGestureBegan:gesture];
        }
            break;

        case UIGestureRecognizerStateChanged: {
           [self collectionViewCell:cell handleEditingMoveWhenGestureChanged
                                   :gesture];
        }
            break;

        case UIGestureRecognizerStateEnded: {
            [self collectionViewCell:cell handleEditingMoveWhenGestureEnded:gesture];
        }
            break;

        case UIGestureRecognizerStateFailed: {
          //  [self collectionViewCell:cell handleLongPressGestureRecognizer:gesture];
        }
            break;

        case UIGestureRecognizerStateCancelled: {
         //   [self collectionViewCell:cell handleLongPressGestureRecognizer:gesture];
        }
            break;

            default:
            break;
    }
    
    
    
}


- (void)collectionViewCell:(CMWalletCell *)cell handleEditingMoveWhenGestureBegan:(UILongPressGestureRecognizer *)recognizer {
    
    
//    CGPoint pressPoint = [recognizer locationInView:self];
//    NSIndexPath *selectIndexPath = [self indexPathForItemAtPoint:pressPoint];
//    CMWalletCell *cell = (CMWalletCell *)[self cellForItemAtIndexPath:selectIndexPath];
//    self.activeIndexPath = selectIndexPath;
////    self.sourceIndexPath = selectIndexPath;
//    self.activeCell = cell;
//    self.activeCell.selected = YES;
//
//    self.centerOffset = CGPointMake(pressPoint.x - cell.center.x, pressPoint.y - cell.center.y);
//
//    if (0) {
//        [self beginInteractiveMovementForItemAtIndexPath:selectIndexPath];
//    }else{
//        self.snapViewForActiveCell = [cell snapshotViewAfterScreenUpdates:YES];
//        self.snapViewForActiveCell.frame = cell.frame;
//        cell.hidden = YES;
//        [self addSubview:self.snapViewForActiveCell];
//    }
//
    
    
    self.activeIndexPath = [self indexPathForCell:cell];
    self.activeCell = cell;
    self.snapShootCell = [self.activeCell snapshotViewAfterScreenUpdates:YES];

    self.snapShootCell.frame = self.activeCell.frame;
    self.snapShootCell.layer.transform = CATransform3DMakeTranslation(0, 0, self.activeIndexPath.item * 2 );
    self.activeCell.hidden = YES;
    [self addSubview:self.snapShootCell];
    
    
    [UIView animateWithDuration:0.25 animations:^{
        CGRect newFrame = self.snapShootCell.frame;
        newFrame.origin.y -= 30;
        self.snapShootCell.frame = newFrame;
    }];
    
    
    self.longPressLastLocation = [recognizer locationInView:self];
    self.longPressStartLocation = [recognizer locationInView:self];
}

- (void)collectionViewCell:(CMWalletCell *)cell handleEditingMoveWhenGestureChanged:(UILongPressGestureRecognizer *)recognizer {
    
//    CGPoint pressPoint = [recognizer locationInView:self];
//    if (0) {
//        [self updateInteractiveMovementTargetPosition:pressPoint];
//
//        NSLog(@"开始拖拽");
//    }else{
//        _snapViewForActiveCell.center = CGPointMake(pressPoint.x - _centerOffset.x, pressPoint.y-_centerOffset.y);
//       [self handleExchangeOperation];
//       // [self detectEdge];
//    }
    CGPoint location = [recognizer locationInView:self];
    CGFloat deltaY = location.y - self.longPressLastLocation.y;
    self.snapShootCell.cm_centerY += deltaY; //修改截图视图位置
    if (deltaY == 0) return;
    //拖动有3中情况：1.第一个cell向上交换；2.中间（交换）3.最后一个cell向下交换
    
    NSInteger item = self.activeIndexPath.item;
    
    if (item == 0 && deltaY < 0) {
        
        
    } else if (item == [self numberOfItemsInSection:0] && deltaY > 0) {
        
        
    } else  {
        
        //cell之间交换 (如果delta小于（cell高度- 两个cell之间距离/2 则交换)
        if ( !self.isMoving &&(fabs(location.y - self.longPressStartLocation.y) > CMFoldCellMinSpace*0.15)) {
            NSInteger exchangedItem = deltaY > 0 ? item +1 : item - 1;
            
            NSIndexPath *exchangedIndexPath = [NSIndexPath indexPathForItem:exchangedItem inSection:0];
            [self performBatchUpdates:^{
                self.isMoving = YES;
                [self moveItemAtIndexPath:[NSIndexPath indexPathForItem:item inSection:0 ] toIndexPath:exchangedIndexPath];
                
                //修改snapShootCell的层级关系
                 self.snapShootCell.layer.transform = CATransform3DMakeTranslation(0, 0, exchangedIndexPath.item * 2 + 1);
                
                self.activeIndexPath = exchangedIndexPath;
                
            } completion:^(BOOL finished) {

            }];
            

            
            self.longPressStartLocation = location;
            
            self.activeIndexPath = exchangedIndexPath;
            
            self.activeCell.layer.transform = CATransform3DMakeTranslation(0, 0, self.activeIndexPath.item * 2 );
            
            
        }
        
        
    }
    
   
    self.longPressLastLocation = location;
    
    
    
}

- (void)collectionViewCell:(CMWalletCell *)cell handleEditingMoveWhenGestureEnded:(UILongPressGestureRecognizer *)recognizer {
    
    
//    if (EqualOrLargerThan9_0) {
//        self.activeCell.selected = NO;
//        [self endInteractiveMovement];
//    }else{
//
//        [self.snapViewForActiveCell removeFromSuperview];
//        self.activeCell.selected = NO;
//        self.activeCell.hidden = NO;
////
////        [self handleDatasourceExchangeWithSourceIndexPath:self.sourceIndexPath destinationIndexPath:self.activeIndexPath];
////        [self invalidateCADisplayLink];
////        self.edgeIntersectionOffset = 0;
////        self.changeRatio = 0;
//
//    }
    
    
    
    [UIView animateWithDuration:0.25 animations:^{
        self.snapShootCell.frame = cell.frame;
        
        
    } completion:^(BOOL finished) {
        [self.snapShootCell removeFromSuperview];
        cell.hidden = NO;
        self.isMoving = NO;
    }];
}

- (void)handleEditingMoveWhenGestureCanceledOrFailed:(UILongPressGestureRecognizer *)recognizer {
    
//    if (EqualOrLargerThan9_0) {
//        self.activeCell.selected = NO;
//        [self cancelInteractiveMovement];
//    }else{
//        [UIView animateWithDuration:0.25f animations:^{
//            self.snapViewForActiveCell.center = self.activeCell.center;
//        } completion:^(BOOL finished) {
//            [self.snapViewForActiveCell removeFromSuperview];
//            self.activeCell.selected = NO;
//            self.activeCell.hidden = NO;
//        }];
//
//        [self invalidateCADisplayLink];
//        self.edgeIntersectionOffset = 0;
//        self.changeRatio = 0;
   // }

    
    
    [UIView animateWithDuration:0.25 animations:^{
        
        
    } completion:^(BOOL finished) {
        
    }];
    
    
}


- (void)handleExchangeOperation{
    
//    for (CMWalletCell *cell in self.visibleCells)
//    {
//        NSIndexPath *currentIndexPath = [self indexPathForCell:cell];
//        if ([self indexPathForCell:cell] == self.activeIndexPath) continue;
//
//        CGFloat space_x = fabs(_snapViewForActiveCell.center.x - cell.center.x);
//        CGFloat space_y = fabs(_snapViewForActiveCell.center.y - cell.center.y);
//        // CGFloat space = sqrtf(powf(space_x, 2) + powf(space_y, 2));
//        CGFloat size_x = cell.bounds.size.width;
//        CGFloat size_y = cell.bounds.size.height;
//
//        if (currentIndexPath.item > self.activeIndexPath.item)
//        {
//       //     [self.activeCells addObject:cell];
//        }
//
//        if (space_x <  size_x/2.0 && space_y < size_y/2.0)
//        {
//            [self handleCellExchangeWithSourceIndexPath:self.activeIndexPath destinationIndexPath:currentIndexPath];
//            self.activeIndexPath = currentIndexPath;
//        }
//    }
//    

}

- (void)handleCellExchangeWithSourceIndexPath:(NSIndexPath *)sourceIndexPath destinationIndexPath:(NSIndexPath *)destinationIndexPath{
    
    NSInteger activeRange = destinationIndexPath.item - sourceIndexPath.item;
    BOOL moveForward = activeRange > 0;
    NSInteger originIndex = 0;
    NSInteger targetIndex = 0;
    
    for (NSInteger i = 1; i <= labs(activeRange); i ++) {
        
        NSInteger moveDirection = moveForward?1:-1;
        originIndex = sourceIndexPath.item + i*moveDirection;
        targetIndex = originIndex  - 1*moveDirection;
        
        if (1) {
            CGFloat time = 0.25 /**- 0.11*fabs(self.changeRatio)*/;
            NSLog(@"time:%f",time);
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:time];
            [self moveItemAtIndexPath:[NSIndexPath indexPathForItem:originIndex inSection:sourceIndexPath.section] toIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:sourceIndexPath.section]];
            [UIView commitAnimations];
            
            NSLog(@"---> exchange %ld to %ld",(long)originIndex,(long)targetIndex);
            
        }
        
        
    }
    
}



#pragma mark --- UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    
    return 10;
    
}

#pragma mark --- UICollectionViewDelegate

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    CMWalletCell * cell  = (CMWalletCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(self.class) forIndexPath:indexPath];
    
    
    for (UIView *subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
    }
    cell.title = [NSString stringWithFormat:@"第%ld个Cell",(long)indexPath.row];
    cell.delegate = self;
    
    return cell;
    
    
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CMWalletCell *cell = (CMWalletCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.selected = !cell.selected;
    
    [self.flowLayout collectionView:collectionView didSelectItemAtIndexPath:indexPath];
    
    
}

@end
