//
//  BoardCollectionViewDelegateFlowLayout.m
//  FindThePrize
//
//  Created by Jin on 8/8/15.
//  Copyright (c) 2015 Baek. All rights reserved.
//

#import "BoardCollectionViewDelegateFlowLayout.h"

@interface BoardCollectionViewDelegateFlowLayout ()

@property (assign, nonatomic) NSUInteger gridSize;

@end

@implementation BoardCollectionViewDelegateFlowLayout

- (instancetype)initWithGridSize:(NSUInteger)gridSize;
{
    self = [super init];
    if (self) {
        _gridSize = gridSize;
    }
    return self;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    CGFloat widthOfCollectionView = collectionView.bounds.size.width;
    CGFloat heightOfCollectionView = collectionView.bounds.size.height;

    CGFloat widthOfItem = widthOfCollectionView/self.gridSize;
    CGFloat heightOfItem = heightOfCollectionView/self.gridSize;

    return CGSizeMake(widthOfItem, heightOfItem);
}

@end
