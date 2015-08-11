//
//  FTPRobotRunLoopContext.h
//  MultiThreadedSpike
//
//  Created by Jin on 8/6/15.
//  Copyright (c) 2015 Baek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FTPRobotRunLoopSource.h"

@interface FTPRobotRunLoopContext : NSObject
{
    CFRunLoopRef runLoop;
    FTPRobotRunLoopSource *source;
}

@property (readonly) CFRunLoopRef runLoop;
@property (readonly) FTPRobotRunLoopSource *source;

- (id)initWithSource:(FTPRobotRunLoopSource *)src andLoop:(CFRunLoopRef)loop;

@end
