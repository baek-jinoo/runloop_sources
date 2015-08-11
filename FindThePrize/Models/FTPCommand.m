//
//  FTPCommand.m
//  FindThePrize
//
//  Created by Jin on 8/10/15.
//  Copyright (c) 2015 Baek. All rights reserved.
//

#import "FTPCommand.h"
#import "FTPRobot.h"

@implementation FTPCommand

- (instancetype)initWithMovementDirection:(FTPCommandMovementDirection)movementDirection robot:(FTPRobot *)robot;
{
    self = [super init];
    if (self) {
        _movementDirection = movementDirection;
        _robot = robot;
    }
    return self;
}

@end
