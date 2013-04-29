//
//  STLevelResultLayer.m
//  Game
//
//  Created by Lukas Seglias on 01.04.13.
//  Copyright 2013 Ilija Tovilo. All rights reserved.
//

#import "STLevelResultLayer.h"
#import "LayerConstants.h"

@implementation STLevelResultLayer
{}

#pragma mark -
#pragma mark Initialise
-(id)initWithWorldID:(unsigned short)worldID
             levelID:(unsigned short)levelID
                time:(NSDate *)time
               score:(int)score
             success:(BOOL)success {
    
    self = [super init];
    if (self) {
        [self setUpWithWorldID:worldID levelID:levelID time:time score:score success:success];
    }
    return self;
}

+(id)layerWithWorldID:(unsigned short)worldID
              levelID:(unsigned short)levelID
                 time:(NSDate *)time
                score:(int)score
              success:(BOOL)success {
    return [[self alloc] initWithWorldID:worldID levelID:levelID time:time score:score success:success];
}

+(id)sceneWithWorldID:(unsigned short)worldID
             levelID:(unsigned short)levelID
                time:(NSDate *)time
               score:(int)score
             success:(BOOL)success {
    
    STLevelResultLayer *layer = [STLevelResultLayer layerWithWorldID:worldID
                                                             levelID:levelID
                                                                time:time
                                                               score:score
                                                             success:success];
    STScene *scene = [STScene node];
    [scene addChild:layer];
    return scene;
}

- (void)setUpWithWorldID:(unsigned short)worldID
                 levelID:(unsigned short)levelID
                    time:(NSDate *)time
                   score:(int)score
                 success:(BOOL)success {

    NSString *title = @"Game Over!";
    if(success) {
        title = @"Congratulations!";
    }
    
    time = [NSDate dateWithTimeIntervalSinceNow:-1000];
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [calendar components:NSMinuteCalendarUnit | NSSecondCalendarUnit
                                               fromDate:time
                                                 toDate:[NSDate date]
                                                options:0];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"hh:mm"];

    // Menu
    CCMenu *menu = [CCMenu menuWithItems:
                    [CCMenuItemFont itemWithString:title],
                    [CCMenuItemFont itemWithString:[NSString stringWithFormat:@"Score: %i", score]],
                    [CCMenuItemFont itemWithString:[NSString stringWithFormat:@"Time: %ld:%ld", (long)components.minute, (long)components.second]],
                    nil];
    
    // Level Overview Button
    CCControlButton *levelsButton = [CCControlButton buttonWithTitle:@"Levels" fontName:@"Helvetica" fontSize:30];
    [levelsButton setAdjustBackgroundImage:NO];
    [levelsButton addTarget:self action:@selector(levelOverview:) forControlEvents:CCControlEventTouchUpInside];
    [self addChild:levelsButton];
    
    // Retry Button
    CCControlButton *retryButton = [CCControlButton buttonWithTitle:@"Retry" fontName:@"Helvetica" fontSize:30];
    [retryButton setAdjustBackgroundImage:NO];
    [retryButton addTarget:self action:@selector(retryLevel:) forControlEvents:CCControlEventTouchUpInside];
    [self addChild:retryButton];
    
    if(success) {
        // Level Overview Button
        levelsButton.position = ccp(winSize.width / 2, levelsButton.contentSize.height / 2 + kScreenPadding);
        
        // Retry Button
        retryButton.position = ccp(winSize.width / 2 - levelsButton.contentSize.width - kButtonPadding,
                                   retryButton.contentSize.height / 2 + kScreenPadding);
        
        // Next Level Button
        CCControlButton *nextButton = [CCControlButton buttonWithTitle:@"Next" fontName:@"Helvetica" fontSize:30];
        [nextButton setAdjustBackgroundImage:NO];
        [nextButton addTarget:self action:@selector(nextLevel:) forControlEvents:CCControlEventTouchUpInside];
        nextButton.position = ccp(winSize.width / 2 + levelsButton.contentSize.width,
                                  nextButton.contentSize.height / 2 + kScreenPadding);
        [self addChild:nextButton];
    } else {
        // Retry Button
        retryButton.position = ccp(winSize.width / 2 - retryButton.contentSize.width / 2 - kButtonPadding,
                                   retryButton.contentSize.height / 2 + kScreenPadding);
        // Level Overview Button
        levelsButton.position = ccp(winSize.width / 2 + levelsButton.contentSize.width / 2 - kButtonPadding,
                                    levelsButton.contentSize.height / 2 + kScreenPadding);
    }
    
    [menu alignItemsVerticallyWithPadding:20];
    [self addChild:menu];
}

#pragma mark -
#pragma mark Retry Level
- (IBAction)retryLevel:(id)sender {
    
}

#pragma mark -
#pragma mark Level Overview
- (IBAction)levelOverview:(id)sender {
    
}

#pragma mark -
#pragma mark Next Level
- (IBAction)nextLevel:(id)sender {
    
}

@end
