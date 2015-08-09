//
//  BoardCollectionViewDataSource.m
//  FindThePrize
//
//  Created by Jin on 8/8/15.
//  Copyright (c) 2015 Baek. All rights reserved.
//

#import "BoardCollectionViewDataSource.h"
#import "BoardCollectionViewCell.h"

@interface BoardCollectionViewDataSource ()

@property (strong, nonatomic) NSMutableArray *cellTypes;

@end

@implementation BoardCollectionViewDataSource

- (instancetype)init
{
    self = [super init];
    if (self) {
        _cellTypes = [NSMutableArray arrayWithCapacity:49];
        for (int i = 0; i < 49; i++) {
            [_cellTypes addObject:@(BoardCellTypeBackground)];
        }
    }
    return self;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView;
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
{
    return self.cellTypes.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    BoardCollectionViewCell *cell = (BoardCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell setBoardType:[[self.cellTypes objectAtIndex:indexPath.row] integerValue]];

    return cell;
}

@end
