//
//  SKAnimationSprite.h
//  Game
//
//  Created by Ilija Tovilo on 2/2/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "cocos2d.h"

@interface STAnimationSprite : CCSprite
{}

#pragma mark -
#pragma mark Initialise
-(id)initWithDefaultSpriteFrameName:(NSString *)defaultSpriteFrameName
            animationConfigurations:(NSArray *)animationConfigurations;

+(id)spriteWithDefaultSpriteFrameName:(NSString *)defaultSpriteFrameName
              animationConfigurations:(NSArray *)animationConfigurations;

#pragma mark -
#pragma mark Properties
@property (retain) NSMutableDictionary *animations;
@property (nonatomic, readonly) BOOL needsUpdate;

#pragma mark -
#pragma mark Methods
- (void)update:(ccTime)delta;

@end
