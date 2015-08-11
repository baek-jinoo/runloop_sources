//
//  FTPCell.m
//  FindThePrize
//
//  Created by Jin on 8/10/15.
//  Copyright (c) 2015 Baek. All rights reserved.
//

#import "FTPCell.h"
#import "FTPCoordinate.h"
#import "FTPRobot.h"

@interface FTPCell ()

@property (strong, nonatomic) FTPCoordinate *coordinate;

@end

@implementation FTPCell

@synthesize hasPrize = _hasPrize;

- (instancetype)initWithCoordinate:(FTPCoordinate *)coordinate;
{
    self = [super init];
    if (self) {
        _coordinate = coordinate;
        _hasPrize = NO;
        _boardCellType = FTPBoardCellTypeBackground;
    }
    return self;
}

- (void)clearCell;
{
    self.hasPrize = NO;
    self.isOccupied = NO;
    self.owner = nil;
}

@end
