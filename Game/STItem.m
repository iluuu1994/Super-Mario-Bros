//
//  STItem.m
//  Game
//
//  Created by Ilija Tovilo on 5/7/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "STItem.h"
#import "STPlayer.h"



#pragma mark -
#pragma mark STItem Implementation

@implementation STItem


#pragma mark -
#pragma mark Properties

- (STGameObjectBodyType)bodyType {
    return STGameObjectBodyTypeNonColliding;
}


#pragma mark -
#pragma mark Collision

- (void)collisionWithGameObject:(STGameObject *)gameObject
                           edge:(STRectEdge)edge {
    
    if ([[gameObject class] isSubclassOfClass:[STPlayer class]]) {
        [self awardPlayer:(STPlayer *)gameObject];
    }
}

- (void)awardPlayer:(STPlayer *)player {
    [self setDead:YES];
}

@end
