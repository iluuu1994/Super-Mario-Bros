//
//  STInformationLayer.m
//  Game
//
//  Created by Lukas Seglias on 10.05.13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "STInformationLayer.h"
#import "STLayoutConstants.h"

@implementation STInformationLayer
{}

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

#pragma mark -
#pragma mark Update Layer

- (void)updateInformation {
    // Remove all old labels
    [self removeAllChildren];
    
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    // Retrieve the Player Information
    NSString *score = [NSString stringWithFormat:@"Score\n%i", [self.player score]];
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
    
    // Time
    CCLabelTTF *timeLabel = [CCLabelTTF labelWithString:time fontName:kTextFontName fontSize:kTextFontSize];
    timeLabel.position = ccp(coinsLabel.position.x + coinsLabel.contentSize.width / 2
                              + timeLabel.contentSize.width / 2 + 2 * kPadding,
                              winSize.height - timeLabel.contentSize.height / 2 - kPadding);
    [timeLabel setColor:kTextColor];
    [self addChild:timeLabel];
}

#pragma mark -
#pragma mark Count down

/**
 * Called every second to decrease the current amount of seconds (count down).
 * @param dt - the time elapsed since the last call of this method. 
 */
-(void) timer: (ccTime) dt
{
    // Count down
    [self setTime:[self time] - roundf(dt)];
    
    // Update the displayed values
    [self updateInformation];
    
    // Send a message to the delegate if the time is over and stop counting down.
    if([self time] <= 0) {
        [[self delegate] timeElapsed:self];
        [self unschedule:@selector(timer:)];
    }
}

@end
