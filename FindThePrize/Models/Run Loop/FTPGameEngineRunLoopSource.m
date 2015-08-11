//
//  FTPGameEngineRunLoopSource.m
//  FindThePrize
//
//  Created by Jin on 8/9/15.
//  Copyright (c) 2015 Baek. All rights reserved.
//

#import "FTPGameEngineRunLoopSource.h"
#import "FTPGameEngineRunLoopContext.h"
#import "FTPMultiThreadManager.h"
#import "FTPGameEngineProxy.h"

void MainRunLoopSourcePerformRoutine (void *info)
{
    FTPGameEngineRunLoopSource *runLoopSource = (__bridge FTPGameEngineRunLoopSource *)info;
    [runLoopSource sourceFired];
}

void MainRunLoopSourceScheduleRoutine (void *info, CFRunLoopRef runLoop, CFStringRef mode)
{
    FTPGameEngineRunLoopSource *runLoopSource = (__bridge FTPGameEngineRunLoopSource *)info;
    FTPGameEngineRunLoopContext *theContext = [[FTPGameEngineRunLoopContext alloc] initWithSource:runLoopSource andLoop:runLoop];

    FTPMultiThreadManager *multiThreadManager = [FTPMultiThreadManager sharedManager];
    [multiThreadManager performSelectorOnMainThread:@selector(registerMainThreadSource:)
                          withObject:theContext waitUntilDone:NO];
}

void MainRunLoopSourceCancelRoutine (void *info, CFRunLoopRef runLoop, CFStringRef mode)
{
    FTPGameEngineRunLoopSource *runLoopSource = (__bridge FTPGameEngineRunLoopSource *)info;
    FTPGameEngineRunLoopContext *theContext = [[FTPGameEngineRunLoopContext alloc] initWithSource:runLoopSource andLoop:runLoop];

    FTPMultiThreadManager *multiThreadManager = [FTPMultiThreadManager sharedManager];
    [multiThreadManager performSelectorOnMainThread:@selector(removeMainThreadSource:)
                          withObject:theContext waitUntilDone:YES];
}

@interface FTPGameEngineRunLoopSource ()

@property (strong) NSLock *commandsLock;
@property (weak) FTPGameEngineProxy *gameEngineProxy;

@end

@implementation FTPGameEngineRunLoopSource

- (id)initWithGameEngineProxy:(id<FTPGameEngineProxy>)gameEngineProxy
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

    FTPCommand *nextCommand = (FTPCommand *)[commands objectAtIndex:0];
    [commands removeObjectAtIndex:0];
    [self.gameEngineProxy executeCommand:nextCommand];

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
