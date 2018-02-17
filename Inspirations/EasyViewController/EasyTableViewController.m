//
//  EasyTableViewController.m
//  Inspirations
//
//  Created by Easer on 2018/2/14.
//  Copyright © 2018年 Easer. All rights reserved.
//

#import "EasyTableViewController.h"

@interface EasyTableViewController (){
    NSMutableArray * _dataSource_MutableArr;
    NSMutableDictionary * _dataSource_MutableDic;
}

@end

@implementation EasyTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

#pragma mark - Table view delegate

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (self.CellAnimationType) {
        case TableCellAnimationTypeNone:
            break;
        case TableCellAnimationTypeInsertion:
            [self AnimationOfInsertingCell:cell forRowAtIndexPath:indexPath intoTableView:tableView];
            break;
    }
}

#pragma mark - Table view cell animations
- (void)AnimationOfInsertingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath intoTableView:(UITableView *)tableView{
    switch (indexPath.row%2) {
        case 0://设置Cell的动画效果为3D效果
            cell.layer.transform = CATransform3DMakeTranslation(cell.mj_w, 0, 0);
            break;
        case 1:
            cell.layer.transform = CATransform3DMakeTranslation(-cell.mj_w, 0, 0);
            break;
    }
    [UIView animateWithDuration:0.3 animations:^{
        cell.layer.transform = CATransform3DIdentity;
    }];
}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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

#pragma mark ---- Setter
-(void)setDataSource_MutableArr:(NSMutableArray *)dataSource_MutableArr{
    if ([dataSource_MutableArr isKindOfClass:[NSArray class]]) {
        dataSource_MutableArr = [NSMutableArray arrayWithArray:dataSource_MutableArr];
    }
    _dataSource_MutableArr = dataSource_MutableArr;
}
-(void)setDataSource_MutableDic:(NSMutableDictionary *)dataSource_MutableDic{
    if ([dataSource_MutableDic isKindOfClass:[NSDictionary class]]) {
        dataSource_MutableDic = [NSMutableDictionary dictionaryWithDictionary:dataSource_MutableDic];
    }
    _dataSource_MutableDic = dataSource_MutableDic;
}
#pragma mark ---- Getter
-(NSString *)reuseIdentifier{
    if (_reuseIdentifier == nil) {
        _reuseIdentifier = @"EasyTableViewCell";
    }
    return _reuseIdentifier;
}
-(NSMutableArray *)dataSource_MutableArr{
    if (!_dataSource_MutableArr) {
        _dataSource_MutableArr = [NSMutableArray array];
    }
    return _dataSource_MutableArr;
}
-(NSMutableDictionary *)dataSource_MutableDic{
    if (!_dataSource_MutableDic) {
        _dataSource_MutableDic = [NSMutableDictionary dictionary];
    }
    return _dataSource_MutableDic;
}

@end
