//
//  DMHeadingDialView.swift
//  XBridge10
//
//  Created by Christopher Alford on 20/01/2017.
//  Copyright © 2017 marine.digital. All rights reserved.
//

import AppKit
import Foundation

class DMHeadingDialView: NSView {
    
    var currentHeading: CGFloat = 0.0
    var headingText = "0.0"
    var headingMode = "TRUE"

    private struct Cache {
        static let color: NSColor = NSColor(red: 1, green: 0.873, blue: 0, alpha: 1)
        static let color2: NSColor = NSColor(red: 0.589, green: 0.589, blue: 0.589, alpha: 1)
        static let color3: NSColor = NSColor(red: 1, green: 0.622, blue: 0, alpha: 1)
        static let color4: NSColor = NSColor(red: 0.698, green: 0.824, blue: 0.734, alpha: 1)
        static let color5: NSColor = NSColor(red: 0.341, green: 0.978, blue: 0, alpha: 1)
        static let color6: NSColor = NSColor(red: 0.333, green: 0.333, blue: 0.333, alpha: 1)
    }

    @objc dynamic public class var color: NSColor { return Cache.color }
    @objc dynamic public class var color2: NSColor { return Cache.color2 }
    @objc dynamic public class var color3: NSColor { return Cache.color3 }
    @objc dynamic public class var color4: NSColor { return Cache.color4 }
    @objc dynamic public class var color5: NSColor { return Cache.color5 }
    @objc dynamic public class var color6: NSColor { return Cache.color6 }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        let textRotation = currentHeading * -1

        //// General Declarations
        let context = NSGraphicsContext.current!.cgContext
        // This non-generic function dramatically improves compilation times of complex expressions.
        func fastFloor(_ x: CGFloat) -> CGFloat { return floor(x) }


        //// Subframes
        let labels: NSRect = NSRect(x: frame.minX + fastFloor((frame.width - 152) * 0.50000 + 0.5), y: frame.minY + fastFloor((frame.height - 115) * 0.65882 + 0.5), width: 152, height: 115)
        let textDisplay: NSRect = NSRect(x: frame.minX + fastFloor((frame.width - 83) * 0.50427 + 0.5), y: frame.minY + fastFloor((frame.height - 53) * 0.21769 + 0.5), width: 83, height: 53)


        //// DialBackground Drawing
        NSGraphicsContext.saveGraphicsState()
        context.translateBy(x: frame.minX + 0.50000 * frame.width, y: frame.minY + 0.50000 * frame.height)

        let dialBackgroundPath = NSBezierPath(ovalIn: NSRect(x: -95, y: -95, width: 190, height: 190))
        NSColor.white.setFill()
        dialBackgroundPath.fill()

        NSGraphicsContext.restoreGraphicsState()


        //// BowIndicator Drawing
        let bowIndicatorPath = NSBezierPath()
        bowIndicatorPath.move(to: NSPoint(x: frame.minX + 0.33750 * frame.width, y: frame.minY + 0.45414 * frame.height))
        bowIndicatorPath.curve(to: NSPoint(x: frame.minX + 0.37763 * frame.width, y: frame.minY + 0.68345 * frame.height), controlPoint1: NSPoint(x: frame.minX + 0.33750 * frame.width, y: frame.minY + 0.45414 * frame.height), controlPoint2: NSPoint(x: frame.minX + 0.33750 * frame.width, y: frame.minY + 0.57862 * frame.height))
        bowIndicatorPath.curve(to: NSPoint(x: frame.minX + 0.49802 * frame.width, y: frame.minY + 0.88655 * frame.height), controlPoint1: NSPoint(x: frame.minX + 0.41776 * frame.width, y: frame.minY + 0.78828 * frame.height), controlPoint2: NSPoint(x: frame.minX + 0.49802 * frame.width, y: frame.minY + 0.88655 * frame.height))
        bowIndicatorPath.move(to: NSPoint(x: frame.minX + 0.65853 * frame.width, y: frame.minY + 0.45414 * frame.height))
        bowIndicatorPath.curve(to: NSPoint(x: frame.minX + 0.61841 * frame.width, y: frame.minY + 0.68345 * frame.height), controlPoint1: NSPoint(x: frame.minX + 0.65853 * frame.width, y: frame.minY + 0.45414 * frame.height), controlPoint2: NSPoint(x: frame.minX + 0.65853 * frame.width, y: frame.minY + 0.57862 * frame.height))
        bowIndicatorPath.curve(to: NSPoint(x: frame.minX + 0.49802 * frame.width, y: frame.minY + 0.88655 * frame.height), controlPoint1: NSPoint(x: frame.minX + 0.57828 * frame.width, y: frame.minY + 0.78828 * frame.height), controlPoint2: NSPoint(x: frame.minX + 0.49802 * frame.width, y: frame.minY + 0.88655 * frame.height))
        NSColor.lightGray.setStroke()
        bowIndicatorPath.lineWidth = 2
        bowIndicatorPath.lineCapStyle = .round
        bowIndicatorPath.lineJoinStyle = .round
        bowIndicatorPath.stroke()


