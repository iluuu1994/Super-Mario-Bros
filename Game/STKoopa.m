//
//  STKoopa.m
//  Game
//
//  Created by Ilija Tovilo on 5/7/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "STKoopa.h"
#import "STPlayer.h"
#import "STBlock.h"


#pragma mark -
#pragma mark Constants

#define kSpeed 10
#define kProjectileSpeed 150
#define kScore 100



#pragma mark -
#pragma mark STKoopa Implementation

@implementation STKoopa



#pragma mark -
#pragma mark Initialization

- (id)init
{
    if (self = [super initWithPlistFile:@"Koopa.plist"]) {
        [self runAnimationWithName:@"walk" endless:YES];
        self.velocity = ccp(-kSpeed, 0);
    }
    return self;
}



#pragma mark -
#pragma mark Collision

- (void)collisionWithGameObject:(STGameObject *)gameObject edge:(STRectEdge)edge {
    if(edge != STRectEdgeMaxY && self.velocity.x != 0) {
        if(([[gameObject class] isSubclassOfClass:[STPlayer class]]) || self.isHidden) {
            if (![[gameObject class] isSubclassOfClass:[STBlock class]]) {
                [gameObject die];
            } else {
                [(STBlock *)gameObject awardPlayer:nil];
            }
        }
    }
    
    if((![[gameObject class] isSubclassOfClass:[STCreature class]] && self.isHidden) || !self.isHidden) {
        int speed = (self.isHidden) ? kProjectileSpeed : kSpeed;
        
        if (edge == STRectEdgeMinX && self.velocity.x < 0) {
            self.velocity = ccp(speed, self.velocity.y);
        } else if (edge == STRectEdgeMaxX && self.velocity.x > 0) {
            self.velocity = ccp(-speed, self.velocity.y);
        }
    }
    
    if([[gameObject class] isSubclassOfClass:[STPlayer class]]) {
        
        STPlayer *player = (STPlayer *) gameObject;
        
        if (self.isHidden) {
            // If we touch the hidden koopa he becomes a deadly projectile
            if (gameObject.velocity.x < 0) {
                self.velocity = ccpAdd(self.velocity, ccp(-kProjectileSpeed, self.velocity.y));
            } else {
                self.velocity = ccpAdd(self.velocity, ccp(kProjectileSpeed, self.velocity.y));
            }
        }
        
        if (edge == STRectEdgeMaxY) {
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
            }
            
        }
    }
}

- (void)die {
    [super die];
    
    // Play a sound
    [[STSoundManager sharedInstance] playEffect:kSoundStomp];
}

@end
