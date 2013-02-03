//
//  SKAnimationSprite.h
//  Game
//
//  Created by Ilija Tovilo on 2/2/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "cocos2d.h"

@interface SKAnimationSprite : CCSprite

-(id)initWithDefaultSpriteFrameName:(NSString *)defaultSpriteFrameName
            animationConfigurations:(NSArray *)animationConfigurations;

+(id)spriteWithDefaultSpriteFrameName:(NSString *)defaultSpriteFrameName
              animationConfigurations:(NSArray *)animationConfigurations;

@property (retain) NSMutableDictionary *animations;

@end
