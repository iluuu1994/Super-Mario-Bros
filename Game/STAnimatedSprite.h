//
//  SKAnimationSprite.h
//  Game
//
//  Created by Ilija Tovilo on 2/2/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "cocos2d.h"
#import "NSBundle+Resources.h"

#pragma mark -
#pragma mark Constants

#ifndef AnimationPlistConstants
#define AnimationPlistConstants

#define kAnimationPlistAnimationsKey @"animations"
#define kAnimationPlistDelayKey @"delay"
#define kAnimationPlistAnimationFramesKey @"frames"

#endif



#pragma mark -
#pragma mark STAnimatedSprite Class

/**
 * STAnimatedSprite is a subclass of CCSprite.
 * It can dramatically simplify the process of initializing and running animations.
 * The animations can be configured in a .plist file.
 */
@interface STAnimatedSprite : CCSprite
{}

#pragma mark -
#pragma mark Initialise

/**
 * Init an animated sprite with the specific plist file.
 * @param plistFile - The plist file with the animation information
 * @return id - The initialised object
 */
-(id)initWithPlistFile:(NSString *)plistFile;

/**
 * Returns an animated sprite with the specific plist file.
 * @param plistFile - The plist file with the animation information
 * @return id - The initialised object
 */
+(id)spriteWithPlistFile:(NSString *)plistFile;

#pragma mark -
#pragma mark Properties

/**
 * The animations of the sprite.
 */
@property (strong) NSMutableDictionary *animations;

/**
 * The Animation Plist fetched into a dictionary.
 */
@property (strong) NSDictionary *animationDictionary;

/**
 * Specifies if the `update:` method should be invoked.
 */
@property (nonatomic, readonly) BOOL needsUpdate;

#pragma mark -
#pragma mark Methods

/**
 * Used for updating the sprite (invoked all 1/60s).
 * @param delta - The time that has passed since the last update
 */
- (void)update:(ccTime)delta;

/**
 * Displays a frame (must be in the sprite frame cache) with the name.
 * @param spriteFrameName - The name of the frame, that should be displayed
 */
- (void) displayFrameWithName:(NSString *)spriteFrameName;

/**
 * Run a specific animation.
 * All animations must be defined in the plist file, that is being initialized with `initWithPlistFile:`.
 * @param animName - The name of the animation
 * @param endlessFlag - Should the animation be repeated?
 */
- (void)runAnimationWithName:(NSString *)animName endless:(BOOL)endlessFlag;

/**
 * Runs a specific animation with a callback.
 * All animations must be defined in the plist file, that is being initialized with `initWithPlistFile:`.
 * @param animName - The name of the animation
 * @param block - The callback block that should be run when the animation is finished
 */
- (void)runAnimationWithName:(NSString *)animName callbackBlock:(void(^)())block;

@end
