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
                          plistFile:(NSString *)plistFile
        spriteFrameNamingConvention:(NSString *)spriteFrameNamingConvention;

+(id)spriteWithDefaultSpriteFrameName:(NSString *)defaultSpriteFrameName
                            plistFile:(NSString *)plistFile
          spriteFrameNamingConvention:(NSString *)spriteFrameNamingConvention;

@end
