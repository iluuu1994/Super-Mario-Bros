//
//  STGumba.m
//  Game
//
//  Created by Ilija Tovilo on 5/7/13.
//  Copyright (c) 2013 by Lukas Seglias & Ilija Tovilo. All rights reserved.
//

#import "STGumba.h"
#import "STPlayer.h"

#pragma mark -
#pragma mark Constants

#define kSpeed 10
#define kScore 100



#pragma mark -
#pragma mark Implementation

@implementation STGumba
{}


#pragma mark -
#pragma mark Initialization

- (id)init
{
    if (self = [super initWithPlistFile:@"Gumba.plist"]) {
        [self runAnimationWithName:@"walk" endless:YES];
        self.velocity = ccp(-kSpeed, 0);
    }
    return self;
}


#pragma mark -
#pragma mark Collision

- (BOOL)differenciatesAppearance {
    return YES;
}



#pragma mark -
#pragma mark Collision

- (void)setAppearanceType:(STAppearanceType)appearanceType {
    [super setAppearanceType:appearanceType];
    [self runAnimationWithName:@"walk" endless:YES];
}

- (void)collisionWithGameObject:(STGameObject *)gameObject edge:(STRectEdge)edge {
    if (edge == STRectEdgeMinX && self.velocity.x < 0) {
        self.velocity = ccp(kSpeed, self.velocity.y);
    } else if (edge == STRectEdgeMaxX && self.velocity.x > 0) {
        self.velocity = ccp(-kSpeed, self.velocity.y);
    }
    
    if ([[gameObject class] isSubclassOfClass:[STPlayer class]]) {
        if (edge != STRectEdgeMaxY) {
            [(STPlayer *)gameObject die];
        } else {
            STPlayer *player = (STPlayer *) gameObject;
            
            // Make the other GameObject jump after jumping on this
            gameObject.velocity = ccpAdd(gameObject.velocity, ccp(0, 100));
            
            // Add a score
            player.score += kScore;
            
            // Show the die animation and kill this GameObject
            [self runAnimationWithName:@"die" callbackBlock:^void {
                [self die];
            }];
        }
    }
}

- (void)die {
    [super die];
    
    // Play a sound
    [[STSoundManager sharedInstance] playEffect:kSoundStomp];
}

@end
