//
//  GameEngineProxy.h
//  FindThePrize
//
//  Created by Jin on 8/10/15.
//  Copyright (c) 2015 Baek. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FTPCommand;
@protocol GameEngine;

@protocol GameEngineProxy <NSObject>

- (void)executeCommand:(FTPCommand *)command;

@end

@interface GameEngineProxy : NSObject <GameEngineProxy>

- (instancetype)initWithGameEngine:(id<GameEngine>)gameEngine NS_DESIGNATED_INITIALIZER;

- (void)invalidate;

- (instancetype)init NS_UNAVAILABLE;

@end
