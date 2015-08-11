//
//  FTPArena.m
//  FindThePrize
//
//  Created by Jin on 8/9/15.
//  Copyright (c) 2015 Baek. All rights reserved.
//

#import "FTPArena.h"
#import "FTPBoardCellType.h"
#import "FTPCoordinate.h"
#import "FTPSize.h"
#import "FTPRobot.h"
#import "FTPCommand.h"
#import "FTPCell.h"
#import "FTPGameEngine.h"

@interface FTPArena ()

@property (strong, nonatomic) NSMutableArray *internalCells;
@property (strong, nonatomic) FTPSize *size;
@property (strong, nonatomic) NSMutableArray *robots;
@property (assign, nonatomic) BOOL winnerDeclared;

@end

@implementation FTPArena

- (instancetype)initWithArenaSize:(FTPSize *)size;
{
    self = [super init];
    if (self) {
        _internalCells = [NSMutableArray array];
        _robots = [NSMutableArray array];
        _winnerDeclared = NO;
        [self setArenaSize:size];
    }
    return self;
}

- (void)insertRobot:(FTPRobot *)robot coordinate:(FTPCoordinate *)coordinate;
{
    FTPCell *cell = [self cellAtCoordinate:coordinate];
    [self placeRobot:robot cell:cell];
    [self.robots addObject:robot];
}

- (void)placeRobot:(FTPRobot *)robot cell:(FTPCell *)cell;
{
    robot.occupyingCell = cell;
    cell.boardCellType = [self boardCellTypeForRobot:robot];
    cell.isOccupied = YES;
    cell.owner = robot;
}

- (void)placePrizeCellAtCoordinate:(FTPCoordinate *)coordinate;
{
    FTPCell *cell = [self cellAtCoordinate:coordinate];
    cell.boardCellType = FTPBoardCellTypePrize;
    cell.hasPrize = YES;
}

- (NSArray *)cells;
{
    return [self.internalCells copy];
}

- (FTPCoordinate *)coordinateWithIndexOfArray:(NSUInteger)index size:(FTPSize *)size;
{
    NSUInteger row = index / size.width;
    NSUInteger column = index % size.width;
    return [[FTPCoordinate alloc] initWithX:column Y:row];
}

- (void)clearArena;
{
    for (FTPCell *cell in self.internalCells) {
        [cell clearCell];
        cell.boardCellType = FTPBoardCellTypeBackground;
    }
    [self.robots removeAllObjects];
    self.winnerDeclared = NO;
}

- (void)executeCommand:(FTPCommand *)command;
{
    [self moveRobot:command.robot direction:command.movementDirection];
}

#pragma mark - Private

- (void)moveRobot:(FTPRobot *)robot direction:(FTPCommandMovementDirection)direction;
{
    NSSet *set = [NSSet setWithArray:self.robots];
    if (![set containsObject:robot]) {
        NSAssert(YES, @"move robot called with an invalid robot");
        return;
    }

    FTPCoordinate *robotOldCoordinate = robot.occupyingCell.coordinate;
    FTPCoordinate *newCoordinate;

    switch (direction) {
        case FTPCommandMovementDirectionDown:
            newCoordinate = [[FTPCoordinate alloc] initWithX:robotOldCoordinate.x Y:robotOldCoordinate.y + 1];
            break;
        case FTPCommandMovementDirectionUp:
            newCoordinate = [[FTPCoordinate alloc] initWithX:robotOldCoordinate.x Y:robotOldCoordinate.y - 1];
            break;
        case FTPCommandMovementDirectionLeft:
            newCoordinate = [[FTPCoordinate alloc] initWithX:robotOldCoordinate.x - 1 Y:robotOldCoordinate.y];
            break;
        case FTPCommandMovementDirectionRight:
            newCoordinate = [[FTPCoordinate alloc] initWithX:robotOldCoordinate.x + 1 Y:robotOldCoordinate.y];
            break;
        default:
            break;
    }

    if ([self isValidCoordinate:newCoordinate]) {
        // clear up the old cell
        FTPCell *robotOldCell = robot.occupyingCell;
        FTPCell *newCellToOccupy = [self cellAtCoordinate:newCoordinate];

        if (newCellToOccupy.isOccupied) {
            return;
        }
        if (newCellToOccupy.owner && ![newCellToOccupy.owner isEqual:robot]) {
            return;
        }
        if ([newCellToOccupy boardCellType] == FTPBoardCellTypePrize) {
            [self.gameWinningDelegate gameWonBy:robot];
            self.winnerDeclared = YES;
            return;
        }

        // old cell
        if ([newCellToOccupy.owner isEqual:robot]) {
            robotOldCell.boardCellType = FTPBoardCellTypeBackground;
            robotOldCell.owner = nil;
        }
        else {
            robotOldCell.boardCellType = [self boardCellTypeTrailForRobot:robot];
        }
        robotOldCell.isOccupied = NO;

        // change the new cell
        [self placeRobot:robot cell:newCellToOccupy];
    }
}

- (BOOL)isValidCoordinate:(FTPCoordinate *)coordinate;
{
    FTPSize *boardSize = [self size];
    if (coordinate.x < 0) {
        return NO;
    }
    if (coordinate.x >= boardSize.width) {
        return NO;
    }
    if (coordinate.y < 0) {
        return NO;
    }
    if (coordinate.y >= boardSize.height) {
        return NO;
    }
    return YES;
}

- (void)setArenaSize:(FTPSize *)size;
{
    _size = size;
    for (int i = 0; i < _size.width * _size.height; i++) {
        FTPCoordinate *coordinate = [self coordinateWithIndexOfArray:i size:_size];
        FTPCell *cell = [[FTPCell alloc] initWithCoordinate:coordinate];
        [self.internalCells addObject:cell];
    }
}

- (NSUInteger)indexOfArrayForCoordinate:(FTPCoordinate *)coordinate;
{
    return coordinate.y * self.size.width + coordinate.x;
}


- (FTPCell *)cellAtCoordinate:(FTPCoordinate *)coordinate;
{
    NSUInteger index = [self indexOfArrayForCoordinate:coordinate];
    return [self.internalCells objectAtIndex:index];
}

- (FTPBoardCellType)boardCellTypeTrailForRobot:(FTPRobot *)robot;
{
    if (robot.teamOne) {
        return FTPBoardCellTypeRobot1Owned;
    }
    else {
        return FTPBoardCellTypeRobot2Owned;
    }
}

- (FTPBoardCellType)boardCellTypeForRobot:(FTPRobot *)robot;
{
    if (robot.teamOne) {
        return FTPBoardCellTypeRobot1;
    }
    else {
        return FTPBoardCellTypeRobot2;
    }
}
@end
