//
//  FoodTableVC.m
//  Inspirations
//
//  Created by Easer on 2018/2/14.
//  Copyright © 2018年 Easer. All rights reserved.
//

#import "FoodTableVC.h"
#import "FoodTableViewCell.h"
#import "CategoryListVC.h"
#import "FoodCategoryModel.h"
#import "RootNavigationController.h"

@interface FoodTableVC ()

@property (nonatomic, copy) void(^subtitleBlock)(NSString* str);

@end

@implementation FoodTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.CellAnimationType = TableCellAnimationTypeInsertion;
    self.title = FoodEnergySearchTitle;
    self.subtitleBlock = ^(NSString *str) {
        NSMutableURLRequest *request = [BooheeSessionDataTask requestWithRequestUrlString:str];
        NSLog(@"str is %@, url is %@", str, request.URL.absoluteString);
    };
    [self.tableView registerClass:[FoodTableViewCell class] forCellReuseIdentifier:self.reuseIdentifier];
    self.tempCell = [[FoodTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.reuseIdentifier];
    
    NSMutableURLRequest *request = [BooheeSessionDataTask requestWithRequestUrlString:BooheeFoodURLString];
    [BooheeSessionDataTask DataTaskWithRequest:request CompletionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        self.dataSource_MutableDic = [HTTPParser ParseBooheeFoodHomePageWithHTMLData:data];
        Easy_AsyncMainQueue([self.tableView reloadData];);
    }];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    FoodTableViewCell *cell = self.tempCell;
    cell.model = [self.dataSource_MutableDic.allValues objectAtIndex:indexPath.row];
    return [cell cellHeight];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource_MutableDic.count;
}

- (FoodTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FoodTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.reuseIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[FoodTableViewCell alloc] init];
    }
    cell.subtitleBlock = self.subtitleBlock;
    cell.model = [self.dataSource_MutableDic.allValues objectAtIndex:indexPath.row];
    cell.backgroundColor = Easy_RandomColor;
    return cell;
}

#pragma mark - Table view delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FoodCategoryModel *model = [self.dataSource_MutableDic.allValues objectAtIndex:indexPath.row];
    CategoryListVC *vc = [[CategoryListVC alloc] init];
    vc.title = @"分类";
    vc.requestURLString = model.detailURLString;
    [self.navigationController pushViewController:vc animated:YES];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
