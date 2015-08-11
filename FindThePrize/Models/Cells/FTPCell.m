//
//  FTPCell.m
//  FindThePrize
//
//  Created by Jin on 8/10/15.
//  Copyright (c) 2015 Baek. All rights reserved.
//

#import "FTPCell.h"
#import "Coordinate.h"
#import "Robot.h"

@interface FTPCell ()

@property (strong, nonatomic) Coordinate *coordinate;
//@property (strong, nonatomic) Robot *markedRobot;
//@property (assign, nonatomic) Robot *currentRobot;

@end

@implementation FTPCell

@synthesize hasPrize = _hasPrize;

- (instancetype)initWithCoordinate:(Coordinate *)coordinate;
{
    self = [super init];
    if (self) {
        _coordinate = coordinate;
        _hasPrize = NO;
        _boardCellType = BoardCellTypeBackground;
    }
    return self;
}

//- (BOOL)canBeOccupied;
//{
//    return (self.currentRobot == nil);
//}

- (void)clearCell;
{
    self.hasPrize = NO;
    self.isOccupied = NO;
    self.owner = nil;
}

//- (void)occupyWithRobot:(Robot *)robot;
//{
//    if (self.currentRobot) {
//        return;
//    }
//
//    self.markedRobot = robot;
//    self.currentRobot = robot;
//}
//
//- (void)removeOccupyingRobot;
//{
//    self.currentRobot = nil;
//}

//- (BoardCellType)boardCellType;
//{
//    BoardCellType boardCellType = BoardCellTypeBackground;
//
////    if (self.markedRobot) {
////        if (self.markedRobot.teamOne) {
////            boardCellType = BoardCellTypeRobot1Owned;
////        }
////        else {
////            boardCellType = BoardCellTypeRobot2Owned;
////        }
////    }
//
//    if (self.hasPrize) {
//        boardCellType = BoardCellTypePrize;
//    }
//
////    if (self.currentRobot) {
////        if (self.currentRobot.teamOne) {
////            boardCellType = BoardCellTypeRobot1;
////        }
////        else {
////            boardCellType = BoardCellTypeRobot2;
////        }
////    }
//
//    return boardCellType;
//}

@end
