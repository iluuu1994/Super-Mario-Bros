//
//  STLakitu.m
//  Game
//
//  Created by Ilija Tovilo on 5/9/13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "STLakitu.h"

@implementation STLakitu

- (id)init
{
    if (self = [super initWithPlistFile:@"Lakitu.plist"]) {
        [self runAnimationWithName:@"fly" endless:NO];
    }
    return self;
}

- (STGameObjectBodyType)bodyType {
    return STGameObjectBodyTypeSemiDynamic;
}

@end
