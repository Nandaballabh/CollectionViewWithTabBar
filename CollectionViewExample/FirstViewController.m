//
//  FirstViewController.m
//  CollectionViewExample
//
//  Created by Nanda Ballabh on 10/5/16.
//  Copyright © 2016 Nanda Ballabh. All rights reserved.
//

#import "FirstViewController.h"
#import "NavExampleViewController.h"
#import "AppDelegate.h"

@interface FirstViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"homeScreenCollectionCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark UICollectionViewDelegate and UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 10;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"homeScreenCollectionCell" forIndexPath:indexPath];
    if(indexPath.row == 0) {
        cell.contentView.backgroundColor = [UIColor redColor];
    } else if(indexPath.row % 2 == 0)
        cell.contentView.backgroundColor = [UIColor greenColor];
    else
        cell.contentView.backgroundColor = [UIColor blueColor];
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.navigationController pushViewController:[NavExampleViewController new] animated:YES];
    
}


@end
