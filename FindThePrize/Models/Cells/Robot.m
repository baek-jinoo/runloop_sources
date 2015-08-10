//
//  Robot.m
//  FindThePrize
//
//  Created by Jin on 8/9/15.
//  Copyright (c) 2015 Baek. All rights reserved.
//

#import "Robot.h"

#import "GameContext.h"
#import "FTPCommand.h"
#import "Coordinate.h"

@interface Robot ()

@property (strong, nonatomic) Coordinate *coordinate;
@property (assign, nonatomic) BOOL teamOne;

@end

@implementation Robot

- (instancetype)initWithX:(NSUInteger)x Y:(NSUInteger)y teamOne:(BOOL)teamOne;
{
    self = [super init];
    if (self) {
        _coordinate = [[Coordinate alloc] initWithX:x Y:y];
        _teamOne = teamOne;
    }
    return self;
}

- (BoardCellType)boardCellType;
{
    if (self.teamOne) {
        return BoardCellTypeRobot1;
    }
    return BoardCellTypeRobot2;
}

- (FTPCommand *)nextCommandWithGameContext:(GameContext *)gameContext;
{
    return [[FTPCommand alloc] initWithMovementDirection:FTPCommandMovementDirectionDown robot:self];
}

@end
