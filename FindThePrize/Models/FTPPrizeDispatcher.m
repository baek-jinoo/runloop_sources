//
//  FTPPrizeDispatcher.m
//  FindThePrize
//
//  Created by Jin on 8/9/15.
//  Copyright (c) 2015 Baek. All rights reserved.
//

#import "FTPPrizeDispatcher.h"
#import "Arena.h"
#import "Cell.h"
#import "FTPPrizeCell.h"

@interface FTPPrizeDispatcher ()

@property (strong, nonatomic) Arena *arena;
@property (strong, nonatomic) id<Cell> prizeCell;

@end

@implementation FTPPrizeDispatcher

- (instancetype)initWithArena:(Arena *)arena;
{
    self = [super init];
    if (self) {
        _arena = arena;
    }
    return self;
}

- (void)dispatchPrize;
{
    NSMutableArray *backgroundCells = [NSMutableArray arrayWithCapacity:self.arena.cells.count];
    for (id<Cell> cell in self.arena.cells) {
        if ([cell boardCellType] == BoardCellTypeBackground) {
            [backgroundCells addObject:cell];
        }
    }
    NSUInteger randomNumber = arc4random() % backgroundCells.count;
    Coordinate *coordinate = [self.arena coordinateWithIndexOfArray:randomNumber size:self.arena.size];
    self.prizeCell = [[FTPPrizeCell alloc] initWithX:coordinate.x Y:coordinate.y];
    [self.arena placePrizeCell:self.prizeCell];
}

@end
