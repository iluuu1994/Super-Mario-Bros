//
//  STInformationLayer.h
//  Game
//
//  Created by Lukas Seglias on 10.05.13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import "STLayer.h"
#import "STPlayer.h"
#import "STLayoutConstants.h"

@protocol STInformationDelegate <NSObject>

#pragma mark -
#pragma mark Time
- (IBAction)remainingTime:(id)sender;

@end

@interface STInformationLayer : STLayer
{}

#pragma mark -
#pragma mark Properties
@property (strong, readonly) STPlayer *player;
@property unsigned short time;
@property (unsafe_unretained) id <STInformationDelegate> delegate;

#pragma mark -
#pragma mark Initialise
-(id)initWithDelegate:(id <STInformationDelegate>)delegate
               player:(STPlayer *)player
                 time:(unsigned short)time;

+(id)layerWithDelegate:(id <STInformationDelegate>)delegate
                player:(STPlayer *)player
                  time:(unsigned short)time;

- (void)setUpWithDelegate:(id <STInformationDelegate>)delegate
                   player:(STPlayer *)player
                     time:(unsigned short)time;

- (void)updateInformation;

@end
