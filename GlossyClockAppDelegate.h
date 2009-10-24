//
//  GlossyClockAppDelegate.h
//  GlossyClock
//
//  Created by Mikael Hallendal on 2009-10-10.
//  Copyright 2009 Mikael Hallendal. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class ClockWindow;

@interface GlossyClockAppDelegate : NSObject <NSApplicationDelegate> {
    ClockWindow *window;
}

@property (assign) IBOutlet ClockWindow *window;

@end
