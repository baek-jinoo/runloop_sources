//
//  FTPGameEngineRunLoopContext.m
//  FindThePrize
//
//  Created by Jin on 8/9/15.
//  Copyright (c) 2015 Baek. All rights reserved.
//

#import "FTPGameEngineRunLoopContext.h"
#import "FTPGameEngineRunLoopSource.h"

@implementation FTPGameEngineRunLoopContext

@synthesize runLoop = runLoop;
@synthesize source = source;

- (id)initWithSource:(FTPGameEngineRunLoopSource *)src andLoop:(CFRunLoopRef)loop;
{
    self = [super init];
    if (self) {
        source = src;
        runLoop = loop;
    }
    return self;
}


@end
