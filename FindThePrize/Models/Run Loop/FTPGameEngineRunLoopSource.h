//
//  FTPGameEngineRunLoopSource.h
//  FindThePrize
//
//  Created by Jin on 8/9/15.
//  Copyright (c) 2015 Baek. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FTPGameEngineProxy;

@interface FTPGameEngineRunLoopSource : NSObject

{
    CFRunLoopSourceRef runLoopSource;
    NSMutableArray* commands;
}

- (id)initWithGameEngineProxy:(id<FTPGameEngineProxy>)gameEngineProxy NS_DESIGNATED_INITIALIZER;
- (void)addToCurrentRunLoop;
- (void)invalidate;

- (void)sourceFired;

- (void)addCommand:(NSInteger)command withData:(id)data;
- (void)fireAllCommandsOnRunLoop:(CFRunLoopRef)runloop;

- (instancetype)init NS_UNAVAILABLE;

@end

void MainRunLoopSourceScheduleRoutine (void *info, CFRunLoopRef runLoop, CFStringRef mode);
void MainRunLoopSourcePerformRoutine (void *info);
void MainRunLoopSourceCancelRoutine (void *info, CFRunLoopRef runLoop, CFStringRef mode);
