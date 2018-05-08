//
//  RootCollectionViewController.m
//  Inspirations
//
//  Created by Easer on 2018/2/7.
//  Copyright © 2018年 Easer. All rights reserved.
//

#import "RootCollectionViewController.h"
#import "RootCollectionViewFlowLayout.h"
#import "RootCollectionViewCell.h"
#import "RootSessionDataTask.h"
#import "RootWebView.h"
#import "RootWebViewConfiguration.h"


@interface RootCollectionViewController ()

@property (nonatomic, strong) EasyCollectionViewFlowLayout *flowLayout;

@end

@implementation RootCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor brownColor];
    self.collectionView.backgroundColor = Easy_RandomColor;
    for (int i=1; i<100; ++i) {
        [self.dataSource_MutableArr addObject:@(i)];
    }
    
    self.collectionView.collectionViewLayout = self.flowLayout;
    
    self.collectionView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[RootCollectionViewCell class] forCellWithReuseIdentifier:self.reuseIdentifier];
    
    Easy_SharedAppDelegate(appDelegate);
    [appDelegate updateCurrentUserInfo];
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

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return self.dataSource_MutableArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RootCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.reuseIdentifier forIndexPath:indexPath];

    if (!cell) {
        cell = [[RootCollectionViewCell alloc] init];
    }
    cell.backgroundColor = Easy_RandomColor;
    // Configure the cell

    return cell;
}

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

#pragma mark ---- Getter
-(EasyCollectionViewFlowLayout *)flowLayout{
    if (!_flowLayout) {
        _flowLayout = [[EasyCollectionViewFlowLayout alloc] init];
    }
    return _flowLayout;
}

@end
