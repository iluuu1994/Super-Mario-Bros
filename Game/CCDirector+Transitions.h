//
//  CCDirector+Transitions.h
//  Game
//
//  Created by Ilija Tovilo on 4/8/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "cocos2d.h"

/**
 * Helper for transitions with the CCDirector.
 */
@interface CCDirector (Transitions)
{}

#pragma mark -
#pragma mark Transitions
/**
 * Replaces the scene with an animation.
 * @property scene - The scene that should be displayed
 * @property transitionClass - The class of the transition that should be used
 * @property duration - The duration of the transition
 */
- (void)replaceScene:(CCScene *)scene
 withTransitionClass:(Class)transitionClass
            duration:(ccTime)duration;

@end
