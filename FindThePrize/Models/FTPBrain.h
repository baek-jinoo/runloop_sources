//
//  FTPBrain.h
//  FindThePrize
//
//  Created by Jin on 8/9/15.
//  Copyright (c) 2015 Baek. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FTPCommand;
@class FTPGameContext;
@class FTPRobot;

@interface FTPBrain : NSObject

- (instancetype)initWithRobot:(FTPRobot *)robot NS_DESIGNATED_INITIALIZER;

- (FTPCommand *)nextCommandWithGameContext:(FTPGameContext *)gameContext;

- (instancetype)init NS_UNAVAILABLE;

@end
