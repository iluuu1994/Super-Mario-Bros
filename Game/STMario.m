//
//  STMario.m
//  Game
//
//  Created by Ilija Tovilo on 4/9/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "STMario.h"

@interface STMario () {
    UIEvent *_cachedEvent;
}
@end

@implementation STMario

#pragma mark -
#pragma mark Initialise
- (id)init
{
    if (self = [super initWithPlistFile:@"Mario.plist"]) {
        [self runAction:[CCAnimate actionWithAnimation:self.animations[@"stand"]]];
    }
    return self;
}

- (BOOL)needsTouchNotifications {
    return YES;
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    _cachedEvent = event;
    
    [self runAction:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:self.animations[@"walk"]]]];
    [self jump];
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    _cachedEvent = nil;
    
    [self stopAllActions];
    [self runAction:[CCAnimate actionWithAnimation:self.animations[@"stand"]]];
}

- (BOOL)needsUpdate {
    return YES;
}

- (void)collisionWithGameObject:(STGameObject *)gameObject {

}

- (void)jump {
    self.velocity = ccpAdd(self.velocity, ccp(0, 20));
}

- (void)update:(ccTime)delta {
    if (_cachedEvent) {
        self.position = ccp(self.position.x + (100 * delta), self.position.y);
    }
}


@end
