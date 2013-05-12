//
//  STItem.m
//  Game
//
//  Created by Ilija Tovilo on 5/7/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "STItem.h"
#import "STPlayer.h"

@implementation STItem

- (STGameObjectBodyType)bodyType {
    return STGameObjectBodyTypeNonColliding;
}

- (void)collisionWithGameObject:(STGameObject *)gameObject
                           edge:(STRectEdge)edge {
    
    NSLog(@"test");
    if ([[gameObject class] isSubclassOfClass:[STPlayer class]]) {
        [self awardPlayer:(STPlayer *)gameObject];
    }
}

- (void)awardPlayer:(STPlayer *)player {
    [self setDead:YES];
}

@end
