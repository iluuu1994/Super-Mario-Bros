//
//  STFlower.m
//  Game
//
//  Created by Ilija Tovilo on 5/11/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "STFlower.h"
#import "STPlayer.h"

@implementation STFlower

- (id)init
{
    if (self = [super initWithPlistFile:@"Flower.plist"]) {
        [self runAnimationWithName:@"glare" endless:YES];
    }
    return self;
}

- (void)collisionWithGameObject:(STGameObject *)gameObject
                           edge:(STRectEdge)edge {

    
    if ([[gameObject class] isSubclassOfClass:[STPlayer class]]) {
        STPlayer *player = (STPlayer *)gameObject;
        if (player.playerState != STPlayerStateFire) {
            player.playerState = STPlayerStateFire;
        }
    }
}

@end
