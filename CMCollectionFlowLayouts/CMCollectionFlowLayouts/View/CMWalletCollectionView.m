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

@interface CMWalletCollectionView () <UICollectionViewDelegate,UICollectionViewDataSource>


@property (nonatomic,strong) CMWalletFlowLayout *flowLayout;

@property (nonatomic,strong) UILongPressGestureRecognizer *longGesture;

@property (nonatomic,strong) CMWalletCell *activeCell;

@property (nonatomic,strong) UIView *snapViewForActiveCell;

@property (nonatomic,strong) NSIndexPath *activeIndexPath;

@property (nonatomic,assign) CGPoint centerOffset;




@end

@implementation CMWalletCollectionView

- (UILongPressGestureRecognizer *)longGesture {
    
    if (!_longGesture) {
        _longGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(handleLongPressGestureRecognizer:)];

        _longGesture.minimumPressDuration = self.longPressInterval ? self.longPressInterval : 2.0f;
    }
    
    return _longGesture;
    
    
}

- (void)setLongPressInterval:(NSTimeInterval)longPressInterval {
    
    _longPressInterval = longPressInterval;
    
    self.longGesture.minimumPressDuration = _longPressInterval;
    
    
}

- (void)setCanEdit:(BOOL)canEdit {
    _canEdit = canEdit;
    
    if (_canEdit) {
        
        [self addGestureRecognizer:self.longGesture];

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



- (void)addLongPressGestureRecognizer {
    
    
    
    
}

- (void)handleLongPressGestureRecognizer:(UILongPressGestureRecognizer *)recognizer {
    
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan: {
            [self handleEditingMoveWhenGestureBegan:recognizer];
            break;
        }
        case UIGestureRecognizerStateChanged: {
            [self handleEditingMoveWhenGestureChanged:recognizer];
            break;
        }
        case UIGestureRecognizerStateEnded: {
            [self handleEditingMoveWhenGestureEnded:recognizer];
            break;
        }
        default: {
            [self handleEditingMoveWhenGestureCanceledOrFailed:recognizer];
            break;
        }
    }
    
}

- (void)handleEditingMoveWhenGestureBegan:(UILongPressGestureRecognizer *)recognizer {
    
    
    CGPoint pressPoint = [recognizer locationInView:self];
    NSIndexPath *selectIndexPath = [self indexPathForItemAtPoint:pressPoint];
    CMWalletCell *cell = (CMWalletCell *)[self cellForItemAtIndexPath:selectIndexPath];
    self.activeIndexPath = selectIndexPath;
//    self.sourceIndexPath = selectIndexPath;
    self.activeCell = cell;
    self.activeCell.selected = YES;
    
    self.centerOffset = CGPointMake(pressPoint.x - cell.center.x, pressPoint.y - cell.center.y);
    
    if (0) {
        [self beginInteractiveMovementForItemAtIndexPath:selectIndexPath];
    }else{
        self.snapViewForActiveCell = [cell snapshotViewAfterScreenUpdates:YES];
        self.snapViewForActiveCell.frame = cell.frame;
        cell.hidden = YES;
        [self addSubview:self.snapViewForActiveCell];
    }
    
}

- (void)handleEditingMoveWhenGestureChanged:(UILongPressGestureRecognizer *)recognizer {
    
    CGPoint pressPoint = [recognizer locationInView:self];
    if (0) {
        [self updateInteractiveMovementTargetPosition:pressPoint];
        
        NSLog(@"开始拖拽");
    }else{
        _snapViewForActiveCell.center = CGPointMake(pressPoint.x - _centerOffset.x, pressPoint.y-_centerOffset.y);
     //   [self handleExchangeOperation];
       // [self detectEdge];
    }
    
    
}

- (void)handleEditingMoveWhenGestureEnded:(UILongPressGestureRecognizer *)recognizer {
    
    
    if (EqualOrLargerThan9_0) {
        self.activeCell.selected = NO;
        [self endInteractiveMovement];
    }else{
        
        [self.snapViewForActiveCell removeFromSuperview];
        self.activeCell.selected = NO;
        self.activeCell.hidden = NO;
//
//        [self handleDatasourceExchangeWithSourceIndexPath:self.sourceIndexPath destinationIndexPath:self.activeIndexPath];
//        [self invalidateCADisplayLink];
//        self.edgeIntersectionOffset = 0;
//        self.changeRatio = 0;
        
    }
    
}

- (void)handleEditingMoveWhenGestureCanceledOrFailed:(UILongPressGestureRecognizer *)recognizer {
    
    if (EqualOrLargerThan9_0) {
        self.activeCell.selected = NO;
        [self cancelInteractiveMovement];
    }else{
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
    
    
    return cell;
    
    
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CMWalletCell *cell = (CMWalletCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.selected = !cell.selected;
    
    [self.flowLayout collectionView:collectionView didSelectItemAtIndexPath:indexPath];
    
    
}

@end
