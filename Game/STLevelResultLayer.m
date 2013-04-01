//
//  STLevelResultLayer.m
//  Game
//
//  Created by Lukas Seglias on 01.04.13.
//  Copyright 2013 Ilija Tovilo. All rights reserved.
//

#import "STLevelResultLayer.h"


@implementation STLevelResultLayer

#pragma mark -
#pragma mark Initialise

-(id)initWithWorldId:(unsigned int)worldId
             levelId:(unsigned int)levelId
                time:(NSDate *)time
               score:(int)score
             success:(BOOL)success {
    
    self = [super init];
    if (self) {
        [self setUpWithWorldId:worldId levelId:levelId time:time score:score success:success];
    }
    return self;
}

+(id)layerWithWorldId:(unsigned int)worldId
              levelId:(unsigned int)levelId
                 time:(NSDate *)time
                score:(int)score
              success:(BOOL)success {
    return [[self alloc] initWithWorldId:worldId levelId:levelId time:time score:score success:success];
}

- (void)setUpWithWorldId:(unsigned int)worldId
                 levelId:(unsigned int)levelId
                    time:(NSDate *)time
                   score:(int)score
                 success:(BOOL)success {

    
}

@end
