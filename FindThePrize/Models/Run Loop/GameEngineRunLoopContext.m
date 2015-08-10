//
//  GameEngineRunLoopContext.m
//  FindThePrize
//
//  Created by Jin on 8/9/15.
//  Copyright (c) 2015 Baek. All rights reserved.
//

#import "GameEngineRunLoopContext.h"
#import "GameEngineRunLoopSource.h"

@implementation GameEngineRunLoopContext

@synthesize runLoop = runLoop;
@synthesize source = source;

- (id)initWithSource:(GameEngineRunLoopSource *)src andLoop:(CFRunLoopRef)loop;
{
    self = [super init];
    if (self) {
        source = src;
        runLoop = loop;
    }
    return self;
}


@end
