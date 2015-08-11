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
#import "GameEngine.h"

@interface Arena ()

@property (strong, nonatomic) NSMutableArray *internalCells;
@property (strong, nonatomic) FTPSize *size;
@property (strong, nonatomic) NSMutableArray *robots;
@property (assign, nonatomic) BOOL winnerDeclared;

@end

@implementation Arena

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

- (void)insertRobot:(Robot *)robot coordinate:(Coordinate *)coordinate;
{
    FTPCell *cell = [self cellAtCoordinate:coordinate];
    [self placeRobot:robot cell:cell];
    [self.robots addObject:robot];
}

- (void)placeRobot:(Robot *)robot cell:(FTPCell *)cell;
{
    robot.occupyingCell = cell;
    cell.boardCellType = [self boardCellTypeForRobot:robot];
    cell.isOccupied = YES;
    cell.owner = robot;
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
    self.winnerDeclared = NO;
}

- (void)executeCommand:(FTPCommand *)command;
{
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
    Coordinate *newCoordinate;

    switch (direction) {
        case FTPCommandMovementDirectionDown:
            newCoordinate = [[Coordinate alloc] initWithX:robotOldCoordinate.x Y:robotOldCoordinate.y + 1];
            break;
        case FTPCommandMovementDirectionUp:
            newCoordinate = [[Coordinate alloc] initWithX:robotOldCoordinate.x Y:robotOldCoordinate.y - 1];
            break;
        case FTPCommandMovementDirectionLeft:
            newCoordinate = [[Coordinate alloc] initWithX:robotOldCoordinate.x - 1 Y:robotOldCoordinate.y];
            break;
        case FTPCommandMovementDirectionRight:
            newCoordinate = [[Coordinate alloc] initWithX:robotOldCoordinate.x + 1 Y:robotOldCoordinate.y];
            break;
        default:
            break;
    }
    // TODONOW deal with not going into opponent's trail

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
        if ([newCellToOccupy boardCellType] == BoardCellTypePrize) {
            [self.gameWinningDelegate gameWonBy:robot];
            self.winnerDeclared = YES;
            return;
        }

        // old cell
        if ([newCellToOccupy.owner isEqual:robot]) {
            robotOldCell.boardCellType = BoardCellTypeBackground;
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

- (BOOL)isValidCoordinate:(Coordinate *)coordinate;
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
