//
//  STInformationLayer.m
//  Game
//
//  Created by Lukas Seglias on 10.05.13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "STInformationLayer.h"

@implementation STInformationLayer

#pragma mark -
#pragma mark Initialise
-(id)initWithDelegate:(id <STInformationDelegate>)delegate
               player:(STPlayer *)player
                 time:(unsigned short)time {
    self = [super init];
    if (self) {
        [self setDelegate:delegate];
        [self setTime:time];
        [self setUpWithDelegate:delegate player:player time:time];
        [self schedule: @selector(timer:) interval:0.5];
    }
    return self;
}

+(id)layerWithDelegate:(id <STInformationDelegate>)delegate
                player:(STPlayer *)player
                  time:(unsigned short)time {
    return [[self alloc] initWithDelegate:delegate player:player time:time];
}

- (void)setUpWithDelegate:(id <STInformationDelegate>)delegate
                   player:(STPlayer *)player
                     time:(unsigned short)time {
    [super setUp];
    [self updateInformation];
}

- (void)updateInformation {
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    // Retrieve Player Information
    NSString *score = [NSString stringWithFormat:@"Score\n%i", [self.player score]];
    NSString *lifes = [NSString stringWithFormat:@"Lifes\n%i", [self.player lifes]];
    NSString *coins = [NSString stringWithFormat:@"Coins\n%i", [self.player coins]];
    
    // Display
    CCLabelTTF *scoreLabel = [CCLabelTTF labelWithString:score fontName:kTextFontName fontSize:kTextFontSize];
    scoreLabel.position = ccp(scoreLabel.contentSize.width / 2 + kPadding,
                              scoreLabel.contentSize.height / 2 + kPadding);
    [scoreLabel setColor:kTextColor];
    [self addChild:scoreLabel];
    
    CCLabelTTF *coinsLabel = [CCLabelTTF labelWithString:coins fontName:kTextFontName fontSize:kTextFontSize];
    coinsLabel.position = ccp(winSize.width / 2, coinsLabel.contentSize.height / 2 + kPadding);
    [coinsLabel setColor:kTextColor];
    [self addChild:coinsLabel];
    
    CCLabelTTF *lifesLabel = [CCLabelTTF labelWithString:lifes fontName:kTextFontName fontSize:kTextFontSize];
    lifesLabel.position = ccp(winSize.width - lifesLabel.contentSize.width / 2 - kPadding,
                              lifesLabel.contentSize.height / 2 + kPadding);
    [lifesLabel setColor:kTextColor];
    [self addChild:lifesLabel];
}

-(void) timer: (ccTime) dt
{
    [self setTime:[self time] - dt];
}

@end
