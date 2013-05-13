//
//  STLakitu.m
//  Game
//
//  Created by Ilija Tovilo on 5/9/13.
//  Copyright (c) 2013 by Lukas Seglias & Ilija Tovilo. All rights reserved.
//

#import "STLakitu.h"
#import "STSoundManager.h"
#import "STPlayer.h"
#import "STSpiny.h"

#define kScore 250
#define kKillBounce 100
#define kThrowingInterval 10

#define kCirclingVelocityMax 100
#define kAcceleration 2
#define kMaxVelocityX 100

@implementation STLakitu

- (id)init
{
    if (self = [super initWithPlistFile:@"Lakitu.plist"]) {
        [self runAnimationWithName:@"fly" endless:NO];
        [self schedule:@selector(throwSpiny) interval:kThrowingInterval];
    }
    return self;
}

- (BOOL)needsUpdate {
    return YES;
}

- (void)update:(ccTime)delta {
    [super update:delta];
    
    if (([self.delegate positionOfPlayer].x < self.position.x && self.velocity.x > -kMaxVelocityX) ||
        self.velocity.x > kMaxVelocityX
        ) {
        self.velocity = ccp(self.velocity.x - (kAcceleration * delta * 100), self.velocity.y);
    } else {
        self.velocity = ccp(self.velocity.x + (kAcceleration * delta * 100), self.velocity.y);
    }
}

- (STGameObjectBodyType)bodyType {
    return STGameObjectBodyTypeSemiDynamic;
}

- (void)collisionWithGameObject:(STGameObject *)gameObject
                           edge:(STRectEdge)edge {

    if ([[gameObject class] isSubclassOfClass:[STPlayer class]]) {
        if (edge == STRectEdgeMaxY){
            [(STPlayer *)gameObject setVelocity:ccpAdd([(STPlayer *)gameObject velocity], ccp(0, kKillBounce))];
            [(STPlayer *)gameObject setScore:[(STPlayer *)gameObject score] + kScore];
            [self die];
        } else {
            [(STPlayer *)gameObject die];
        }
    }
}

- (void)throwSpiny {
    STSpiny *spiny = [[STSpiny alloc] init];
    spiny.velocity = ccp(50, 100);
    
    [self.delegate addGameObjectToMap:spiny toPosition:ccp(self.position.x, self.position.y + self.boundingBox.size.height + (spiny.boundingBox.size.height / 2))];
}

- (void)die {
    [super die];
    
    // Play stomp
    [[STSoundManager sharedInstance] playEffect:kSoundStomp];
}

@end
