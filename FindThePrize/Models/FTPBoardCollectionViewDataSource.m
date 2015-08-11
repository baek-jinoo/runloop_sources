//
//  FTPBoardCollectionViewDataSource.m
//  FindThePrize
//
//  Created by Jin on 8/8/15.
//  Copyright (c) 2015 Baek. All rights reserved.
//

#import "FTPBoardCollectionViewDataSource.h"
#import "FTPBoardCollectionViewCell.h"
#import "Cell.h"

@interface FTPBoardCollectionViewDataSource ()

@property (strong, nonatomic) FTPArena *arena;

@end

@implementation FTPBoardCollectionViewDataSource

- (instancetype)initWithArena:(FTPArena *)arena;
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
    FTPBoardCollectionViewCell *boardCollectionViewCell = (FTPBoardCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];

    id<Cell> cell = (id<Cell>)[self.arena.cells objectAtIndex:indexPath.row];
    [boardCollectionViewCell setBoardType:[cell boardCellType]];

    return boardCollectionViewCell;
}

@end
