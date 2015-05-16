//
// Created by Mikael Hallendal on 16/05/15.
// Copyright (c) 2015 Mikael Hallendal. All rights reserved.
//

import Foundation
import Cocoa

class ClockView: NSView {

    var clockFace: CATextLayer?

    var time: NSDate = NSDate() {
        didSet {
            clockFace?.string = formatter.stringFromDate(time)
        }
    }

    lazy var formatter: NSDateFormatter = {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter
    }()

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        self.layer = setupLayers()
    }

    override func awakeFromNib() {
        self.wantsLayer = true
    }

    func setupLayers() -> CALayer {
        let backgroundLayer = setupBackgroundLayer()

        clockFace = setupClockFaceLayer()

        backgroundLayer.addSublayer(clockFace)
        backgroundLayer.addSublayer(setupBorderLayer())
        backgroundLayer.addSublayer(setupGlossLayer())

        return backgroundLayer
    }

    func setupBackgroundLayer() -> CALayer {
        let gradientLayer = CAGradientLayer()

        let gradientColor1 = CGColorCreateGenericRGB(13.0/255.0, 116.0/255.0, 1.0, 1.0)
        let gradientColor2 = CGColorCreateGenericRGB(0.0, 53/255.0, 126.0/255.0, 1.0)

        gradientLayer.colors = [gradientColor1, gradientColor2]
        gradientLayer.cornerRadius = 12.0
        gradientLayer.layoutManager = CAConstraintLayoutManager()

        return gradientLayer
    }

    func setupClockFaceLayer() -> CATextLayer {
        let clockFace = CATextLayer()

        clockFace.font = "Menlo"
        clockFace.fontSize = 60.0
        clockFace.shadowOpacity = 0.9

        clockFace.addConstraint(constraint(.MidX, "superlayer", .MidX))
        clockFace.addConstraint(constraint(.MidY, "superlayer", .MidY))

        clockFace.string = formatter.stringFromDate(time)

        return clockFace
    }

    func setupBorderLayer() -> CALayer {
        let border = CALayer()

        let borderRect = CGRectInset(frame, 8.0, 8.0)

        border.cornerRadius = 12.0
        border.borderColor = NSColor.whiteColor().CGColor
        border.borderWidth = 2.0

        border.frame = borderRect

        return border
    }

    func setupGlossLayer() -> CALayer {
        let gloss = CALayer()

        let image = NSImage(named: "Gloss")
        let imageSource = CGImageSourceCreateWithData(image?.TIFFRepresentation, nil)
        let glossyImage = CGImageSourceCreateImageAtIndex(imageSource, 0, nil)

        gloss.contents = glossyImage
        gloss.opacity = 0.8
        gloss.cornerRadius = 12.0
        gloss.masksToBounds = true

        gloss.frame = frame

        return gloss
    }
}

func constraint(attribute: CAConstraintAttribute,
    relativeTo: String,
    attribute2: CAConstraintAttribute) -> CAConstraint {
        return CAConstraint.constraintWithAttribute(attribute, relativeTo: "superlayer", attribute: attribute2) as! CAConstraint
}
