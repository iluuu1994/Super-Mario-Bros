//
//  STKoopa.m
//  Game
//
//  Created by Ilija Tovilo on 5/7/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "STKoopa.h"
#import "STPlayer.h"

#define kSpeed 10
#define kProjectileSpeed 70
#define kScore 100

@implementation STKoopa

- (id)init
{
    if (self = [super initWithPlistFile:@"Koopa.plist"]) {
        [self runAnimationWithName:@"walk" endless:YES];
        self.velocity = ccp(-kSpeed, 0);
    }
    return self;
}

- (void)collisionWithGameObject:(STGameObject *)gameObject edge:(STRectEdge)edge {
    // If it collides with a non-living thing while its hidden or if its just not hidden.
    if((![[gameObject class] isSubclassOfClass:[STCreature class]] && self.isHidden) || !self.isHidden) {
        int speed = (self.isHidden) ? kProjectileSpeed : kSpeed;
        
        if (edge == STRectEdgeMinX && self.velocity.x < 0) {
            self.velocity = ccp(speed, self.velocity.y);
        } else if (edge == STRectEdgeMaxX && self.velocity.x > 0) {
            self.velocity = ccp(-speed, self.velocity.y);
        }
    }
    
    if(edge == STRectEdgeMaxY && [[gameObject class] isSubclassOfClass:[STPlayer class]]) {
        STPlayer *player = (STPlayer *) gameObject;

        // Make the other GameObject jump after jumping on this
        gameObject.velocity = ccpAdd(gameObject.velocity, ccp(0, 100));
        
        // Play a sound
        [[STSoundManager sharedInstance] playEffect:kSoundStomp];
        
        if (!self.isHidden) {
            // Add a score
            player.score += kScore;
        
            // Hide the koopa in the armor and make it a deadly projectile
            [self runAnimationWithName:@"armor" endless:YES];
            self.isHidden = YES;
            self.velocity = ccp(0, 0);
            
        } else {
            // If we jump on the koopa again when he is hidden, he becomes a deadly projectile
            if (gameObject.velocity.x < 0) {
                self.velocity = ccpAdd(self.velocity, ccp(-kProjectileSpeed, self.velocity.y));
            } else {
                self.velocity = ccpAdd(self.velocity, ccp(kProjectileSpeed, self.velocity.y));
            }
        }
    }
    
    // If this Koopa is a deadly projectile
    if((edge == STRectEdgeMaxX || edge == STRectEdgeMinX) && self.isHidden && self.velocity.x != 0) {
        
        // The projectile kills all creatures.
        if([[gameObject class] isSubclassOfClass:[STCreature class]]) {
            [gameObject setDead:YES];
        }
    }
}

@end
