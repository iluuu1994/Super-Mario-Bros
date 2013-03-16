//
//  SKAnimationConfiguration.h
//  Game
//
//  Created by Ilija Tovilo on 2/3/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface STAnimationConfiguration : NSObject
{}

#pragma mark -
#pragma mark Properties
@property (strong) NSString *name;
@property (strong) NSString *frameNamePattern;
@property NSTimeInterval delay;
@property (nonatomic, readonly) CCAnimation *animation;

#pragma mark -
#pragma mark Initialise
- (id)initWithName:(NSString *)name
  frameNamePattern:(NSString *)frameNamePattern
             delay:(NSTimeInterval)delay;

+ (id)configurationWithName:(NSString *)name
  frameNamePattern:(NSString *)frameNamePattern
             delay:(NSTimeInterval)delay;

@end
