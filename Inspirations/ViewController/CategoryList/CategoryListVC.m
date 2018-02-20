//
//  CategoryListVC.m
//  Inspirations
//
//  Created by Easer on 2018/2/16.
//  Copyright © 2018年 Easer. All rights reserved.
//

#import "CategoryListVC.h"
#import "EasyFlowerView.h"
#import "EasyFlowerViewCell.h"
#import "Easy3DSemicircleView.h"
//#import "Easy3DSemicircleViewCell.h"
#import "CategoryCell.h"

@interface CategoryListVC ()<Easy3DSemicircleViewDataSource>

@property (nonatomic, strong) Easy3DSemicircleView *easy3DSemicircleView;

@end

@implementation CategoryListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.easy3DSemicircleView.backgroundColor = Easy_RandomColor;
    self.easy3DSemicircleView.dataSource = self;
    self.view.backgroundColor = [UIColor whiteColor];
    self.easy3DSemicircleView.frame = self.view.bounds;
    [self.view addSubview:self.easy3DSemicircleView];

    if (self.navigationController) {
        self.easy3DSemicircleView.frame = CGRectMake(0, CGRectGetMaxY(self.navigationController.navigationBar.frame), self.easy3DSemicircleView.mj_w, self.easy3DSemicircleView.mj_h-CGRectGetMaxY(self.navigationController.navigationBar.frame));
    }
    // Do any additional setup after loading the view.
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark ---- Setter
#pragma mark ---- Getter
-(Easy3DSemicircleView *)easy3DSemicircleView{
    if (!_easy3DSemicircleView) {
        _easy3DSemicircleView = [[Easy3DSemicircleView alloc] init];
    }
    return _easy3DSemicircleView;
}
#pragma mark ---- Methods
#pragma mark ---- Easy3DSemicircleViewDataSource
-(NSInteger)numberOfRowsInEasy3DSemicircleView:(Easy3DSemicircleView *)easy3DSemicircleView{
    return 20;
}
-(Easy3DSemicircleViewCell *)easy3DSemicircleView:(Easy3DSemicircleView *)easy3DSemicircleView cellForRow:(NSInteger)row{
    CategoryCell *cell = (CategoryCell *)[easy3DSemicircleView dequeueReusableCellWithIdentifier:self.easy3DSemicircleView.reuseIdentifier inRow:row];
    if(!cell){
        cell = [[CategoryCell alloc] initWithStyle:Easy3DSemicircleViewCellStyleNone reuseIdentifier:self.easy3DSemicircleView.reuseIdentifier];
    }
    cell.title = [NSString stringWithFormat:@"row is %ld", row];
    cell.laText = [NSString stringWithFormat:@"%ld", row];
    cell.backgroundColor = Easy_RandomColor;
    return cell;
}
//-(NSInteger)numberOfRowsInEasyFlowerView:(EasyFlowerView *)easyFlowerView{
//    return 8;
//}
//-(EasyFlowerViewCell *)easyFlowerView:(EasyFlowerView *)easyFlowerView cellForRow:(NSInteger)row{
//    EasyFlowerViewCell *cell = [[EasyFlowerViewCell alloc] init];
//    cell.backgroundColor = Easy_RandomColor;
//    return cell;
//}
#pragma mark ---- EasyFlowerViewDelegate
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
