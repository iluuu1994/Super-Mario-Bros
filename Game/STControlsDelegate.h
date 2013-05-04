//
//  STControlsDelegate.h
//  Game
//
//  Created by Lukas Seglias on 04.05.13.
//  Copyright (c) 2013 Ilija Tovilo. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol STControlsDelegate <NSObject>

#pragma mark -
#pragma mark Buttons
- (IBAction)a:(id)sender;

- (IBAction)b:(id)sender;

- (IBAction)joystick:(id)sender delta:(ccTime)delta;

- (IBAction)pause:(id)sender;

@end
