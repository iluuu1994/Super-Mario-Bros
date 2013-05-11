//
//  STBlock.m
//  Game
//
//  Created by Ilija Tovilo on 2/5/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "STBlock.h"
#import "STPlayer.h"

@implementation STBlock

#pragma mark -
#pragma mark Initialise
- (id)init
{
    if (self = [super init]) {
        [self setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"block"]];
    }
    return self;
}

- (void)setAppearanceType:(STAppearanceType)appearanceType {
    NSLog(@"test");
    [super setAppearanceType:appearanceType];
    [self displayFrameWithName:@"block"];
}

- (STGameObjectBodyType)bodyType {
    return STGameObjectBodyTypeStatic;
}

- (void)collisionWithGameObject:(STGameObject *)gameObject
                           edge:(STRectEdge)edge {
    if (edge == STRectEdgeMinY && [[gameObject class] isSubclassOfClass:[STPlayer class]]) {
        // Play a sound
        [[STSoundManager sharedInstance] playEffect:kSoundBreakBlock];
        
        [self setDead:YES];
    }
}

@end
