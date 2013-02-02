//
//  Man.m
//  Game
//
//  Created by Ilija Tovilo on 2/3/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "Frei.h"

@implementation Frei

- (id)init
{
    self = [super initWithDefaultSpriteFrameName:@"Frame1"
                                       plistFile:@"Frei.plist"
                     spriteFrameNamingConvention:@"Frame%d"];
    if (self) {
        
    }
    return self;
}

@end
