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
        _player = player;
        [self setUpWithDelegate:delegate player:player time:time];
        [self schedule: @selector(timer:) interval:1];
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
    [self removeAllChildren];
    
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    // Retrieve Player Information
    NSString *score = [NSString stringWithFormat:@"Score\n%i", [self.player score]];
    NSString *lifes = [NSString stringWithFormat:@"Lifes\n%i", [self.player lifes]];
    NSString *coins = [NSString stringWithFormat:@"Coins\n%i", [self.player coins]];
    NSString *time = [NSString stringWithFormat:@"Time\n%i", [self time]];
        
    // Coins
    CCLabelTTF *coinsLabel = [CCLabelTTF labelWithString:coins fontName:kTextFontName fontSize:kTextFontSize];
    coinsLabel.position = ccp(winSize.width / 2, winSize.height - coinsLabel.contentSize.height / 2 - kPadding);
    [coinsLabel setColor:kTextColor];
    [self addChild:coinsLabel];
    
    // Score
    CCLabelTTF *scoreLabel = [CCLabelTTF labelWithString:score fontName:kTextFontName fontSize:kTextFontSize];
    scoreLabel.position = ccp(coinsLabel.position.x - coinsLabel.contentSize.width / 2
                              - scoreLabel.contentSize.width / 2 - 2 * kPadding,
                              winSize.height - scoreLabel.contentSize.height / 2 - kPadding);
    [scoreLabel setColor:kTextColor];
    [self addChild:scoreLabel];
    
    // Lifes
    CCLabelTTF *lifesLabel = [CCLabelTTF labelWithString:lifes fontName:kTextFontName fontSize:kTextFontSize];
    lifesLabel.position = ccp(coinsLabel.position.x + coinsLabel.contentSize.width / 2
                              + lifesLabel.contentSize.width / 2 + 2 * kPadding,
                              winSize.height - lifesLabel.contentSize.height / 2 - kPadding);
    [lifesLabel setColor:kTextColor];
    [self addChild:lifesLabel];
    
    // Time
    CCLabelTTF *timeLabel = [CCLabelTTF labelWithString:time fontName:kTextFontName fontSize:kTextFontSize];
    timeLabel.position = ccp(lifesLabel.position.x + lifesLabel.contentSize.width / 2
                              + timeLabel.contentSize.width / 2 + 2 * kPadding,
                              winSize.height - timeLabel.contentSize.height / 2 - kPadding);
    [timeLabel setColor:kTextColor];
    [self addChild:timeLabel];
}

-(void) timer: (ccTime) dt
{
    [self setTime:[self time] - 1];
    
    [self updateInformation];
    
    // Send a message to the delegate if the time is over
    if([self time] <= 0) {
        [[self delegate] timeElapsed:self];
    }
}

@end
