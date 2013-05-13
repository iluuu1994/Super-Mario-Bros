//
//  CCDirector+Transitions.m
//  Game
//
//  Created by Ilija Tovilo on 4/8/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "CCDirector+Transitions.h"

#pragma mark -
#pragma mark CCDirector (Transitions) Implementation

@implementation CCDirector (Transitions)



#pragma mark -
#pragma mark Transitions

- (void)replaceScene:(CCScene *)scene
 withTransitionClass:(Class)transitionClass
            duration:(ccTime)duration {
    
    [self replaceScene:[transitionClass transitionWithDuration:duration scene:scene]];
}

@end
