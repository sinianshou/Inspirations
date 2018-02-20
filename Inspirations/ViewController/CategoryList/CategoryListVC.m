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
#import "CategoryCell.h"
#import "CategoryListModel.h"
#import "SearchListCellModel.h"

@interface CategoryListVC ()<Easy3DSemicircleViewDataSource>

@property (nonatomic, strong) Easy3DSemicircleView *easy3DSemicircleView;
@property (nonatomic, strong) NSMutableDictionary *dataSource_DicM;

@end

@implementation CategoryListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"CategoryDetailBackground_Img"]];
    if (self.requestURLString) {
        NSMutableArray *signalArrM = [NSMutableArray array];
        for (int i=1; i<11; ++i) {
            RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                //?page=1
                NSMutableURLRequest *request = [BooheeSessionDataTask requestWithRequestUrlString:[NSString stringWithFormat:@"%@?page=%d", self.requestURLString, i]];
                [BooheeSessionDataTask DataTaskWithRequest:request CompletionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                    
                    NSMutableDictionary *dicM = [HTTPParser ParseBooheeSearchResultWithHTMLData:data];
                    
                    [subscriber sendNext:dicM];
                    [subscriber sendCompleted];
                }];
                return nil;
            }];
            [signalArrM addObject:signal];
        }
        RACSignal *reduceSignal = [RACSignal combineLatest:signalArrM reduce:^id( NSMutableDictionary *dataSourceDicM1, NSMutableDictionary *dataSourceDicM2, NSMutableDictionary *dataSourceDicM3, NSMutableDictionary *dataSourceDicM4, NSMutableDictionary *dataSourceDicM5, NSMutableDictionary *dataSourceDicM6, NSMutableDictionary *dataSourceDicM7, NSMutableDictionary *dataSourceDicM8, NSMutableDictionary *dataSourceDicM9, NSMutableDictionary *dataSourceDicM10){
            NSMutableDictionary *dataSourceDicM = [NSMutableDictionary dictionary];
            //添加数据
            [dataSourceDicM addEntriesFromDictionary:dataSourceDicM1];
            [dataSourceDicM addEntriesFromDictionary:dataSourceDicM2];
            [dataSourceDicM addEntriesFromDictionary:dataSourceDicM3];
            [dataSourceDicM addEntriesFromDictionary:dataSourceDicM4];
            [dataSourceDicM addEntriesFromDictionary:dataSourceDicM5];
            [dataSourceDicM addEntriesFromDictionary:dataSourceDicM6];
            [dataSourceDicM addEntriesFromDictionary:dataSourceDicM7];
            [dataSourceDicM addEntriesFromDictionary:dataSourceDicM8];
            [dataSourceDicM addEntriesFromDictionary:dataSourceDicM9];
            [dataSourceDicM addEntriesFromDictionary:dataSourceDicM10];
            
            return dataSourceDicM;
        }];
        [reduceSignal subscribeNext:^(NSMutableDictionary *dataSourceDicM) {
            NSLog(@"all signal Next");
            self.dataSource_DicM = dataSourceDicM;
            if (self.dataSource_DicM.count>0) {
                Easy_AsyncMainQueue(
                                    self.easy3DSemicircleView.dataSource = self;
                                    self.easy3DSemicircleView.frame = self.view.bounds;
                                    [self.view addSubview:self.easy3DSemicircleView];
                                    if (self.navigationController) {
                                        self.easy3DSemicircleView.frame = CGRectMake(0, CGRectGetMaxY(self.navigationController.navigationBar.frame), self.easy3DSemicircleView.mj_w, self.easy3DSemicircleView.mj_h-CGRectGetMaxY(self.navigationController.navigationBar.frame));
                                    }
                );
                
            }
        }];
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
    return self.dataSource_DicM.count;
}
-(Easy3DSemicircleViewCell *)easy3DSemicircleView:(Easy3DSemicircleView *)easy3DSemicircleView cellForRow:(NSInteger)row{
    CategoryCell *cell = (CategoryCell *)[easy3DSemicircleView dequeueReusableCellWithIdentifier:self.easy3DSemicircleView.reuseIdentifier inRow:row];
    if(!cell){
        cell = [[CategoryCell alloc] initWithStyle:Easy3DSemicircleViewCellStyleNone reuseIdentifier:self.easy3DSemicircleView.reuseIdentifier];
    }
    SearchListCellModel *model = [self.dataSource_DicM.allValues objectAtIndex:row];
    cell.model = model;
//    cell.title = model.title;
//    cell.laText = model.foodEnergy;
//    cell.title = [NSString stringWithFormat:@"row is %ld", row];
//    cell.laText = [NSString stringWithFormat:@"%ld", row];
    cell.backgroundColor = Easy_RandomColor;
    return cell;
}
#pragma mark ---- EasyFlowerViewDelegate
#pragma mark ---- Setter
#pragma mark ---- Getter
-(NSMutableDictionary *)dataSource_DicM{
    if (!_dataSource_DicM) {
        _dataSource_DicM = [NSMutableDictionary dictionary];
    }
    return _dataSource_DicM;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
