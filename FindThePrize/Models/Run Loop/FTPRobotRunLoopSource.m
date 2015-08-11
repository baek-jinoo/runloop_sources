//
//  FTPRobotRunLoopSource.m
//  MultiThreadedSpike
//
//  Created by Jin on 8/6/15.
//  Copyright (c) 2015 Baek. All rights reserved.
//

#import "FTPRobotRunLoopSource.h"
#import "FTPRobotRunLoopContext.h"
#import "FTPMultiThreadManager.h"
#import "FTPRobot.h"
#import "FTPGameContext.h"
#import "FTPGameEngineRunLoopSource.h"
//#import "FTPCommand.h"

void RunLoopSourcePerformRoutine (void *info)
{
    FTPRobotRunLoopSource *runLoopSource = (__bridge FTPRobotRunLoopSource *)info;
    [runLoopSource sourceFired];
}

void RunLoopSourceScheduleRoutine (void *info, CFRunLoopRef runLoop, CFStringRef mode)
{
    FTPRobotRunLoopSource *runLoopSource = (__bridge FTPRobotRunLoopSource *)info;
    FTPRobotRunLoopContext * theContext = [[FTPRobotRunLoopContext alloc] initWithSource:runLoopSource andLoop:runLoop];

    FTPMultiThreadManager *multiThreadManager = [FTPMultiThreadManager sharedManager];
    [multiThreadManager performSelectorOnMainThread:@selector(registerSource:)
                          withObject:theContext waitUntilDone:NO];
}

void RunLoopSourceCancelRoutine (void *info, CFRunLoopRef runLoop, CFStringRef mode)
{
    FTPRobotRunLoopSource *runLoopSource = (__bridge FTPRobotRunLoopSource *)info;
    FTPRobotRunLoopContext *theContext = [[FTPRobotRunLoopContext alloc] initWithSource:runLoopSource andLoop:runLoop];

    FTPMultiThreadManager *multiThreadManager = [FTPMultiThreadManager sharedManager];
    [multiThreadManager performSelectorOnMainThread:@selector(removeSource:)
                          withObject:theContext waitUntilDone:YES];
}

@interface FTPRobotRunLoopSource ()

@property (strong) NSLock *commandsLock;
@property (strong) FTPRobot *robot;

@end

@implementation FTPRobotRunLoopSource

- (id)initWithRobot:(FTPRobot *)robot;
{
    self = [super init];
    if (self) {
        CFRunLoopSourceContext    context = {0, (__bridge void *)(self), NULL, NULL, NULL, NULL, NULL,
            &RunLoopSourceScheduleRoutine,
            RunLoopSourceCancelRoutine,
            RunLoopSourcePerformRoutine};

        runLoopSource = CFRunLoopSourceCreate(NULL, 0, &context);
        commands = [[NSMutableArray alloc] init];
        _commandsLock = [[NSLock alloc] init];
        _robot = robot;
    }
    return self;
}

- (void)addToCurrentRunLoop;
{
    CFRunLoopRef runLoop = CFRunLoopGetCurrent();
    CFRunLoopAddSource(runLoop, runLoopSource, kCFRunLoopDefaultMode);
}

- (void)invalidate;
{
    CFRunLoopSourceInvalidate(runLoopSource);
}

// Handler method
- (void)sourceFired;
{
    [self.commandsLock lock];

    // do fun stuff with the data
    FTPGameContext *gameContext = (FTPGameContext *)commands.lastObject;
    [commands removeObjectAtIndex:0];
    FTPCommand *nextCommand = [self.robot nextCommandWithGameContext:gameContext];
    [gameContext.gameEngineRunLoopSource addCommand:0 withData:nextCommand];
    [gameContext.gameEngineRunLoopSource fireAllCommandsOnRunLoop:[NSRunLoop mainRunLoop].getCFRunLoop];


    [self.commandsLock unlock];
}

- (void)addCommand:(NSInteger)command withData:(id)data;
{
    [self.commandsLock lock];

    [commands addObject:data];

    [self.commandsLock unlock];
}

- (void)fireAllCommandsOnRunLoop:(CFRunLoopRef)runloop;
{
    CFRunLoopSourceSignal(runLoopSource);
    CFRunLoopWakeUp(runloop);
}

@end

