//
//  Candle.m
//  Game
//
//  Created by Lukas Seglias on 02.02.13.
//  Copyright 2013 Ilija Tovilo. All rights reserved.
//

#import "Candle.h"
#import "SKAnimationConfiguration.h"

@implementation Candle

- (id)init
{
    self = [super initWithDefaultSpriteFrameName:@"Candle_1.png" plistFile:@"Candle.plist" animationConfigurations:@[ [SKAnimationConfiguration configurationWithName:@"Burn" frameNamePattern:@"Candle_%d.png" delay:0.1] ]];
    if (self) {
        [self runAction:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:self.animations[@"Burn"]]]];
    }
    return self;
}

@end
