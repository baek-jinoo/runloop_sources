//
//  BoardCollectionViewDataSource.m
//  FindThePrize
//
//  Created by Jin on 8/8/15.
//  Copyright (c) 2015 Baek. All rights reserved.
//

#import "BoardCollectionViewDataSource.h"
#import "BoardCollectionViewCell.h"
#import "Cell.h"

@interface BoardCollectionViewDataSource ()

@property (strong, nonatomic) Arena *arena;

@end

@implementation BoardCollectionViewDataSource

- (instancetype)initWithArena:(Arena *)arena;
{
    self = [super init];
    if (self) {
        _arena = arena;
    }
    return self;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView;
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
{
    return self.arena.cells.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    BoardCollectionViewCell *boardCollectionViewCell = (BoardCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];

    id<Cell> cell = (id<Cell>)[self.arena.cells objectAtIndex:indexPath.row];
    [boardCollectionViewCell setBoardType:[cell boardCellType]];

    return boardCollectionViewCell;
}

@end
