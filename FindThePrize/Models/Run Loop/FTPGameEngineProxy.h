//
//  FTPGameEngineProxy.h
//  FindThePrize
//
//  Created by Jin on 8/10/15.
//  Copyright (c) 2015 Baek. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FTPCommand;
@protocol GameEngine;

@protocol FTPGameEngineProxy <NSObject>

- (void)executeCommand:(FTPCommand *)command;

@end

@interface FTPGameEngineProxy : NSObject <FTPGameEngineProxy>

- (instancetype)initWithGameEngine:(id<GameEngine>)gameEngine NS_DESIGNATED_INITIALIZER;

- (void)invalidate;

- (instancetype)init NS_UNAVAILABLE;

@end
