//
//  FTPGameEngineRunLoopContext.h
//  FindThePrize
//
//  Created by Jin on 8/9/15.
//  Copyright (c) 2015 Baek. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FTPGameEngineRunLoopSource;

@interface FTPGameEngineRunLoopContext : NSObject
{
    CFRunLoopRef runLoop;
    FTPGameEngineRunLoopSource *source;
}

@property (readonly) CFRunLoopRef runLoop;
@property (readonly) FTPGameEngineRunLoopSource *source;

- (id)initWithSource:(FTPGameEngineRunLoopSource *)src andLoop:(CFRunLoopRef)loop;

@end
