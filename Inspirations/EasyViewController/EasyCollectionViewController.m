//
//  BaseCollectionViewController.m
//  Inspirations
//
//  Created by Easer on 2018/2/7.
//  Copyright © 2018年 Easer. All rights reserved.
//

#import "EasyCollectionViewController.h"

@interface EasyCollectionViewController (){
    NSMutableArray * _dataSource_MutableArr;
    NSMutableDictionary * _dataSource_MutableDic;
}


@end

@implementation EasyCollectionViewController


-(instancetype)init{
    
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(88, 88);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self = [super initWithCollectionViewLayout:flowLayout];
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
//    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//#warning Incomplete implementation, return the number of sections
//    return 1;
//}
//
//
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of items
//    return 0;
//}
//
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
//
//    if (cell == nil) {
//        cell = [[UICollectionViewCell alloc] init];
//    }
//    cell.backgroundColor = Easy_RandomColor;
//    // Configure the cell
//
//    return cell;
//}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
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
        _reuseIdentifier = @"EasyCollectionViewCell";
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
