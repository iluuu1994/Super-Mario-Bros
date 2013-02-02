//
//  Candle.m
//  Game
//
//  Created by Lukas Seglias on 02.02.13.
//  Copyright 2013 Ilija Tovilo. All rights reserved.
//

#import "Candle.h"


@implementation Candle

- (id)init
{
    self = [super initWithDefaultSpriteFrameName:@"Candle_1.png"
                                       plistFile:@"Candle.plist"
                     spriteFrameNamingConvention:@"Candle_%d.png"];
    if (self) {
        
    }
    return self;
}

@end
