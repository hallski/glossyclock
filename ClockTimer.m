//
//  ClockTimer.m
//  GlossyClock
//
//  Created by Mikael Hallendal on 2009-10-10.
//  Copyright 2009 Mikael Hallendal. All rights reserved.
//

#import "ClockTimer.h"


@implementation ClockTimer

@synthesize outputString;

- (void) updateOutputString {
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"HH:mm:ss"];
    
    [self setOutputString:[format stringFromDate:[NSDate date]]];
    
}

- (id) init
{
    self = [super init];
    if (self != nil) {
        [self updateOutputString];
        
        [NSTimer scheduledTimerWithTimeInterval:1.0f 
                                         target:self 
                                       selector:@selector(timerFireMethod:)
                                       userInfo:nil repeats:YES];
        // Start timer to update outputString
    }
    return self;
}

- (void)timerFireMethod:(NSTimer *)theTimer
{
    [self updateOutputString];

}

@end
