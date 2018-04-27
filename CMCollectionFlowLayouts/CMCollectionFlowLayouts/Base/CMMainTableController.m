//
//  CMMainTableController.m
//  CMCollectionWaterFall
//
//  Created by CrabMan on 2017/6/7.
//  Copyright © 2017年 CrabMan. All rights reserved.
//

#import "CMMainTableController.h"

#import "CMWaterFallController.h"
#import "CMEmotionPagesController.h"
#import "CMPhoto3DController.h"
#import "CMCircleController.h"
#import "CMPhotoSpecialController.h"
@interface CMMainTableController ()
/**数据源*/
@property (nonatomic,strong) NSArray *dataArr;

@end

@implementation CMMainTableController

- (NSArray *)dataArr {

    if (!_dataArr) {
        _dataArr = @[@"瀑布流",@"表情布局",@"3D翻页效果",@"风火轮",@"特殊图片浏览"];
    }
    return _dataArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.tableFooterView = [UIView new];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuseIdentifier"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.textLabel.text = self.dataArr[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    switch (indexPath.row) {
        case 0:
            [self.navigationController pushViewController:[CMWaterFallController new] animated:YES];
            break;
        
         case 1:
            [self.navigationController pushViewController:[CMEmotionPagesController new] animated:YES];
            break;
        case 2:
            [self.navigationController pushViewController:[CMPhoto3DController new] animated:YES];
            break;
        case 3:
            [self.navigationController pushViewController:[CMCircleController new] animated:YES];
            break;
        case 4:
            [self.navigationController pushViewController:[CMPhotoSpecialController new] animated:YES];
            break;
            
        default:
            break;
    }


}

@end
