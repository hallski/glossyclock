//
//  ClockView.m
//  GlossyClock
//
//  Created by Mikael Hallendal on 2009-10-10.
//  Copyright 2009 Mikael Hallendal. All rights reserved.
//

#import "ClockView.h"
#import <Quartz/Quartz.h>
#import "ClockTimer.h"
#import <QuartzCore/CoreAnimation.h>

@implementation ClockView

- (CALayer *)setupBackgroundLayer 
{
    backgroundLayer = [CAGradientLayer layer];
    
    CGColorRef gradientColor1 = CGColorCreateGenericRGB(13.0f / 255.0, 116.0f / 255.0, 1.0, 1.0f);
    CGColorRef gradientColor2 = CGColorCreateGenericRGB(0.0f, 53.0f/255.0f, 126.0f/255.0f, 1.0f);
    
    NSArray *colors = @[(__bridge id)gradientColor1,
                       (__bridge id)gradientColor2];
    
    CFRelease(gradientColor1);
    CFRelease(gradientColor2);
    
    [(CAGradientLayer *)backgroundLayer setColors:colors];
    [backgroundLayer setCornerRadius:12.0f];
    
    CAConstraintLayoutManager *layout = [CAConstraintLayoutManager layoutManager];
    [backgroundLayer setLayoutManager:layout];
    
    return backgroundLayer;
}

- (CALayer *)setupClockFaceLayer {
    CATextLayer *clockFaceLayer = [CATextLayer layer];
    [clockFaceLayer bind:@"string" toObject:clockTimer withKeyPath:@"outputString" options:nil];
    [clockFaceLayer setFont:@"Menlo"];
    [clockFaceLayer setFontSize:60.0f];
    [clockFaceLayer setShadowOpacity:.9f];
    
    // Constrain the text layer in the middle
    CAConstraint *constraint = [CAConstraint constraintWithAttribute:kCAConstraintMidX
                                                          relativeTo:@"superlayer"
                                                           attribute:kCAConstraintMidX];    
    [clockFaceLayer addConstraint:constraint];
    
    constraint = [CAConstraint constraintWithAttribute:kCAConstraintMidY
                                            relativeTo:@"superlayer"
                                             attribute:kCAConstraintMidY];
    [clockFaceLayer addConstraint:constraint];
    
    return clockFaceLayer;
}

- (CALayer *)setupBorderLayer
{
    CALayer *borderLayer = [CALayer layer];
    CGRect borderRect = CGRectInset([self frame], 8.0f, 8.0f);
    [borderLayer setCornerRadius:12.0f];
    [borderLayer setBorderColor:CGColorGetConstantColor(kCGColorWhite)];
    [borderLayer setBorderWidth:2.0f];
    [borderLayer setFrame:borderRect];
    
    return borderLayer;    
}

- (CALayer *)setupGlossLayer
{
    CALayer *glossLayer = [CALayer layer];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"clock-gloss" ofType:@"png"];
    NSURL *fileURL = [NSURL fileURLWithPath:filePath];
    
    CGImageSourceRef glossySource = CGImageSourceCreateWithURL((__bridge CFURLRef)fileURL, NULL);
    CGImageRef glossyImage = CGImageSourceCreateImageAtIndex(glossySource, 0, NULL);
    CFRelease(glossySource);
    [glossLayer setContents:(__bridge id)glossyImage];
    CFRelease(glossyImage);
    
    [glossLayer setOpacity:0.8f];
    [glossLayer setCornerRadius:12.0f];
    [glossLayer setMasksToBounds:YES];
    [glossLayer setFrame:[self frame]];

    return glossLayer;
}

- (CALayer *)setupLayers
{
    backgroundLayer = [self setupBackgroundLayer];
    
    [backgroundLayer addSublayer:[self setupClockFaceLayer]];
    [backgroundLayer addSublayer:[self setupBorderLayer]];
    [backgroundLayer addSublayer:[self setupGlossLayer]];

    return backgroundLayer;
}

- (id)initWithFrame:(NSRect)frame 
{
    self = [super initWithFrame:frame];
    if (self) {
        clockTimer = [[ClockTimer alloc] init];

        [self setLayer:[self setupLayers]];
    }
    return self;
}

- (void)awakeFromNib
{
    [self setWantsLayer:YES];
}

@end
