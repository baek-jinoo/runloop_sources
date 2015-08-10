//
//  Arena.m
//  FindThePrize
//
//  Created by Jin on 8/9/15.
//  Copyright (c) 2015 Baek. All rights reserved.
//

#import "Arena.h"
#import "BoardCellType.h"
#import "FTPBackgroundCell.h"
#import "Coordinate.h"
#import "FTPSize.h"
#import "Robot.h"
#import "Cell.h"
#import "FTPCommand.h"

@interface Arena ()

@property (strong, nonatomic) NSMutableArray *internalCells;
@property (strong, nonatomic) FTPSize *size;

@end

@implementation Arena

- (instancetype)initWithArenaSize:(FTPSize *)size;
{
    self = [super init];
    if (self) {
        _internalCells = [NSMutableArray array];
        [self setArenaSize:size];
    }
    return self;
}

- (void)placeRobot:(Robot *)robot;
{
    NSUInteger index = [self indexOfArrayForCoordinate:robot.coordinate];
    [self.internalCells replaceObjectAtIndex:index withObject:robot];
}

- (void)placePrizeCell:(id<Cell>)prizeCell;
{
    NSUInteger index = [self indexOfArrayForCoordinate:prizeCell.coordinate];
    [self.internalCells replaceObjectAtIndex:index withObject:prizeCell];
}

- (NSArray *)cells;
{
    return [self.internalCells copy];
}

- (Coordinate *)coordinateWithIndexOfArray:(NSUInteger)index size:(FTPSize *)size; //TODONOW move this to a better place
{
    NSUInteger row = index / size.width;
    NSUInteger column = index % size.width;
    return [[Coordinate alloc] initWithX:column Y:row];
}

- (void)clearArena;
{
    for (id<Cell> cell in [self.internalCells copy]) {
        if ([cell boardCellType] != BoardCellTypeBackground) {
            NSUInteger index = [self indexOfArrayForCoordinate:cell.coordinate];
            id<Cell> backgroundCell = [[FTPBackgroundCell alloc] initWithX:cell.coordinate.x Y:cell.coordinate.y];
            [self.internalCells replaceObjectAtIndex:index withObject:backgroundCell];
        }
    }
}

- (void)executeCommand:(FTPCommand *)command;
{
    NSLog(@"in arena execute command: %@", command);
    NSLog(@"in arena execute command with direciton: %ld", (long)command.movementDirection);
}

#pragma mark - Private

- (void)setArenaSize:(FTPSize *)size;
{
    _size = size;
    for (int i = 0; i < _size.width * _size.height; i++) {
        Coordinate *coordinate = [self coordinateWithIndexOfArray:i size:_size];
        id<Cell> backgroundCell = [[FTPBackgroundCell alloc] initWithX:coordinate.x Y:coordinate.y];
        [self.internalCells addObject:backgroundCell];
    }
}

- (NSUInteger)indexOfArrayForCoordinate:(Coordinate *)coordinate;
{
    return coordinate.y * self.size.width + coordinate.x;
}

@end
