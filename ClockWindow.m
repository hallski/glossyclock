//
//  ClockWindow.m
//  GlossyClock
//
//  Created by Mikael Hallendal on 2009-10-10.
//  Copyright 2009 Mikael Hallendal. All rights reserved.
//

#import "ClockWindow.h"


@implementation ClockWindow

- (id)initWithContentRect:(NSRect)contentRect
                styleMask:(NSUInteger)aStyle
                  backing:(NSBackingStoreType)bufferingType
                    defer:(BOOL)flag
{
    self = [super initWithContentRect:contentRect
                            styleMask:NSBorderlessWindowMask
                              backing:bufferingType
                                defer:flag];
    if (self) {
        [self setOpaque:NO];
        [self setBackgroundColor:[NSColor clearColor]];
        [self setMovableByWindowBackground:YES];
        [self setLevel:NSPopUpMenuWindowLevel];
        [self setStyleMask:NSBorderlessWindowMask];
    }
    
    return self;
}

- (void)setIsVisible:(BOOL)flag
{
    [[self animator] setAlphaValue:flag ? 0.0f : 1.0f];
}

@end