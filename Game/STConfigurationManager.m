//
//  STConfigurationManager.m
//  Game
//
//  Created by Lukas Seglias on 28.04.13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "STConfigurationManager.h"

@implementation STConfigurationManager
{}

static STConfigurationManager *sharedInstance = nil;

+(id)sharedInstance{
    if(sharedInstance == nil) {
        sharedInstance = [[STConfigurationManager alloc] init];
    }
    return sharedInstance;
}

- (id)init {
    if ( (self = [super init]) ) {
        musicOn = true;
        toneOn = true;
    }
    return self;
}

@synthesize musicOn;
@synthesize toneOn;

@end
