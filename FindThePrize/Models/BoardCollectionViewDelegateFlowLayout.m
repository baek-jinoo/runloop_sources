//
//  BoardCollectionViewDelegateFlowLayout.m
//  FindThePrize
//
//  Created by Jin on 8/8/15.
//  Copyright (c) 2015 Baek. All rights reserved.
//

#import "BoardCollectionViewDelegateFlowLayout.h"

#define GridSize 7

@implementation BoardCollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    CGFloat widthOfCollectionView = collectionView.bounds.size.width;
    CGFloat heightOfCollectionView = collectionView.bounds.size.height;

    CGFloat widthOfItem = widthOfCollectionView/GridSize;
    CGFloat heightOfItem = heightOfCollectionView/GridSize;

    return CGSizeMake(widthOfItem, heightOfItem);
}

@end
