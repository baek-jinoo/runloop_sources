//
//  FTPBrain.m
//  FindThePrize
//
//  Created by Jin on 8/9/15.
//  Copyright (c) 2015 Baek. All rights reserved.
//

#import "FTPBrain.h"
#import "FTPCommand.h"
#import "FTPGameContext.h"
#import "FTPRobot.h"
#import "FTPCoordinate.h"

@interface FTPBrain ()

@property (weak, nonatomic) FTPRobot *robot;
@property (assign, nonatomic) BOOL key;

@end

@implementation FTPBrain

- (instancetype)initWithRobot:(id)robot;
{
    self = [super init];
    if (self) {
        _robot = robot;
    }
    return self;
}

- (FTPCommand *)nextCommandWithGameContext:(FTPGameContext *)gameContext; //TODONOW actually implement a smart bot
{
    self.key = arc4random() % 2;
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:4];
    [array addObject:[[FTPCommand alloc] initWithMovementDirection:FTPCommandMovementDirectionDown robot:self.robot]];
    [array addObject:[[FTPCommand alloc] initWithMovementDirection:FTPCommandMovementDirectionUp robot:self.robot]];
    [array addObject:[[FTPCommand alloc] initWithMovementDirection:FTPCommandMovementDirectionLeft robot:self.robot]];
    [array addObject:[[FTPCommand alloc] initWithMovementDirection:FTPCommandMovementDirectionRight robot:self.robot]];
    NSUInteger randomNumber = arc4random() % array.count;
    if (self.key) {
        return [array objectAtIndex:randomNumber];
    }
    else {
        FTPCoordinate *robotCoordinate = self.robot.occupyingCell.coordinate;
        if (robotCoordinate.x != gameContext.prizeCoordinate.x) {
            NSInteger diff = gameContext.prizeCoordinate.x - robotCoordinate.x;
            if (diff > 0) {
                return [[FTPCommand alloc] initWithMovementDirection:FTPCommandMovementDirectionRight robot:self.robot];
            }
            else {
                return [[FTPCommand alloc] initWithMovementDirection:FTPCommandMovementDirectionLeft robot:self.robot];
            }

        }
        else if (self.robot.occupyingCell.coordinate.y != gameContext.prizeCoordinate.y) {
            NSInteger diff = gameContext.prizeCoordinate.y - robotCoordinate.y;
            if (diff > 0) {
                return [[FTPCommand alloc] initWithMovementDirection:FTPCommandMovementDirectionDown robot:self.robot];
            }
            else {
                return [[FTPCommand alloc] initWithMovementDirection:FTPCommandMovementDirectionUp robot:self.robot];
            }
        }
    }
    return [array objectAtIndex:randomNumber];
}

@end
