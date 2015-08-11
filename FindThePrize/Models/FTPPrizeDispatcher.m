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

@interface FTPPrizeDispatcher ()

@property (strong, nonatomic) Arena *arena;
@property (strong, nonatomic) Coordinate *prizeCoordinate;

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
    BOOL key = YES;
    NSUInteger randomNumber;
    while (key) {
        randomNumber = arc4random() % self.arena.cells.count;
        id<Cell> cell = [self.arena.cells objectAtIndex:randomNumber];

        if ([cell boardCellType] == BoardCellTypeBackground) {
            self.prizeCoordinate = [self.arena coordinateWithIndexOfArray:randomNumber size:self.arena.size];
            [self.arena placePrizeCellAtCoordinate:self.prizeCoordinate];
            key = NO;
        }
    }
}

@end
