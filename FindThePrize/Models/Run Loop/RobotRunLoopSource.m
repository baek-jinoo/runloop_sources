//
//  RobotRunLoopSource.m
//  MultiThreadedSpike
//
//  Created by Jin on 8/6/15.
//  Copyright (c) 2015 Baek. All rights reserved.
//

#import "RobotRunLoopSource.h"
#import "RobotRunLoopContext.h"
#import "MultiThreadManager.h"
#import "Robot.h"
#import "GameContext.h"
#import "GameEngineRunLoopSource.h"
//#import "FTPCommand.h"

void RunLoopSourcePerformRoutine (void *info)
{
    RobotRunLoopSource *runLoopSource = (__bridge RobotRunLoopSource*)info;
    [runLoopSource sourceFired];
}

void RunLoopSourceScheduleRoutine (void *info, CFRunLoopRef runLoop, CFStringRef mode)
{
    RobotRunLoopSource *runLoopSource = (__bridge RobotRunLoopSource *)info;
    RobotRunLoopContext* theContext = [[RobotRunLoopContext alloc] initWithSource:runLoopSource andLoop:runLoop];

    MultiThreadManager *multiThreadManager = [MultiThreadManager sharedManager];
    [multiThreadManager performSelectorOnMainThread:@selector(registerSource:)
                          withObject:theContext waitUntilDone:NO];
}

void RunLoopSourceCancelRoutine (void *info, CFRunLoopRef runLoop, CFStringRef mode)
{
    RobotRunLoopSource *runLoopSource = (__bridge RobotRunLoopSource*)info;
    RobotRunLoopContext *theContext = [[RobotRunLoopContext alloc] initWithSource:runLoopSource andLoop:runLoop];

    MultiThreadManager *multiThreadManager = [MultiThreadManager sharedManager];
    [multiThreadManager performSelectorOnMainThread:@selector(removeSource:)
                          withObject:theContext waitUntilDone:YES];
}

@interface RobotRunLoopSource ()

@property (strong) NSLock *commandsLock;
@property (strong) Robot *robot;

@end

@implementation RobotRunLoopSource

- (id)initWithRobot:(Robot *)robot;
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
    NSLog(@"source fired");
    [self.commandsLock lock];

    // do fun stuff with the data
    GameContext *gameContext = (GameContext *)commands.lastObject;
    NSLog(@"=========>>> %@", gameContext);
    NSLog(@"=========>>> the robot is: %@", self.robot);
//    FTPCommand *nextCommand = [self.robot nextCommandWithGameContext:gameContext];
    [gameContext.gameEngineRunLoopSource addCommand:0 withData:@"next stuff"]; //TODONOW pass nextCommand here
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

