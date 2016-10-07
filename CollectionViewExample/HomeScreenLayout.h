//
//  HomeScreenLayout.h
//  CollectionViewExample
//
//  Created by Nanda Ballabh on 10/5/16.
//  Copyright © 2016 Nanda Ballabh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeScreenLayout : UICollectionViewLayout

@property (nonatomic) IBInspectable CGFloat hSpacing;
@property (nonatomic) IBInspectable CGFloat vSpacing;
@property (nonatomic) IBInspectable CGFloat itemHeight;
@property (nonatomic) IBInspectable NSInteger itemsInRow;

@end
