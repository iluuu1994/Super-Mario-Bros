//
//  SKAnimationSprite.h
//  Game
//
//  Created by Ilija Tovilo on 2/2/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "cocos2d.h"
#import "NSBundle+Resources.h"

#ifndef AnimationPlistConstants
#define AnimationPlistConstants

#define kAnimationPlistAnimationsKey @"animations"
#define kAnimationPlistDelayKey @"delay"
#define kAnimationPlistAnimationFramesKey @"frames"

#endif

@interface STAnimatedSprite : CCSprite
{}

#pragma mark -
#pragma mark Initialise

/**
 * Init an animated sprite with the specific plist file
 * @param plistFile - The plist file with the animation information
 * @return id - The initialised object
 */
-(id)initWithPlistFile:(NSString *)plistFile;

/**
 * Returns an animated sprite with the specific plist file
 * @param plistFile - The plist file with the animation information
 * @return id - The initialised object
 */
+(id)spriteWithPlistFile:(NSString *)plistFile;

#pragma mark -
#pragma mark Properties

/**
 * The animations of the sprite
 */
@property (strong) NSMutableDictionary *animations;

/**
 * The Animation Plist fetched into a dictionary
 */
@property (strong) NSDictionary *animationDictionary;

/**
 * Specifies if the `update:` method should be invoked
 */
@property (nonatomic, readonly) BOOL needsUpdate;

#pragma mark -
#pragma mark Methods

/**
 * Used for updating the sprite (invoked all 1/60s)
 * @param plistFile - The plist file with the animation information
 */
- (void)update:(ccTime)delta;

@end
