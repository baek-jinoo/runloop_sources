//
//  FTPRobotRunLoopContext.m
//  MultiThreadedSpike
//
//  Created by Jin on 8/6/15.
//  Copyright (c) 2015 Baek. All rights reserved.
//

#import "FTPRobotRunLoopContext.h"

@implementation FTPRobotRunLoopContext

@synthesize runLoop = runLoop;
@synthesize source = source;

- (id)initWithSource:(FTPRobotRunLoopSource *)src andLoop:(CFRunLoopRef)loop;
{
    self = [super init];
    if (self) {
        source = src;
        runLoop = loop;
    }
    return self;
}

@end
