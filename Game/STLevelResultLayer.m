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
                time:(int)time
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
                 time:(int)time
                score:(int)score
              success:(BOOL)success {
    return [[self alloc] initWithWorldID:worldID levelID:levelID time:time score:score success:success];
}

- (void)setUpWithWorldID:(unsigned short)worldID
                 levelID:(unsigned short)levelID
                    time:(int)time
                   score:(int)score
                 success:(BOOL)success {
    self.worldID = worldID;
    self.levelID = levelID;

    NSString *title = @"Game Over!";
    if(success) {
        title = @"Congratulations!";
    }
    
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    int m = (time / 60) % 60;
    int s = time % 60;
    
    NSString *formattedTime = [NSString stringWithFormat:@"%02u:%02u", m, s];
    
    // Scene Title
    CCLabelTTF *titleLabel = [CCLabelTTF labelWithString:title fontName:kTitleFontName fontSize:kTitleFontSize];
    [titleLabel setColor:kTitleTextColor];
    titleLabel.position = ccp(winSize.width / 2, winSize.height - titleLabel.contentSize.height - kPadding);
    [self addChild:titleLabel];

    // Menu
    CCMenu *menu = [CCMenu menuWithItems:
                    [CCMenuItemFont itemWithString:[NSString stringWithFormat:@"Score: %i", score]],
                    [CCMenuItemFont itemWithString:[NSString stringWithFormat:@"Time: %@", formattedTime]],
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
