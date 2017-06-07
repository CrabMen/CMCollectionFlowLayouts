//
//  CMBaseViewController.m
//  CMCollectionWaterFall
//
//  Created by CrabMan on 2017/6/7.
//  Copyright © 2017年 CrabMan. All rights reserved.
//

#import "CMBaseViewController.h"

@interface CMBaseViewController ()

@end



@implementation CMBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self initSubViews];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.automaticallyAdjustsScrollViewInsets = NO;

}

/**初始化子视图*/
- (void)initSubViews {
    self.dataCount = 40;



}
@end
