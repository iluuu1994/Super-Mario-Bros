//
//  STFireBall.m
//  Game
//
//  Created by Ilija Tovilo on 5/12/13.
//  Copyright (c) 2013 by Lukas Seglias & Ilija Tovilo. All rights reserved.
//

#import "STFireBall.h"
#import "STNPC.h"
#import "STSoundManager.h"


#pragma mark -
#pragma mark STFireBall Implementation

@implementation STFireBall



#pragma mark -
#pragma mark Initialization

- (id)init
{
    self = [super initWithPlistFile:@"FireBall.plist"];
    if (self) {
        [self runAnimationWithName:@"spin" endless:YES];
    }
    return self;
}

- (void)onEnter {
    [super onEnter];
    [[STSoundManager sharedInstance] playEffect:kSoundFireball];
}




#pragma mark -
#pragma mark Properties

- (STGameObjectBodyType)bodyType {
    return STGameObjectBodyTypeDynamic;
}



#pragma mark -
#pragma mark Methods

- (void)collisionWithGameObject:(STGameObject *)gameObject edge:(STRectEdge)edge {
    // Bounce off the ground
    if (edge == STRectEdgeMinY) {
        self.velocity = ccpAdd(self.velocity, ccp(0, 100));
    }
    
    // Only kills creatures except for the player.
    if([[gameObject class] isSubclassOfClass:[STNPC class]]) {
        [gameObject die];
        [self die];
    }
}
@end
