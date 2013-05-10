//
//  STLevelResultLayer.m
//  Game
//
//  Created by Lukas Seglias on 01.04.13.
//  Copyright 2013 Ilija Tovilo. All rights reserved.
//

#import "STLevelResultLayer.h"
#import "CCDirector+Transitions.h"
#import "CCControlExtension.h"

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

- (void)setUpWithWorldID:(unsigned short)worldID
                 levelID:(unsigned short)levelID
                    time:(NSDate *)time
                   score:(int)score
                 success:(BOOL)success {
    self.worldID = worldID;
    self.levelID = levelID;

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
    
    // Scene Title
    CCLabelTTF *titleLabel = [CCLabelTTF labelWithString:title fontName:kTitleFontName fontSize:kTitleFontSize];
    [titleLabel setColor:kTitleTextColor];
    titleLabel.position = ccp(winSize.width / 2, winSize.height - titleLabel.contentSize.height - kPadding);
    [self addChild:titleLabel];

    // Menu
    CCMenu *menu = [CCMenu menuWithItems:
                    [CCMenuItemFont itemWithString:[NSString stringWithFormat:@"Score: %i", score]],
                    [CCMenuItemFont itemWithString:[NSString stringWithFormat:@"Time: %ld:%ld", (long)components.minute, (long)components.second]],
                    nil];
    
    // Level Overview Button
    CCLabelTTF *levelsLabel = [CCLabelTTF labelWithString:@"Levels" fontName:kButtonFontName fontSize:kButtonFontSize];
    [levelsLabel setColor:kButtonTextColor];
    CCControlButton *levels = [CCControlButton buttonWithLabel:levelsLabel
                                              backgroundSprite:[CCScale9Sprite spriteWithFile:kButtonImageName]];
    [levels addTarget:self action:@selector(levelOverview:) forControlEvents:CCControlEventTouchUpInside];
    [self addChild:levels];

    // Retry Button
    CCLabelTTF *retryLabel = [CCLabelTTF labelWithString:@"Retry" fontName:kButtonFontName fontSize:kButtonFontSize];
    [retryLabel setColor:kButtonTextColor];
    CCControlButton *retry = [CCControlButton buttonWithLabel:retryLabel
                                              backgroundSprite:[CCScale9Sprite spriteWithFile:kButtonImageName]];
    [retry addTarget:self action:@selector(retryLevel:) forControlEvents:CCControlEventTouchUpInside];
    [self addChild:retry];
    
    if(success) {
        // Level Overview Button
        levels.position = ccp(winSize.width / 2, levels.contentSize.height / 2 + kPadding);
        
        // Retry Button
        retry.position = ccp(winSize.width / 2 - levels.contentSize.width / 2 - retry.contentSize.width / 2 - kPadding,
                             retry.contentSize.height / 2 + kPadding);
        
        // Next Level Button
        CCLabelTTF *nextLabel = [CCLabelTTF labelWithString:@"Next" fontName:kButtonFontName fontSize:kButtonFontSize];
        [nextLabel setColor:kButtonTextColor];
        CCControlButton *next = [CCControlButton buttonWithLabel:nextLabel
                                                 backgroundSprite:[CCScale9Sprite spriteWithFile:kButtonImageName]];
        next.position = ccp(winSize.width / 2 + levels.contentSize.width / 2 + next.contentSize.width / 2 + kPadding,
                            next.contentSize.height / 2 + kPadding);
        [next addTarget:self action:@selector(nextLevel:) forControlEvents:CCControlEventTouchUpInside];
        [self addChild:next];
    } else {
        // Retry Button
        retry.position = ccp(winSize.width / 2 - retry.contentSize.width / 2 - kPadding,
                             retry.contentSize.height / 2 + kPadding);
        // Level Overview Button
        levels.position = ccp(winSize.width / 2 + levels.contentSize.width / 2 + kPadding,
                              levels.contentSize.height / 2 + kPadding);
    }
    
    [menu alignItemsVerticallyWithPadding:20];
    [self addChild:menu];
}

#pragma mark -
#pragma mark Retry Level
- (IBAction)retryLevel:(id)sender {    
    STScene *scene = [[STLevelLayer layerWithWorldID:self.worldID levelID:self.levelID] scene];
    [[CCDirector sharedDirector] replaceScene: scene
                          withTransitionClass:[CCTransitionFade class]
                                     duration:0.5];
}

#pragma mark -
#pragma mark Level Overview
- (IBAction)levelOverview:(id)sender {
    [[CCDirector sharedDirector] replaceScene: [[STChooseLevelLayer layerWithWorldID:self.worldID] scene]
                          withTransitionClass:[CCTransitionFade class]
                                     duration:0.5];
}

#pragma mark -
#pragma mark Next Level
- (IBAction)nextLevel:(id)sender {
    // TODO: next level
    NSDictionary *nextLevel = [[STWorldInfoReader sharedInstance]
                               nextLevelFromWorldID:self.worldID levelID:self.levelID];
    
    if(nextLevel) {
        unsigned short levelID = [[nextLevel valueForKey:kLevelIDKey] shortValue];
        STScene *scene = [[STLevelLayer layerWithWorldID:self.worldID levelID:levelID] scene];
        [[CCDirector sharedDirector] replaceScene: scene
                              withTransitionClass:[CCTransitionFade class]
                                         duration:0.5];
    } else {
        [[CCDirector sharedDirector] replaceScene: [STChooseWorldLayer scene]
                              withTransitionClass:[CCTransitionFade class]
                                         duration:0.5];
    }
}

@end
