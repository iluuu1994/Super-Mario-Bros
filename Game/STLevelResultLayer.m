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

    NSString *title = @"Game Over!";
    if(success) {
        title = @"Congratulations!";
    }
    
    time = [NSDate dateWithTimeIntervalSinceNow:-1000];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [calendar components:NSMinuteCalendarUnit | NSSecondCalendarUnit
                                               fromDate:time
                                                 toDate:[NSDate date]
                                                options:0];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"hh:mm"];

    CCMenu *menu = [CCMenu menuWithItems:
                    [CCMenuItemFont itemWithString:title],
                    [CCMenuItemFont itemWithString:[NSString stringWithFormat:@"Score: %i", score]],
                    [CCMenuItemFont itemWithString:[NSString stringWithFormat:@"Time: %ld:%ld", (long)components.minute, (long)components.second]],
                    nil];
    
    if(success) {
        // TODO: Retry Button
        // TODO: Levels Button
        // TODO: Next Level Button
    } else {
        // TODO: Retry Button
        // TODO: Levels Button
    }
    
    [menu alignItemsVerticallyWithPadding:20];
    [self addChild:menu];
}

@end