        //// Labels
        //// R120 Drawing
        let r120Rect = NSRect(x: labels.minX + 118, y: labels.minY, width: 28, height: 27)
        let r120TextContent = "120"
        let r120Style = NSMutableParagraphStyle()
        r120Style.alignment = .center
        let r120FontAttributes = [
            .font: NSFont(name: "AvenirNextCondensed-DemiBold", size: 15)!,
            .foregroundColor: NSColor.black,
            .paragraphStyle: r120Style,
        ] as [NSAttributedString.Key: Any]

        let r120TextHeight: CGFloat = r120TextContent.boundingRect(with: NSSize(width: r120Rect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: r120FontAttributes).height
        let r120TextRect: NSRect = NSRect(x: r120Rect.minX, y: r120Rect.minY + (r120Rect.height - r120TextHeight) / 2, width: r120Rect.width, height: r120TextHeight)
        NSGraphicsContext.saveGraphicsState()
        r120Rect.clip()
        r120TextContent.draw(in: r120TextRect.offsetBy(dx: 0, dy: 2), withAttributes: r120FontAttributes)
        NSGraphicsContext.restoreGraphicsState()


        //// R90 Drawing
        let r90Rect = NSRect(x: labels.minX + 131, y: labels.minY + 29, width: 21, height: 28)
        let r90TextContent = "90"
        let r90Style = NSMutableParagraphStyle()
        r90Style.alignment = .center
        let r90FontAttributes = [
            .font: NSFont(name: "AvenirNextCondensed-DemiBold", size: 15)!,
            .foregroundColor: NSColor.black,
            .paragraphStyle: r90Style,
        ] as [NSAttributedString.Key: Any]

        let r90TextHeight: CGFloat = r90TextContent.boundingRect(with: NSSize(width: r90Rect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: r90FontAttributes).height
        let r90TextRect: NSRect = NSRect(x: r90Rect.minX, y: r90Rect.minY + (r90Rect.height - r90TextHeight) / 2, width: r90Rect.width, height: r90TextHeight)
        NSGraphicsContext.saveGraphicsState()
        r90Rect.clip()
        r90TextContent.draw(in: r90TextRect.offsetBy(dx: 0, dy: 2), withAttributes: r90FontAttributes)
        NSGraphicsContext.restoreGraphicsState()


        //// R60 Drawing
        let r60Rect = NSRect(x: labels.minX + 122, y: labels.minY + 62, width: 21, height: 27)
        let r60TextContent = "60"
        let r60Style = NSMutableParagraphStyle()
        r60Style.alignment = .center
        let r60FontAttributes = [
            .font: NSFont(name: "AvenirNextCondensed-DemiBold", size: 15)!,
            .foregroundColor: NSColor.black,
            .paragraphStyle: r60Style,
        ] as [NSAttributedString.Key: Any]

        let r60TextHeight: CGFloat = r60TextContent.boundingRect(with: NSSize(width: r60Rect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: r60FontAttributes).height
        let r60TextRect: NSRect = NSRect(x: r60Rect.minX, y: r60Rect.minY + (r60Rect.height - r60TextHeight) / 2, width: r60Rect.width, height: r60TextHeight)
        NSGraphicsContext.saveGraphicsState()
        r60Rect.clip()
        r60TextContent.draw(in: r60TextRect.offsetBy(dx: 0, dy: 2), withAttributes: r60FontAttributes)
        NSGraphicsContext.restoreGraphicsState()


        //// R30 Drawing
        let r30Rect = NSRect(x: labels.minX + 103, y: labels.minY + 87, width: 21, height: 28)
        let r30TextContent = "30"
        let r30Style = NSMutableParagraphStyle()
        r30Style.alignment = .center
        let r30FontAttributes = [
            .font: NSFont(name: "AvenirNextCondensed-DemiBold", size: 15)!,
            .foregroundColor: NSColor.black,
            .paragraphStyle: r30Style,
        ] as [NSAttributedString.Key: Any]

        let r30TextHeight: CGFloat = r30TextContent.boundingRect(with: NSSize(width: r30Rect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: r30FontAttributes).height
        let r30TextRect: NSRect = NSRect(x: r30Rect.minX, y: r30Rect.minY + (r30Rect.height - r30TextHeight) / 2, width: r30Rect.width, height: r30TextHeight)
        NSGraphicsContext.saveGraphicsState()
        r30Rect.clip()
        r30TextContent.draw(in: r30TextRect.offsetBy(dx: 0, dy: 2), withAttributes: r30FontAttributes)
        NSGraphicsContext.restoreGraphicsState()


        //// L120 Drawing
        let l120Rect = NSRect(x: labels.minX + 7, y: labels.minY, width: 28, height: 27)
        let l120TextContent = "120"
        let l120Style = NSMutableParagraphStyle()
        l120Style.alignment = .center
        let l120FontAttributes = [
            .font: NSFont(name: "AvenirNextCondensed-DemiBold", size: 15)!,
            .foregroundColor: NSColor.black,
            .paragraphStyle: l120Style,
        ] as [NSAttributedString.Key: Any]

        let l120TextHeight: CGFloat = l120TextContent.boundingRect(with: NSSize(width: l120Rect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: l120FontAttributes).height
        let l120TextRect: NSRect = NSRect(x: l120Rect.minX, y: l120Rect.minY + (l120Rect.height - l120TextHeight) / 2, width: l120Rect.width, height: l120TextHeight)
        NSGraphicsContext.saveGraphicsState()
        l120Rect.clip()
        l120TextContent.draw(in: l120TextRect.offsetBy(dx: 0, dy: 2), withAttributes: l120FontAttributes)
        NSGraphicsContext.restoreGraphicsState()


        //// L90 Drawing
        let l90Rect = NSRect(x: labels.minX, y: labels.minY + 29, width: 21, height: 28)
        let l90TextContent = "90"
        let l90Style = NSMutableParagraphStyle()
        l90Style.alignment = .center
        let l90FontAttributes = [
            .font: NSFont(name: "AvenirNextCondensed-DemiBold", size: 15)!,
            .foregroundColor: NSColor.black,
            .paragraphStyle: l90Style,
        ] as [NSAttributedString.Key: Any]

        let l90TextHeight: CGFloat = l90TextContent.boundingRect(with: NSSize(width: l90Rect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: l90FontAttributes).height
        let l90TextRect: NSRect = NSRect(x: l90Rect.minX, y: l90Rect.minY + (l90Rect.height - l90TextHeight) / 2, width: l90Rect.width, height: l90TextHeight)
        NSGraphicsContext.saveGraphicsState()
        l90Rect.clip()
        l90TextContent.draw(in: l90TextRect.offsetBy(dx: 0, dy: 2), withAttributes: l90FontAttributes)
        NSGraphicsContext.restoreGraphicsState()


        //// L60 Drawing
        let l60Rect = NSRect(x: labels.minX + 10, y: labels.minY + 62, width: 21, height: 27)
        let l60TextContent = "60"
        let l60Style = NSMutableParagraphStyle()
        l60Style.alignment = .center
        let l60FontAttributes = [
            .font: NSFont(name: "AvenirNextCondensed-DemiBold", size: 15)!,
            .foregroundColor: NSColor.black,
            .paragraphStyle: l60Style,
        ] as [NSAttributedString.Key: Any]

        let l60TextHeight: CGFloat = l60TextContent.boundingRect(with: NSSize(width: l60Rect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: l60FontAttributes).height
        let l60TextRect: NSRect = NSRect(x: l60Rect.minX, y: l60Rect.minY + (l60Rect.height - l60TextHeight) / 2, width: l60Rect.width, height: l60TextHeight)
        NSGraphicsContext.saveGraphicsState()
        l60Rect.clip()
        l60TextContent.draw(in: l60TextRect.offsetBy(dx: 0, dy: 2), withAttributes: l60FontAttributes)
        NSGraphicsContext.restoreGraphicsState()


        //// L30 Drawing
        let l30Rect = NSRect(x: labels.minX + 28, y: labels.minY + 87, width: 21, height: 28)
        let l30TextContent = "30"
        let l30Style = NSMutableParagraphStyle()
        l30Style.alignment = .center
        let l30FontAttributes = [
            .font: NSFont(name: "AvenirNextCondensed-DemiBold", size: 15)!,
            .foregroundColor: NSColor.black,
            .paragraphStyle: l30Style,
        ] as [NSAttributedString.Key: Any]

        let l30TextHeight: CGFloat = l30TextContent.boundingRect(with: NSSize(width: l30Rect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: l30FontAttributes).height
        let l30TextRect: NSRect = NSRect(x: l30Rect.minX, y: l30Rect.minY + (l30Rect.height - l30TextHeight) / 2, width: l30Rect.width, height: l30TextHeight)
        NSGraphicsContext.saveGraphicsState()
        l30Rect.clip()
        l30TextContent.draw(in: l30TextRect.offsetBy(dx: 0, dy: 2), withAttributes: l30FontAttributes)
        NSGraphicsContext.restoreGraphicsState()




        //// pointer
        NSGraphicsContext.saveGraphicsState()
        context.translateBy(x: frame.minX + 0.50000 * frame.width, y: frame.minY + 0.50000 * frame.height)



        //// Oval 4 Drawing
        let oval4Path = NSBezierPath(ovalIn: NSRect(x: -6.5, y: -6.5, width: 13, height: 13))
        DMWindAngleDial.color3.setFill()
        oval4Path.fill()


        //// Rectangle Drawing
        NSGraphicsContext.saveGraphicsState()
        context.translateBy(x: 0, y: 1.81)
        context.rotate(by: pointerAngle * CGFloat.pi/180)

        let rectanglePath = NSBezierPath()
        rectanglePath.move(to: NSPoint(x: 2, y: 83.08))
        rectanglePath.curve(to: NSPoint(x: 2.8, y: -1.33), controlPoint1: NSPoint(x: 2.15, y: 82.38), controlPoint2: NSPoint(x: 2.8, y: -1.33))
        rectanglePath.curve(to: NSPoint(x: 0, y: -3.83), controlPoint1: NSPoint(x: 2.59, y: -2.09), controlPoint2: NSPoint(x: 2, y: -3.83))
        rectanglePath.curve(to: NSPoint(x: -2.78, y: -1.39), controlPoint1: NSPoint(x: -2, y: -3.83), controlPoint2: NSPoint(x: -2.58, y: -2.12))
        rectanglePath.curve(to: NSPoint(x: -2, y: 83.08), controlPoint1: NSPoint(x: -2.81, y: -1.31), controlPoint2: NSPoint(x: -2, y: 83.08))
        rectanglePath.curve(to: NSPoint(x: 0, y: 88.19), controlPoint1: NSPoint(x: -2.2, y: 83.03), controlPoint2: NSPoint(x: 0, y: 88.19))
        rectanglePath.curve(to: NSPoint(x: 2, y: 83.08), controlPoint1: NSPoint(x: 0, y: 88.19), controlPoint2: NSPoint(x: 1.99, y: 83.14))
        rectanglePath.close()
        DMWindAngleDial.color3.setFill()
        rectanglePath.fill()

        NSGraphicsContext.restoreGraphicsState()



        NSGraphicsContext.restoreGraphicsState()


        //// Starboard Arc Drawing
        NSGraphicsContext.saveGraphicsState()
        context.translateBy(x: frame.minX + 100, y: frame.maxY - 100)

        let starboardArcPath = NSBezierPath()
        starboardArcPath.move(to: NSPoint(x: 32.75, y: 87.1))
        starboardArcPath.curve(to: NSPoint(x: 80.57, y: 46.54), controlPoint1: NSPoint(x: 52.88, y: 79.53), controlPoint2: NSPoint(x: 69.81, y: 65.13))
        starboardArcPath.line(to: NSPoint(x: 71.5, y: 41.29))
        starboardArcPath.curve(to: NSPoint(x: 29.06, y: 77.29), controlPoint1: NSPoint(x: 61.95, y: 57.79), controlPoint2: NSPoint(x: 46.92, y: 70.58))
        starboardArcPath.line(to: NSPoint(x: 32.75, y: 87.1))
        starboardArcPath.close()
        DMWindAngleDial.color5.setFill()
        starboardArcPath.fill()
        NSColor.green.setStroke()
        starboardArcPath.lineWidth = 2
        starboardArcPath.stroke()

        NSGraphicsContext.restoreGraphicsState()


        //// Port Arc Drawing
        NSGraphicsContext.saveGraphicsState()
        context.translateBy(x: frame.minX + 100, y: frame.maxY - 100)
        context.rotate(by: 0.04 * CGFloat.pi/180)

        let portArcPath = NSBezierPath()
        portArcPath.move(to: NSPoint(x: -31.91, y: 88.11))
        portArcPath.curve(to: NSPoint(x: -80.57, y: 47.54), controlPoint1: NSPoint(x: -52.4, y: 80.53), controlPoint2: NSPoint(x: -69.62, y: 66.13))
        portArcPath.line(to: NSPoint(x: -71.34, y: 42.29))
        portArcPath.curve(to: NSPoint(x: -28.16, y: 78.29), controlPoint1: NSPoint(x: -61.62, y: 58.79), controlPoint2: NSPoint(x: -46.33, y: 71.58))
        portArcPath.line(to: NSPoint(x: -31.91, y: 88.11))
        portArcPath.close()
        NSColor.red.setFill()
        portArcPath.fill()
        NSColor.red.setStroke()
        portArcPath.lineWidth = 2
        portArcPath.stroke()

        NSGraphicsContext.restoreGraphicsState()


        //// Divisions
        NSGraphicsContext.saveGraphicsState()
        context.translateBy(x: frame.minX + 0.50000 * frame.width, y: frame.minY + 0.50000 * frame.height)



        //// Major
        //// RM150 Drawing
        NSGraphicsContext.saveGraphicsState()
        context.translateBy(x: 45.86, y: -80.59)
        context.rotate(by: 30 * CGFloat.pi/180)

        let rM150Path = NSBezierPath(roundedRect: NSRect(x: 0, y: 0, width: 2.62, height: 19.66), xRadius: 1.31, yRadius: 1.31)
        NSColor.lightGray.setFill()
        rM150Path.fill()

        NSGraphicsContext.restoreGraphicsState()


        //// RM120 Drawing
        NSGraphicsContext.saveGraphicsState()
        context.translateBy(x: 80.57, y: -47.83)
        context.rotate(by: 60 * CGFloat.pi/180)

        let rM120Path = NSBezierPath(roundedRect: NSRect(x: 0, y: 0, width: 2.62, height: 19.66), xRadius: 1.31, yRadius: 1.31)
        NSColor.lightGray.setFill()
        rM120Path.fill()

        NSGraphicsContext.restoreGraphicsState()


        //// RM90 Drawing
        NSGraphicsContext.saveGraphicsState()
        context.translateBy(x: 93.69, y: -1.97)
        context.rotate(by: 90 * CGFloat.pi/180)

        let rM90Path = NSBezierPath(roundedRect: NSRect(x: 0, y: 0, width: 2.62, height: 19.66), xRadius: 1.31, yRadius: 1.31)
        NSColor.lightGray.setFill()
        rM90Path.fill()

        NSGraphicsContext.restoreGraphicsState()


        //// RM60 Drawing
        NSGraphicsContext.saveGraphicsState()
        context.translateBy(x: 63.55, y: 38.3)
        context.rotate(by: -60 * CGFloat.pi/180)

        let rM60Path = NSBezierPath(roundedRect: NSRect(x: 0, y: 0, width: 2.62, height: 19.66), xRadius: 1.31, yRadius: 1.31)
        NSColor.lightGray.setFill()
        rM60Path.fill()

        NSGraphicsContext.restoreGraphicsState()


        //// RM30 Drawing
        NSGraphicsContext.saveGraphicsState()
        context.translateBy(x: 36.13, y: 64.03)
        context.rotate(by: -30 * CGFloat.pi/180)

        let rM30Path = NSBezierPath(roundedRect: NSRect(x: 0, y: 0, width: 2.62, height: 19.66), xRadius: 1.31, yRadius: 1.31)
        NSColor.lightGray.setFill()
        rM30Path.fill()

        NSGraphicsContext.restoreGraphicsState()


        //// LM150 Drawing
        NSGraphicsContext.saveGraphicsState()
        context.translateBy(x: -47.83, y: -80.59)
        context.rotate(by: -30 * CGFloat.pi/180)

        let lM150Path = NSBezierPath(roundedRect: NSRect(x: 0, y: 0, width: 2.62, height: 19.66), xRadius: 1.31, yRadius: 1.31)
        NSColor.lightGray.setFill()
        lM150Path.fill()

        NSGraphicsContext.restoreGraphicsState()


        //// LM120 Drawing
        NSGraphicsContext.saveGraphicsState()
        context.translateBy(x: -80.59, y: -45.56)
        context.rotate(by: -60 * CGFloat.pi/180)

        let lM120Path = NSBezierPath(roundedRect: NSRect(x: 0, y: 0, width: 2.62, height: 19.66), xRadius: 1.31, yRadius: 1.31)
        NSColor.lightGray.setFill()
        lM120Path.fill()

        NSGraphicsContext.restoreGraphicsState()


        //// LM90 Drawing
        NSGraphicsContext.saveGraphicsState()
        context.translateBy(x: -74.03, y: -1.97)
        context.rotate(by: 90 * CGFloat.pi/180)

        let lM90Path = NSBezierPath(roundedRect: NSRect(x: 0, y: 0, width: 2.62, height: 19.66), xRadius: 1.31, yRadius: 1.31)
        NSColor.lightGray.setFill()
        lM90Path.fill()

        NSGraphicsContext.restoreGraphicsState()


        //// LM60 Drawing
        NSGraphicsContext.saveGraphicsState()
        context.translateBy(x: -63.56, y: 35.38)
        context.rotate(by: 60 * CGFloat.pi/180)

        let lM60Path = NSBezierPath(roundedRect: NSRect(x: 0, y: 0, width: 2.62, height: 19.66), xRadius: 1.31, yRadius: 1.31)
        NSColor.lightGray.setFill()
        lM60Path.fill()

        NSGraphicsContext.restoreGraphicsState()


        //// LM30 Drawing
        NSGraphicsContext.saveGraphicsState()
        context.translateBy(x: -38, y: 63.56)
        context.rotate(by: 30 * CGFloat.pi/180)

        let lM30Path = NSBezierPath(roundedRect: NSRect(x: 0, y: 0, width: 2.62, height: 19.66), xRadius: 1.31, yRadius: 1.31)
        NSColor.lightGray.setFill()
        lM30Path.fill()

        NSGraphicsContext.restoreGraphicsState()




        //// Minor
        //// R140 Drawing
        let r140Path = NSBezierPath(ovalIn: NSRect(x: 57.5, y: -62.5, width: 2, height: 2))
        NSColor.lightGray.setFill()
        r140Path.fill()


        //// R130 Drawing
        let r130Path = NSBezierPath(ovalIn: NSRect(x: 65.5, y: -53.5, width: 2, height: 2))
        NSColor.lightGray.setFill()
        r130Path.fill()


        //// R110 Drawing
        let r110Path = NSBezierPath(ovalIn: NSRect(x: 77.5, y: -30.5, width: 2, height: 2))
        NSColor.lightGray.setFill()
        r110Path.fill()


        //// R100 Drawing
        let r100Path = NSBezierPath(ovalIn: NSRect(x: 81.5, y: -15.5, width: 2, height: 2))
        NSColor.lightGray.setFill()
        r100Path.fill()


        //// R80 Drawing
        let r80Path = NSBezierPath(ovalIn: NSRect(x: 81.5, y: 12.5, width: 2, height: 2))
        NSColor.lightGray.setFill()
        r80Path.fill()


        //// R70 Drawing
        let r70Path = NSBezierPath(ovalIn: NSRect(x: 77.5, y: 26.5, width: 2, height: 2))
        NSColor.lightGray.setFill()
        r70Path.fill()


        //// R50 Drawing
        let r50Path = NSBezierPath(ovalIn: NSRect(x: 65.5, y: 51.5, width: 2, height: 2))
        NSColor.lightGray.setFill()
        r50Path.fill()


        //// R40 Drawing
        let r40Path = NSBezierPath(ovalIn: NSRect(x: 57.5, y: 60.5, width: 2, height: 2))
        NSColor.lightGray.setFill()
        r40Path.fill()


        //// R20 Drawing
        let r20Path = NSBezierPath(ovalIn: NSRect(x: 37, y: 75, width: 2, height: 2))
        NSColor.lightGray.setFill()
        r20Path.fill()


        //// L140 Drawing
        let l140Path = NSBezierPath(ovalIn: NSRect(x: -58.5, y: -62.5, width: 2, height: 2))
        NSColor.lightGray.setFill()
        l140Path.fill()


        //// L130 Drawing
        let l130Path = NSBezierPath(ovalIn: NSRect(x: -66.5, y: -53.5, width: 2, height: 2))
        NSColor.lightGray.setFill()
        l130Path.fill()


        //// L110 Drawing
        let l110Path = NSBezierPath(ovalIn: NSRect(x: -78.5, y: -29.5, width: 2, height: 2))
        NSColor.lightGray.setFill()
        l110Path.fill()


        //// L100 Drawing
        let l100Path = NSBezierPath(ovalIn: NSRect(x: -82.5, y: -15.5, width: 2, height: 2))
        NSColor.lightGray.setFill()
        l100Path.fill()


        //// L80 Drawing
        let l80Path = NSBezierPath(ovalIn: NSRect(x: -82.5, y: 12.5, width: 2, height: 2))
        NSColor.lightGray.setFill()
        l80Path.fill()


        //// L70 Drawing
        let l70Path = NSBezierPath(ovalIn: NSRect(x: -78.5, y: 26.5, width: 2, height: 2))
        NSColor.lightGray.setFill()
        l70Path.fill()


        //// L50 Drawing
        let l50Path = NSBezierPath(ovalIn: NSRect(x: -68.5, y: 50.5, width: 2, height: 2))
        NSColor.lightGray.setFill()
        l50Path.fill()


        //// L40 Drawing
        let l40Path = NSBezierPath(ovalIn: NSRect(x: -59.5, y: 60.5, width: 2, height: 2))
        NSColor.lightGray.setFill()
        l40Path.fill()


        //// L20 Drawing
        let l20Path = NSBezierPath(ovalIn: NSRect(x: -39, y: 75, width: 2, height: 2))
        NSColor.lightGray.setFill()
        l20Path.fill()





        NSGraphicsContext.restoreGraphicsState()


        //// TextDisplay
        //// Rectangle 14 Drawing
        let rectangle14Path = NSBezierPath(roundedRect: NSRect(x: textDisplay.minX, y: textDisplay.minY, width: 83, height: 53), xRadius: 2, yRadius: 2)
        DMWindAngleDial.color4.setFill()
        rectangle14Path.fill()
        NSColor.darkGray.setStroke()
        rectangle14Path.lineWidth = 1
        rectangle14Path.stroke()


        //// Text 9 Drawing
        let text9Rect = NSRect(x: textDisplay.minX + 3, y: textDisplay.minY + 3, width: 77, height: 13)
        let text9Style = NSMutableParagraphStyle()
        text9Style.alignment = .center
        let text9FontAttributes = [
            .font: NSFont(name: "AvenirNextCondensed-DemiBold", size: 12)!,
            .foregroundColor: NSColor.black,
            .paragraphStyle: text9Style,
        ] as [NSAttributedString.Key: Any]

        let text9TextHeight: CGFloat = mode.boundingRect(with: NSSize(width: text9Rect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: text9FontAttributes).height
        let text9TextRect: NSRect = NSRect(x: text9Rect.minX, y: text9Rect.minY + (text9Rect.height - text9TextHeight) / 2, width: text9Rect.width, height: text9TextHeight)
        NSGraphicsContext.saveGraphicsState()
        text9Rect.clip()
        mode.draw(in: text9TextRect.offsetBy(dx: 0, dy: 1.5), withAttributes: text9FontAttributes)
        NSGraphicsContext.restoreGraphicsState()


        //// Text 10 Drawing
        let text10Rect = NSRect(x: textDisplay.minX, y: textDisplay.minY + 15, width: 83, height: 32)
        let text10Style = NSMutableParagraphStyle()
        text10Style.alignment = .center
        let text10FontAttributes = [
            .font: NSFont(name: "AvenirNextCondensed-Medium", size: 23)!,
            .foregroundColor: NSColor.black,
            .paragraphStyle: text10Style,
        ] as [NSAttributedString.Key: Any]

        let text10TextHeight: CGFloat = windVelocity.boundingRect(with: NSSize(width: text10Rect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: text10FontAttributes).height
        let text10TextRect: NSRect = NSRect(x: text10Rect.minX, y: text10Rect.minY + (text10Rect.height - text10TextHeight) / 2, width: text10Rect.width, height: text10TextHeight)
        NSGraphicsContext.saveGraphicsState()
        text10Rect.clip()
        windVelocity.draw(in: text10TextRect.offsetBy(dx: 0, dy: 3), withAttributes: text10FontAttributes)
        NSGraphicsContext.restoreGraphicsState()




        //// Bezel Drawing
        let bezelPath = NSBezierPath()
        bezelPath.move(to: NSPoint(x: frame.minX + 0.96500 * frame.width, y: frame.minY + 0.50000 * frame.height))
        bezelPath.curve(to: NSPoint(x: frame.minX + 0.50000 * frame.width, y: frame.minY + 0.03500 * frame.height), controlPoint1: NSPoint(x: frame.minX + 0.96500 * frame.width, y: frame.minY + 0.24319 * frame.height), controlPoint2: NSPoint(x: frame.minX + 0.75681 * frame.width, y: frame.minY + 0.03500 * frame.height))
        bezelPath.curve(to: NSPoint(x: frame.minX + 0.03500 * frame.width, y: frame.minY + 0.50000 * frame.height), controlPoint1: NSPoint(x: frame.minX + 0.24319 * frame.width, y: frame.minY + 0.03500 * frame.height), controlPoint2: NSPoint(x: frame.minX + 0.03500 * frame.width, y: frame.minY + 0.24319 * frame.height))
        bezelPath.curve(to: NSPoint(x: frame.minX + 0.50000 * frame.width, y: frame.minY + 0.96500 * frame.height), controlPoint1: NSPoint(x: frame.minX + 0.03500 * frame.width, y: frame.minY + 0.75681 * frame.height), controlPoint2: NSPoint(x: frame.minX + 0.24319 * frame.width, y: frame.minY + 0.96500 * frame.height))
        bezelPath.curve(to: NSPoint(x: frame.minX + 0.96500 * frame.width, y: frame.minY + 0.50000 * frame.height), controlPoint1: NSPoint(x: frame.minX + 0.75681 * frame.width, y: frame.minY + 0.96500 * frame.height), controlPoint2: NSPoint(x: frame.minX + 0.96500 * frame.width, y: frame.minY + 0.75681 * frame.height))
        bezelPath.close()
        DMWindAngleDial.color6.setStroke()
        bezelPath.lineWidth = 4
        bezelPath.stroke()
    }
    
}
