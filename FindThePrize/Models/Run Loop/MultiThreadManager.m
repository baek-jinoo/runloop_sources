//
//  MultiThreadManager.m
//  FindThePrize
//
//  Created by Jin on 8/9/15.
//  Copyright (c) 2015 Baek. All rights reserved.
//

#import "MultiThreadManager.h"
#import "Robot.h"
#import "RobotRunLoopContext.h"
#import "GameContext.h"
#import "GameEngine.h"

@interface MultiThreadManager ()

@property (strong) NSMutableArray *sourcesToPing;
@property (strong) NSMutableArray *mainThreadSources;

@end

@implementation MultiThreadManager

+ (instancetype)sharedManager;
{
    static MultiThreadManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _sourcesToPing = [NSMutableArray array];
        _mainThreadSources = [NSMutableArray array];
    }
    return self;
}

- (void)pingSourceAtIndex:(NSUInteger)index gameContext:(GameContext *)gameContext;
{
    if (_sourcesToPing.count > 0) {
        RobotRunLoopContext* sourceContext = [_sourcesToPing objectAtIndex:index];

        [sourceContext.source addCommand:0 withData:gameContext];

        [sourceContext.source fireAllCommandsOnRunLoop:sourceContext.runLoop];
    }
}

- (void)stopSourceAtIndex:(NSUInteger)index;
{
    if (_sourcesToPing.count) {
        RobotRunLoopContext* sourceContext = [_sourcesToPing objectAtIndex:index];
        [sourceContext.source invalidate];
    }
}

- (void)registerSource:(RobotRunLoopContext *)robotRunLoopContext;
{
    [self.sourcesToPing addObject:robotRunLoopContext];
    [self.gameEngine totalRobotWorkerSourceRegistered:self.sourcesToPing.count];
}

- (void)removeAllSource;
{
    [self.sourcesToPing removeAllObjects];
}

- (void)removeSource:(RobotRunLoopContext *)robotRunLoopContext;
{
    id  objectToRemove = nil;

    for (RobotRunLoopContext* context in self.sourcesToPing)
    {
        if ([context isEqual:robotRunLoopContext])
        {
            objectToRemove = context;
            break;
        }
    }

    if (objectToRemove) {
        [self.sourcesToPing removeObject:objectToRemove];
    }
}

- (void)registerMainThreadSource:(GameEngineRunLoopContext *)gameEngineRunLoopContext;
{
    [self.mainThreadSources addObject:gameEngineRunLoopContext];
}

- (void)removeMainThreadSource:(GameEngineRunLoopContext *)gameEngineRunLoopContext;
{
    id  objectToRemove = nil;

    for (GameEngineRunLoopContext* context in self.mainThreadSources)
    {
        if ([context isEqual:gameEngineRunLoopContext])
        {
            objectToRemove = context;
            break;
        }
    }

    if (objectToRemove) {
        [self.mainThreadSources removeObject:objectToRemove];
    }
}

- (void)workerThreadWithRobot:(Robot *)robot;
{
    BOOL done = NO;

    // Add your sources or timers to the run loop and do any other setup.
    RobotRunLoopSource *customRunLoopSource = [[RobotRunLoopSource alloc] initWithRobot:robot];
    [customRunLoopSource addToCurrentRunLoop];

    do
    {
        // Start the run loop but return after each source is handled.
        SInt32 result = CFRunLoopRunInMode(kCFRunLoopDefaultMode, 5, YES);

        // If a source explicitly stopped the run loop, or if there are no
        // sources or timers, or our runloopSource is invalid ->
        // go ahead and exit.
        if ((result == kCFRunLoopRunStopped) || (result == kCFRunLoopRunFinished)) {
            done = YES;
        }
    }
    while (!done);

}
@end
