//
//  GameEngineRunLoopContext.h
//  FindThePrize
//
//  Created by Jin on 8/9/15.
//  Copyright (c) 2015 Baek. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GameEngineRunLoopSource;

@interface GameEngineRunLoopContext : NSObject
{
    CFRunLoopRef runLoop;
    GameEngineRunLoopSource *source;
}

@property (readonly) CFRunLoopRef runLoop;
@property (readonly) GameEngineRunLoopSource *source;

- (id)initWithSource:(GameEngineRunLoopSource *)src andLoop:(CFRunLoopRef)loop;

@end
