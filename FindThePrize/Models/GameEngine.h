//
//  GameEngine.h
//  FindThePrize
//
//  Created by Jin on 8/9/15.
//  Copyright (c) 2015 Baek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Arena.h"
#import "FTPSize.h"

@interface GameEngine : NSObject

- (instancetype)initWithArena:(Arena *)arena NS_DESIGNATED_INITIALIZER;

@property (strong, nonatomic, readonly) Arena *arena;

- (FTPSize *)arenaSize;

- (instancetype)init NS_UNAVAILABLE;

@end
