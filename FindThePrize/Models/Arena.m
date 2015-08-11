//
//  Arena.m
//  FindThePrize
//
//  Created by Jin on 8/9/15.
//  Copyright (c) 2015 Baek. All rights reserved.
//

#import "Arena.h"
#import "BoardCellType.h"
#import "Coordinate.h"
#import "FTPSize.h"
#import "Robot.h"
#import "FTPCommand.h"
#import "FTPCell.h"

@interface Arena ()

@property (strong, nonatomic) NSMutableArray *internalCells;
@property (strong, nonatomic) FTPSize *size;
@property (strong, nonatomic) NSMutableArray *robots;

@end

@implementation Arena

- (instancetype)initWithArenaSize:(FTPSize *)size;
{
    self = [super init];
    if (self) {
        _internalCells = [NSMutableArray array];
        _robots = [NSMutableArray array];
        [self setArenaSize:size];
    }
    return self;
}

- (void)placeRobot:(Robot *)robot coordinate:(Coordinate *)coordinate;
{
    FTPCell *cell = [self cellAtCoordinate:coordinate];
    robot.occupyingCell = cell;
    cell.boardCellType = [self boardCellTypeForRobot:robot];
    [self.robots addObject:robot];
}

- (void)placePrizeCellAtCoordinate:(Coordinate *)coordinate;
{
    FTPCell *cell = [self cellAtCoordinate:coordinate];
    cell.boardCellType = BoardCellTypePrize;
    cell.hasPrize = YES;
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
    for (FTPCell *cell in self.internalCells) {
        [cell clearCell];
        cell.boardCellType = BoardCellTypeBackground;
    }
    [self.robots removeAllObjects];
}

- (void)executeCommand:(FTPCommand *)command;
{
    NSLog(@"in arena execute command: %@", command);
    NSLog(@"in arena execute command with direciton: %ld", (long)command.movementDirection);
    [self moveRobot:command.robot direction:command.movementDirection];
}

#pragma mark - Private

- (void)moveRobot:(Robot *)robot direction:(FTPCommandMovementDirection)direction;
{
    NSSet *set = [NSSet setWithArray:self.robots];
    if (![set containsObject:robot]) {
        NSAssert(YES, @"move robot called with an invalid robot");
        return;
    }

    Coordinate *robotOldCoordinate = robot.occupyingCell.coordinate;
    NSUInteger robotDestinationIndex;
    Coordinate *newCoordinate;

    switch (direction) {
        case FTPCommandMovementDirectionDown:
            newCoordinate = [[Coordinate alloc] initWithX:robotOldCoordinate.x Y:robotOldCoordinate.y + 1];
            robotDestinationIndex = [self indexOfArrayForCoordinate:newCoordinate];
            break;
        case FTPCommandMovementDirectionUp:
            newCoordinate = [[Coordinate alloc] initWithX:robotOldCoordinate.x Y:robotOldCoordinate.y - 1];
            robotDestinationIndex = [self indexOfArrayForCoordinate:newCoordinate];
            break;

        default:
            break;
    }

    if ([self isValidIndex:robotDestinationIndex]) {
        // clear up the old cell
        FTPCell *robotOldCell = robot.occupyingCell;
        robotOldCell.boardCellType = [self boardCellTypeTrailForRobot:robot];

        // change the new cell
        FTPCell *newCellToOccupy = [self cellAtCoordinate:newCoordinate];
        robot.occupyingCell = newCellToOccupy;
        newCellToOccupy.boardCellType = [self boardCellTypeForRobot:robot];
    }
}

- (BOOL)isValidIndex:(NSUInteger)index;
{
    if (index > 0 && self.cells.count > index) {
        return YES;
    }
    return NO;
}

- (void)setArenaSize:(FTPSize *)size;
{
    _size = size;
    for (int i = 0; i < _size.width * _size.height; i++) {
        Coordinate *coordinate = [self coordinateWithIndexOfArray:i size:_size];
        FTPCell *cell = [[FTPCell alloc] initWithCoordinate:coordinate];
        [self.internalCells addObject:cell];
    }
}

- (NSUInteger)indexOfArrayForCoordinate:(Coordinate *)coordinate;
{
    return coordinate.y * self.size.width + coordinate.x;
}


- (FTPCell *)cellAtCoordinate:(Coordinate *)coordinate;
{
    NSUInteger index = [self indexOfArrayForCoordinate:coordinate];
    return [self.internalCells objectAtIndex:index];
}

- (BoardCellType)boardCellTypeTrailForRobot:(Robot *)robot;
{
    if (robot.teamOne) {
        return BoardCellTypeRobot1Owned;
    }
    else {
        return BoardCellTypeRobot2Owned;
    }
}

- (BoardCellType)boardCellTypeForRobot:(Robot *)robot;
{
    if (robot.teamOne) {
        return BoardCellTypeRobot1;
    }
    else {
        return BoardCellTypeRobot2;
    }
}
@end
