//
//  ClockView.h
//  GlossyClock
//
//  Created by Mikael Hallendal on 2009-10-10.
//  Copyright 2009 Mikael Hallendal. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class ClockTimer;

@interface ClockView : NSView {
    ClockTimer *clockTimer;
    CALayer *backgroundLayer;
}

@end
