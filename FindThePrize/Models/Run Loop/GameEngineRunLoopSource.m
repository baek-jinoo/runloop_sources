//
//  GameEngineRunLoopSource.m
//  FindThePrize
//
//  Created by Jin on 8/9/15.
//  Copyright (c) 2015 Baek. All rights reserved.
//

#import "GameEngineRunLoopSource.h"
#import "GameEngineRunLoopContext.h"
#import "MultiThreadManager.h"
#import "GameEngineProxy.h"

void MainRunLoopSourcePerformRoutine (void *info)
{
    GameEngineRunLoopSource *runLoopSource = (__bridge GameEngineRunLoopSource*)info;
    [runLoopSource sourceFired];
}

void MainRunLoopSourceScheduleRoutine (void *info, CFRunLoopRef runLoop, CFStringRef mode)
{
    GameEngineRunLoopSource *runLoopSource = (__bridge GameEngineRunLoopSource *)info;
    GameEngineRunLoopContext *theContext = [[GameEngineRunLoopContext alloc] initWithSource:runLoopSource andLoop:runLoop];

    MultiThreadManager *multiThreadManager = [MultiThreadManager sharedManager];
    [multiThreadManager performSelectorOnMainThread:@selector(registerMainThreadSource:)
                          withObject:theContext waitUntilDone:NO];
}

void MainRunLoopSourceCancelRoutine (void *info, CFRunLoopRef runLoop, CFStringRef mode)
{
    GameEngineRunLoopSource *runLoopSource = (__bridge GameEngineRunLoopSource*)info;
    GameEngineRunLoopContext *theContext = [[GameEngineRunLoopContext alloc] initWithSource:runLoopSource andLoop:runLoop];

    MultiThreadManager *multiThreadManager = [MultiThreadManager sharedManager];
    [multiThreadManager performSelectorOnMainThread:@selector(removeMainThreadSource:)
                          withObject:theContext waitUntilDone:YES];
}

@interface GameEngineRunLoopSource ()

@property (strong) NSLock *commandsLock;
@property (weak) GameEngineProxy *gameEngineProxy;

@end

@implementation GameEngineRunLoopSource

- (id)initWithGameEngineProxy:(id<GameEngineProxy>)gameEngineProxy
{
    self = [super init];
    if (self) {
        CFRunLoopSourceContext    context = {0, (__bridge void *)(self), NULL, NULL, NULL, NULL, NULL,
            &MainRunLoopSourceScheduleRoutine,
            MainRunLoopSourceCancelRoutine,
            MainRunLoopSourcePerformRoutine};

        runLoopSource = CFRunLoopSourceCreate(NULL, 0, &context);
        commands = [[NSMutableArray alloc] init];
        _commandsLock = [[NSLock alloc] init];
        _gameEngineProxy = gameEngineProxy;
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

- (void)sourceFired;
{
    [self.commandsLock lock];

    // get the data to do the command in the game engine
    NSString *stuff = (NSString *)[commands objectAtIndex:0];
    NSLog(@"this is the stuff: %@", stuff);

    [self.gameEngineProxy executeCommand:nil];


    // the game engine should then call the next robot's turn

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
