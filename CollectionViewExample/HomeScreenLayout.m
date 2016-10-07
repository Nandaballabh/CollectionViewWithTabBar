//
//  HomeScreenLayout.m
//  CollectionViewExample
//
//  Created by Nanda Ballabh on 10/5/16.
//  Copyright © 2016 Nanda Ballabh. All rights reserved.
//

#import "HomeScreenLayout.h"

@interface HomeScreenLayout()
{
    NSMutableDictionary *_layoutAttributes;
    CGSize _contentSize;
}

@end

@implementation HomeScreenLayout

- (void)prepareLayout
{
    [super prepareLayout];
        
    _layoutAttributes = [NSMutableDictionary dictionary];
    CGFloat xOffset = self.hSpacing;
    CGFloat yOffset = self.vSpacing;

    NSUInteger numberOfSections = [self.collectionView numberOfSections];

    for (int section = 0; section < numberOfSections; section++)
    {
        
        // Header Attributes for sections
        
        NSIndexPath * headerPath = [NSIndexPath indexPathForRow:0 inSection:section];
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader withIndexPath:headerPath];
        attributes.frame = CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.collectionView.bounds), 0.1f);
        NSString *headerKey = [self layoutKeyForHeaderAtIndexPath:headerPath];
        _layoutAttributes[headerKey] = attributes;

        // Items Attributes for section
        
        NSUInteger numberOfItems = [self.collectionView numberOfItemsInSection:section];
        for (int item = 0; item < numberOfItems; item++)
        {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
           
            // Item attributes
            CGSize itemSize = [self itemSizeForIndexPath:indexPath];
            attributes.frame = CGRectIntegral(CGRectMake(xOffset, yOffset, itemSize.width, itemSize.height));
            NSString *key = [self layoutKeyForIndexPath:indexPath];
            _layoutAttributes[key] = attributes;
            
            xOffset += itemSize.width;
            xOffset += self.hSpacing;
            
            // Next row in section
            if ((item == 0) || (item % self.itemsInRow == 0))
            {
                yOffset += self.vSpacing;
                yOffset += self.itemHeight;
                xOffset = self.hSpacing;
            }
        }
    }
    
    yOffset += self.itemHeight;
    
    _contentSize = CGSizeMake(CGRectGetWidth(self.collectionView.bounds), yOffset + self.vSpacing);

}

#pragma mark -
#pragma mark - Helpers Methods

- (CGSize) itemSizeForIndexPath:(NSIndexPath *) indexpath {
   
    CGSize itemSize = CGSizeZero;
    
    if(indexpath.row == 0) {
        
        itemSize = CGSizeMake(CGRectGetWidth(self.collectionView.bounds) - 2 * self.hSpacing, self.itemHeight);
        
    } else {
        
        CGFloat itemWidth = (CGRectGetWidth(self.collectionView.bounds) - (self.itemsInRow + 1) *  self.hSpacing)/self.itemsInRow;
        itemSize = CGSizeMake(itemWidth, self.itemHeight);
    }
    return itemSize;
}


- (NSString *)layoutKeyForIndexPath:(NSIndexPath *)indexPath
{
    return [NSString stringWithFormat:@"%ld_%ld", (long)indexPath.section, (long)indexPath.row];
}

- (NSString *)layoutKeyForHeaderAtIndexPath:(NSIndexPath *)indexPath
{
    return [NSString stringWithFormat:@"h_%ld_%ld", (long)indexPath.section, (long)indexPath.row];
}
#pragma mark -
#pragma mark - Invalidate

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return !(CGSizeEqualToSize(newBounds.size, self.collectionView.frame.size));
}

#pragma mark -
#pragma mark - Required methods

- (CGSize)collectionViewContentSize
{
    return _contentSize;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    NSString *headerKey = [self layoutKeyForHeaderAtIndexPath:indexPath];
    return _layoutAttributes[headerKey];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *key = [self layoutKeyForIndexPath:indexPath];
    return _layoutAttributes[key];
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(NSString *evaluatedObject, NSDictionary *bindings) {
        UICollectionViewLayoutAttributes *layoutAttribute = _layoutAttributes[evaluatedObject];
        return CGRectIntersectsRect(rect, [layoutAttribute frame]);
    }];
    
    NSArray *matchingKeys = [[_layoutAttributes allKeys] filteredArrayUsingPredicate:predicate];
    return [_layoutAttributes objectsForKeys:matchingKeys notFoundMarker:[NSNull null]];
}

@end
