//
//  CCDirector+Transitions.h
//  Game
//
//  Created by Ilija Tovilo on 4/8/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "cocos2d.h"

@interface CCDirector (Transitions)

/**
 * Replaces the scene with an animation
 */
- (void)replaceScene:(CCScene *)scene
 withTransitionClass:(Class)transitionClass
            duration:(ccTime)duration;

@end
