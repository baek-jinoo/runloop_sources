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

@property (assign, nonatomic) BOOL teamOne;

@end

@implementation Robot

- (instancetype)initWithTeamOne:(BOOL)teamOne;
{
    self = [super init];
    if (self) {
        _teamOne = teamOne;
    }
    return self;
}

- (FTPCommand *)nextCommandWithGameContext:(GameContext *)gameContext;
{

    NSMutableArray *array = [NSMutableArray arrayWithCapacity:4];
    [array addObject:[[FTPCommand alloc] initWithMovementDirection:FTPCommandMovementDirectionDown robot:self]];
    [array addObject:[[FTPCommand alloc] initWithMovementDirection:FTPCommandMovementDirectionUp robot:self]];
    [array addObject:[[FTPCommand alloc] initWithMovementDirection:FTPCommandMovementDirectionLeft robot:self]];
    [array addObject:[[FTPCommand alloc] initWithMovementDirection:FTPCommandMovementDirectionRight robot:self]];
    NSUInteger randomNumber = arc4random() % array.count;
    return [array objectAtIndex:randomNumber];
//    if (self.teamOne) {
//        return [[FTPCommand alloc] initWithMovementDirection:FTPCommandMovementDirectionDown robot:self]; // TODONOW make this smart
//    }
//    else {
//        return [[FTPCommand alloc] initWithMovementDirection:FTPCommandMovementDirectionUp robot:self]; // TODONOW make this smart
//    }
}

@end
