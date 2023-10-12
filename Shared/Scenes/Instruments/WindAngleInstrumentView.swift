//
//  DMWindAngleDial.swift
//  XBridge
//
//  Created by Christopher Alford on 02.03.20.
//  Copyright © 2020 marine.digital. All rights reserved.
//
//  Generated by PaintCode
//  http://www.paintcodeapp.com
//

import SwiftUI

// This non-generic function dramatically improves compilation times of complex expressions.
func fastFloor(_ x: CGFloat) -> CGFloat { return floor(x) }

struct Bezel: Shape {
    func path(in rect: CGRect) -> Path {
        let group: CGRect = CGRect(x: rect.minX + fastFloor((rect.width - 200) * 0.50000), y: rect.minY + fastFloor((rect.height - 200) * 0.50000), width: 200, height: 200)
        var path = Path()
        path.move(to: CGPoint(x: group.minX + 194, y: group.maxY - 99))
        path.addCurve(to: CGPoint(x: group.minX + 101, y: group.maxY - 192), control1: CGPoint(x: group.minX + 194, y: group.maxY - 150.36), control2: CGPoint(x: group.minX + 152.36, y: group.maxY - 192))
        path.addCurve(to: CGPoint(x: group.minX + 8, y: group.maxY - 99), control1: CGPoint(x: group.minX + 49.64, y: group.maxY - 192), control2: CGPoint(x: group.minX + 8, y: group.maxY - 150.36))
        path.addCurve(to: CGPoint(x: group.minX + 101, y: group.maxY - 6), control1: CGPoint(x: group.minX + 8, y: group.maxY - 47.64), control2: CGPoint(x: group.minX + 49.64, y: group.maxY - 6))
        path.addCurve(to: CGPoint(x: group.minX + 194, y: group.maxY - 99), control1: CGPoint(x: group.minX + 152.36, y: group.maxY - 6), control2: CGPoint(x: group.minX + 194, y: group.maxY - 47.64))
        return path
            //.applying(CGAffineTransform(translationX: group.minX, y: group.minY))
    }
}

struct BowIndicator: Shape {
    func path(in rect: CGRect) -> Path {
        let group: CGRect = CGRect(x: rect.minX + fastFloor((rect.width - 190) * 0.50000 + 0.5), y: rect.minY + fastFloor((rect.height - 190) * 0.50000 + 0.5), width: 190, height: 190)
        var path = Path()
        path.move(to: CGPoint(x: group.minX + 63, y: group.minY + 85.83))
        path.addCurve(to: CGPoint(x: group.minX + 71.03, y: group.minY + 131.69),
                      control1: CGPoint(x: group.minX + 63, y: group.minY + 85.83),
                      control2: CGPoint(x: group.minX + 63, y: group.minY + 110.72))
        path.addCurve(to: CGPoint(x: group.minX + 95.1, y: group.minY + 172.31),
                      control1: CGPoint(x: group.minX + 79.05, y: group.minY + 152.66),
                      control2: CGPoint(x: group.minX + 95.1, y: group.minY + 172.31))
        path.move(to: CGPoint(x: group.minX + 127.21, y: group.minY + 85.83))
        path.addCurve(to: CGPoint(x: group.minX + 119.18, y: group.minY + 131.69), control1: CGPoint(x: group.minX + 127.21, y: group.minY + 85.83), control2: CGPoint(x: group.minX + 127.21, y: group.minY + 110.72))
        path.addCurve(to: CGPoint(x: group.minX + 95.1, y: group.minY + 172.31),
                      control1: CGPoint(x: group.minX + 111.16, y: group.minY + 152.66),
                      control2: CGPoint(x: group.minX + 95.1, y: group.minY + 172.31))
        return path
    }
}

struct Pointer: Shape {
    // context.translateBy(x: frame.minX + 0.50500 * frame.width, y: frame.minY + 0.50000 * frame.height)
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 2, y: 83.08))
        path.addCurve(to: CGPoint(x: 2.8, y: -1.33), control1: CGPoint(x: 2.15, y: 82.38), control2: CGPoint(x: 2.8, y: -1.33))
        path.addCurve(to: CGPoint(x: 0, y: -3.83), control1: CGPoint(x: 2.59, y: -2.09), control2: CGPoint(x: 2, y: -3.83))
        path.addCurve(to: CGPoint(x: -2.78, y: -1.39), control1: CGPoint(x: -2, y: -3.83), control2: CGPoint(x: -2.58, y: -2.12))
        path.addCurve(to: CGPoint(x: -2, y: 83.08), control1: CGPoint(x: -2.81, y: -1.31), control2: CGPoint(x: -2, y: 83.08))
        path.addCurve(to: CGPoint(x: 0, y: 88.19), control1: CGPoint(x: -2.2, y: 83.03), control2: CGPoint(x: 0, y: 88.19))
        path.addCurve(to: CGPoint(x: 2, y: 83.08), control1: CGPoint(x: 0, y: 88.19), control2: CGPoint(x: 1.99, y: 83.14))
        return path
    }
}

struct PortArc: Shape {
    func path(in rect: CGRect) -> Path {
        let group: CGRect = CGRect(x: rect.minX + fastFloor((rect.width - 190) * 0.50000 + 0.5), y: rect.minY + fastFloor((rect.height - 190) * 0.50000 + 0.5), width: 190, height: 190)
        var path = Path()
        path.move(to: CGPoint(x: -31.91, y: 87.1))
        path.addCurve(to: CGPoint(x: -80.57, y: 46.54), control1: CGPoint(x: -52.4, y: 79.53), control2: CGPoint(x: -69.62, y: 65.13))
        path.addLine(to: CGPoint(x: -71.34, y: 41.29))
        path.addCurve(to: CGPoint(x: -28.16, y: 77.29), control1: CGPoint(x: -61.62, y: 57.79), control2: CGPoint(x: -46.33, y: 70.58))
        path.addLine(to: CGPoint(x: -31.91, y: 87.1))
        return path
            .applying(CGAffineTransform(rotationAngle: 0.04 * CGFloat.pi/180))
            .applying(CGAffineTransform(translationX: group.minX + 95, y: group.minY + 95))
    }
}

struct StarboardArc: Shape {
    func path(in rect: CGRect) -> Path {
        let group: CGRect = CGRect(x: rect.minX + fastFloor((rect.width - 190) * 0.50000 + 0.5), y: rect.minY + fastFloor((rect.height - 190) * 0.50000 + 0.5), width: 190, height: 190)
        var path = Path()
        path.move(to: CGPoint(x: 32.75, y: 87.1))
        path.addCurve(to: CGPoint(x: 80.57, y: 46.54), control1: CGPoint(x: 52.88, y: 79.53), control2: CGPoint(x: 69.81, y: 65.13))
        path.addLine(to: CGPoint(x: 71.5, y: 41.29))
        path.addCurve(to: CGPoint(x: 29.06, y: 77.29), control1: CGPoint(x: 61.95, y: 57.79), control2: CGPoint(x: 46.92, y: 70.58))
        path.addLine(to: CGPoint(x: 32.75, y: 87.1))
        return path
            .applying(CGAffineTransform(translationX: group.minX + 95,
                                            y: group.minY + 95))
    }
}

struct PointerCenter: Shape {
    func path(in rect: CGRect) -> Path {
        let path = Path(ellipseIn: CGRect(x: -6.5, y: -6.5, width: 13, height: 13))
        return path
    }
}

struct Oval: Shape {
    func path(in rect: CGRect) -> Path {
        let path = Path()
        return path
    }
//let ovalRect = CGRect(x: group.minX + 11, y: group.minY + 12, width: 170, height: 170)
//let ovalPath = UIBezierPath()
//ovalPath.addArc(withCenter: CGPoint(x: ovalRect.midX, y: ovalRect.midY), radius: ovalRect.width / 2, startAngle: lStartAngle * CGFloat.pi/180, endAngle: lEndAngle * CGFloat.pi/180, clockwise: false)

// UIColor.gray.setFill()
// color3.setStroke()
// ovalPath.lineWidth = 10
// ovalPath.stroke()
}

struct DialBackgroundPath: Shape {
    func path(in rect: CGRect) -> Path {
        let group: CGRect = CGRect(x: rect.minX + fastFloor((rect.width - 190) * 0.50000 + 0.5), y: rect.minY + fastFloor((rect.height - 190) * 0.50000 + 0.5), width: 190, height: 190)
        let path = Path(ellipseIn: CGRect(x: group.minX, y: group.minY, width: 190, height: 190))
        return path
    }
}

struct Oval23: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let group: CGRect = CGRect(x: rect.minX + fastFloor((rect.width - 190) * 0.50000 + 0.5), y: rect.minY + fastFloor((rect.height - 190) * 0.50000 + 0.5), width: 190, height: 190)
        path.move(to: CGPoint(x: 32.75, y: 87.1))
        path.addCurve(to: CGPoint(x: 80.57, y: 46.54), control1: CGPoint(x: 52.88, y: 79.53), control2: CGPoint(x: 69.81, y: 65.13))
        path.addLine(to: CGPoint(x: 71.5, y: 41.29))
        path.addCurve(to: CGPoint(x: 29.06, y: 77.29), control1: CGPoint(x: 61.95, y: 57.79), control2: CGPoint(x: 46.92, y: 70.58))
        path.addLine(to: CGPoint(x: 32.75, y: 87.1))
        return path
            .applying(CGAffineTransform(translationX: group.minX + 95,
                                            y: group.minY + 95))
    }
}


struct WindAngleInstrumentView: View {
    @State var pointerAngle = CGFloat(-0.8)
    @State var windVelocity = "000.0"
    @State var mode = "TRUE"

    var body: some View {
        ZStack {
            Color.gray
            DialBackgroundPath()
                .fill(Color.white)
            Oval23()
            .stroke(lineWidth: 2)
            .fill(Color.color5)
            Bezel()
                .stroke(lineWidth: 4) // //color6
            Pointer()
                .fill(Color.color3)
            PointerCenter()
                .fill(Color.color3)
            BowIndicator()
                .stroke(lineWidth: 2)
            PortArc()
                .stroke(lineWidth: 2) // Color.red
                .fill(Color.red)
            StarboardArc()
                .stroke(lineWidth: 2) //Color.green
                .fill(Color.color5)



        }
    }
}

struct WindAngleViewInstrument_Previews: PreviewProvider {
    static var previews: some View {
        WindAngleInstrumentView()
    }
}

class DMWindAngleDial : UIView {

    // Drawing Methods
    func drawWindAngleDial(frame: CGRect = CGRect(x: 0, y: 0, width: 200, height: 200), pointerAngle: CGFloat = 0, windVelocity: String = "888.8", mode: String = "TRUE", lStartAngle: CGFloat = 149, lEndAngle: CGFloat = 469) {
        // General Declarations
        // This non-generic function dramatically improves compilation times of complex expressions.
        func fastFloor(_ x: CGFloat) -> CGFloat { return floor(x) }


        // Subframes
        let group: CGRect = CGRect(x: frame.minX + fastFloor((frame.width - 190) * 0.50000 + 0.5), y: frame.minY + fastFloor((frame.height - 190) * 0.50000 + 0.5), width: 190, height: 190)


        // Group
        // DialBackground Drawing
        let dialBackgroundPath = UIBezierPath(ovalIn: CGRect(x: group.minX, y: group.minY, width: 190, height: 190))
        UIColor.white.setFill()
        dialBackgroundPath.fill()
    }
}

/*
        // Major
        // RM150 Drawing

        context.translateBy(x: group.minX + 140.86, y: group.minY + 14.41)
        context.rotate(by: 30 * CGFloat.pi/180)

        let rM150Path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 2.62, height: 19.66), cornerRadius: 1.31)
        UIColor.lightGray.setFill()
        rM150Path.fill()




        // RM120 Drawing

        context.translateBy(x: group.minX + 175.57, y: group.minY + 47.17)
        context.rotate(by: 60 * CGFloat.pi/180)

        let rM120Path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 2.62, height: 19.66), cornerRadius: 1.31)
        UIColor.lightGray.setFill()
        rM120Path.fill()




        // RM90 Drawing

        context.translateBy(x: group.minX + 188.69, y: group.minY + 93.03)
        context.rotate(by: 90 * CGFloat.pi/180)

        let rM90Path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 2.62, height: 19.66), cornerRadius: 1.31)
        UIColor.lightGray.setFill()
        rM90Path.fill()




        // RM60 Drawing

        context.translateBy(x: group.minX + 158.55, y: group.minY + 133.3)
        context.rotate(by: -60 * CGFloat.pi/180)

        let rM60Path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 2.62, height: 19.66), cornerRadius: 1.31)
        UIColor.lightGray.setFill()
        rM60Path.fill()




        // RM30 Drawing

        context.translateBy(x: group.minX + 131.13, y: group.minY + 159.03)
        context.rotate(by: -30 * CGFloat.pi/180)

        let rM30Path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 2.62, height: 19.66), cornerRadius: 1.31)
        UIColor.lightGray.setFill()
        rM30Path.fill()




        // LM150 Drawing

        context.translateBy(x: group.minX + 47.17, y: group.minY + 14.41)
        context.rotate(by: -30 * CGFloat.pi/180)

        let lM150Path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 2.62, height: 19.66), cornerRadius: 1.31)
        UIColor.lightGray.setFill()
        lM150Path.fill()




        // LM120 Drawing

        context.translateBy(x: group.minX + 14.41, y: group.minY + 49.44)
        context.rotate(by: -60 * CGFloat.pi/180)

        let lM120Path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 2.62, height: 19.66), cornerRadius: 1.31)
        UIColor.lightGray.setFill()
        lM120Path.fill()




        // LM90 Drawing

        context.translateBy(x: group.minX + 20.97, y: group.minY + 93.03)
        context.rotate(by: 90 * CGFloat.pi/180)

        let lM90Path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 2.62, height: 19.66), cornerRadius: 1.31)
        UIColor.lightGray.setFill()
        lM90Path.fill()




        // LM60 Drawing

        context.translateBy(x: group.minX + 31.44, y: group.minY + 130.38)
        context.rotate(by: 60 * CGFloat.pi/180)

        let lM60Path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 2.62, height: 19.66), cornerRadius: 1.31)
        UIColor.lightGray.setFill()
        lM60Path.fill()




        // LM30 Drawing

        context.translateBy(x: group.minX + 57, y: group.minY + 158.56)
        context.rotate(by: 30 * CGFloat.pi/180)

        let lM30Path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 2.62, height: 19.66), cornerRadius: 1.31)
        UIColor.lightGray.setFill()
        lM30Path.fill()






        // Minor
        // R140 Drawing
        let r140Path = UIBezierPath(ovalIn: CGRect(x: group.minX + 152.5, y: group.minY + 32.5, width: 2, height: 2))
        UIColor.lightGray.setFill()
        r140Path.fill()


        // R130 Drawing
        let r130Path = UIBezierPath(ovalIn: CGRect(x: group.minX + 160.5, y: group.minY + 41.5, width: 2, height: 2))
        UIColor.lightGray.setFill()
        r130Path.fill()


        // R110 Drawing
        let r110Path = UIBezierPath(ovalIn: CGRect(x: group.minX + 172.5, y: group.minY + 64.5, width: 2, height: 2))
        UIColor.lightGray.setFill()
        r110Path.fill()


        // R100 Drawing
        let r100Path = UIBezierPath(ovalIn: CGRect(x: group.minX + 176.5, y: group.minY + 79.5, width: 2, height: 2))
        UIColor.lightGray.setFill()
        r100Path.fill()


        // R80 Drawing
        let r80Path = UIBezierPath(ovalIn: CGRect(x: group.minX + 176.5, y: group.minY + 107.5, width: 2, height: 2))
        UIColor.lightGray.setFill()
        r80Path.fill()


        // R70 Drawing
        let r70Path = UIBezierPath(ovalIn: CGRect(x: group.minX + 172.5, y: group.minY + 121.5, width: 2, height: 2))
        UIColor.lightGray.setFill()
        r70Path.fill()


        // R50 Drawing
        let r50Path = UIBezierPath(ovalIn: CGRect(x: group.minX + 160.5, y: group.minY + 146.5, width: 2, height: 2))
        UIColor.lightGray.setFill()
        r50Path.fill()


        // R40 Drawing
        let r40Path = UIBezierPath(ovalIn: CGRect(x: group.minX + 152.5, y: group.minY + 155.5, width: 2, height: 2))
        UIColor.lightGray.setFill()
        r40Path.fill()


        // R20 Drawing
        let r20Path = UIBezierPath(ovalIn: CGRect(x: group.minX + 132, y: group.minY + 170, width: 2, height: 2))
        UIColor.lightGray.setFill()
        r20Path.fill()


        // L140 Drawing
        let l140Path = UIBezierPath(ovalIn: CGRect(x: group.minX + 36.5, y: group.minY + 32.5, width: 2, height: 2))
        UIColor.lightGray.setFill()
        l140Path.fill()


        // L130 Drawing
        let l130Path = UIBezierPath(ovalIn: CGRect(x: group.minX + 28.5, y: group.minY + 41.5, width: 2, height: 2))
        UIColor.lightGray.setFill()
        l130Path.fill()


        // L110 Drawing
        let l110Path = UIBezierPath(ovalIn: CGRect(x: group.minX + 16.5, y: group.minY + 65.5, width: 2, height: 2))
        UIColor.lightGray.setFill()
        l110Path.fill()


        // L100 Drawing
        let l100Path = UIBezierPath(ovalIn: CGRect(x: group.minX + 12.5, y: group.minY + 79.5, width: 2, height: 2))
        UIColor.lightGray.setFill()
        l100Path.fill()


        // L80 Drawing
        let l80Path = UIBezierPath(ovalIn: CGRect(x: group.minX + 12.5, y: group.minY + 107.5, width: 2, height: 2))
        UIColor.lightGray.setFill()
        l80Path.fill()


        // L70 Drawing
        let l70Path = UIBezierPath(ovalIn: CGRect(x: group.minX + 16.5, y: group.minY + 121.5, width: 2, height: 2))
        UIColor.lightGray.setFill()
        l70Path.fill()


        // L50 Drawing
        let l50Path = UIBezierPath(ovalIn: CGRect(x: group.minX + 26.5, y: group.minY + 145.5, width: 2, height: 2))
        UIColor.lightGray.setFill()
        l50Path.fill()


        // L40 Drawing
        let l40Path = UIBezierPath(ovalIn: CGRect(x: group.minX + 35.5, y: group.minY + 155.5, width: 2, height: 2))
        UIColor.lightGray.setFill()
        l40Path.fill()


        // L20 Drawing
        let l20Path = UIBezierPath(ovalIn: CGRect(x: group.minX + 56, y: group.minY + 170, width: 2, height: 2))
        UIColor.lightGray.setFill()
        l20Path.fill()




        // TextDisplay
        // Rectangle 14 Drawing
        let rectangle14Path = UIBezierPath(roundedRect: CGRect(x: group.minX + 54, y: group.minY + 27, width: 83, height: 53), cornerRadius: 2)
        color4.setFill()
        rectangle14Path.fill()
        UIColor.darkGray.setStroke()
        rectangle14Path.lineWidth = 1
        rectangle14Path.stroke()


        // Text 9 Drawing
        let text9Rect = CGRect(x: group.minX + 57, y: group.minY + 30, width: 77, height: 13)
        let text9Style = NSMutableParagraphStyle()
        text9Style.alignment = .center
        let text9FontAttributes = [
            .font: UIFont(name: "AvenirNextCondensed-DemiBold", size: UIFont.smallSystemFontSize)!,
            .foregroundColor: UIColor.black,
            .paragraphStyle: text9Style,
        ] as [NSAttributedString.Key: Any]

        let text9TextHeight: CGFloat = mode.boundingRect(with: CGSize(width: text9Rect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: text9FontAttributes, context: nil).height

        context.clip(to: text9Rect)
        mode.draw(in: CGRect(x: text9Rect.minX, y: text9Rect.minY + (text9TextHeight - text9Rect.height) / 2, width: text9Rect.width, height: text9TextHeight), withAttributes: text9FontAttributes)



        // Text 10 Drawing
        let text10Rect = CGRect(x: group.minX + 54, y: group.minY + 42, width: 83, height: 32)
        let text10Style = NSMutableParagraphStyle()
        text10Style.alignment = .center
        let text10FontAttributes = [
            .font: UIFont(name: "AvenirNextCondensed-Medium", size: 23)!,
            .foregroundColor: UIColor.black,
            .paragraphStyle: text10Style,
        ] as [NSAttributedString.Key: Any]

        let text10TextHeight: CGFloat = windVelocity.boundingRect(with: CGSize(width: text10Rect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: text10FontAttributes, context: nil).height

        context.clip(to: text10Rect)
        windVelocity.draw(in: CGRect(x: text10Rect.minX, y: text10Rect.minY + (text10TextHeight - text10Rect.height) / 2, width: text10Rect.width, height: text10TextHeight), withAttributes: text10FontAttributes)





        // Labels
        // R120 Drawing
        let r120Rect = CGRect(x: group.minX + 137, y: group.minY + 51, width: 28, height: 27)
        let r120TextContent = "120"
        let r120Style = NSMutableParagraphStyle()
        r120Style.alignment = .center
        let r120FontAttributes = [
            .font: UIFont(name: "AvenirNextCondensed-DemiBold", size: 15)!,
            .foregroundColor: UIColor.black,
            .paragraphStyle: r120Style,
        ] as [NSAttributedString.Key: Any]

        let r120TextHeight: CGFloat = r120TextContent.boundingRect(with: CGSize(width: r120Rect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: r120FontAttributes, context: nil).height

        context.clip(to: r120Rect)
        r120TextContent.draw(in: CGRect(x: r120Rect.minX, y: r120Rect.minY + (r120TextHeight - r120Rect.height) / 2, width: r120Rect.width, height: r120TextHeight), withAttributes: r120FontAttributes)



        // R90 Drawing
        let r90Rect = CGRect(x: group.minX + 150, y: group.minY + 80, width: 21, height: 28)
        let r90TextContent = "90"
        let r90Style = NSMutableParagraphStyle()
        r90Style.alignment = .center
        let r90FontAttributes = [
            .font: UIFont(name: "AvenirNextCondensed-DemiBold", size: 15)!,
            .foregroundColor: UIColor.black,
            .paragraphStyle: r90Style,
        ] as [NSAttributedString.Key: Any]

        let r90TextHeight: CGFloat = r90TextContent.boundingRect(with: CGSize(width: r90Rect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: r90FontAttributes, context: nil).height

        context.clip(to: r90Rect)
        r90TextContent.draw(in: CGRect(x: r90Rect.minX, y: r90Rect.minY + (r90TextHeight - r90Rect.height) / 2, width: r90Rect.width, height: r90TextHeight), withAttributes: r90FontAttributes)



        // R60 Drawing
        let r60Rect = CGRect(x: group.minX + 141, y: group.minY + 113, width: 21, height: 27)
        let r60TextContent = "60"
        let r60Style = NSMutableParagraphStyle()
        r60Style.alignment = .center
        let r60FontAttributes = [
            .font: UIFont(name: "AvenirNextCondensed-DemiBold", size: 15)!,
            .foregroundColor: UIColor.black,
            .paragraphStyle: r60Style,
        ] as [NSAttributedString.Key: Any]

        let r60TextHeight: CGFloat = r60TextContent.boundingRect(with: CGSize(width: r60Rect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: r60FontAttributes, context: nil).height

        context.clip(to: r60Rect)
        r60TextContent.draw(in: CGRect(x: r60Rect.minX, y: r60Rect.minY + (r60TextHeight - r60Rect.height) / 2, width: r60Rect.width, height: r60TextHeight), withAttributes: r60FontAttributes)



        // R30 Drawing
        let r30Rect = CGRect(x: group.minX + 122, y: group.minY + 138, width: 21, height: 28)
        let r30TextContent = "30"
        let r30Style = NSMutableParagraphStyle()
        r30Style.alignment = .center
        let r30FontAttributes = [
            .font: UIFont(name: "AvenirNextCondensed-DemiBold", size: 15)!,
            .foregroundColor: UIColor.black,
            .paragraphStyle: r30Style,
        ] as [NSAttributedString.Key: Any]

        let r30TextHeight: CGFloat = r30TextContent.boundingRect(with: CGSize(width: r30Rect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: r30FontAttributes, context: nil).height

        context.clip(to: r30Rect)
        r30TextContent.draw(in: CGRect(x: r30Rect.minX, y: r30Rect.minY + (r30TextHeight - r30Rect.height) / 2, width: r30Rect.width, height: r30TextHeight), withAttributes: r30FontAttributes)



        // L120 Drawing
        let l120Rect = CGRect(x: group.minX + 26, y: group.minY + 51, width: 28, height: 27)
        let l120TextContent = "120"
        let l120Style = NSMutableParagraphStyle()
        l120Style.alignment = .center
        let l120FontAttributes = [
            .font: UIFont(name: "AvenirNextCondensed-DemiBold", size: 15)!,
            .foregroundColor: UIColor.black,
            .paragraphStyle: l120Style,
        ] as [NSAttributedString.Key: Any]

        let l120TextHeight: CGFloat = l120TextContent.boundingRect(with: CGSize(width: l120Rect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: l120FontAttributes, context: nil).height

        context.clip(to: l120Rect)
        l120TextContent.draw(in: CGRect(x: l120Rect.minX, y: l120Rect.minY + (l120TextHeight - l120Rect.height) / 2, width: l120Rect.width, height: l120TextHeight), withAttributes: l120FontAttributes)



        // L90 Drawing
        let l90Rect = CGRect(x: group.minX + 19, y: group.minY + 80, width: 21, height: 28)
        let l90TextContent = "90"
        let l90Style = NSMutableParagraphStyle()
        l90Style.alignment = .center
        let l90FontAttributes = [
            .font: UIFont(name: "AvenirNextCondensed-DemiBold", size: 15)!,
            .foregroundColor: UIColor.black,
            .paragraphStyle: l90Style,
        ] as [NSAttributedString.Key: Any]

        let l90TextHeight: CGFloat = l90TextContent.boundingRect(with: CGSize(width: l90Rect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: l90FontAttributes, context: nil).height

        context.clip(to: l90Rect)
        l90TextContent.draw(in: CGRect(x: l90Rect.minX, y: l90Rect.minY + (l90TextHeight - l90Rect.height) / 2, width: l90Rect.width, height: l90TextHeight), withAttributes: l90FontAttributes)



        // L60 Drawing
        let l60Rect = CGRect(x: group.minX + 29, y: group.minY + 113, width: 21, height: 27)
        let l60TextContent = "60"
        let l60Style = NSMutableParagraphStyle()
        l60Style.alignment = .center
        let l60FontAttributes = [
            .font: UIFont(name: "AvenirNextCondensed-DemiBold", size: 15)!,
            .foregroundColor: UIColor.black,
            .paragraphStyle: l60Style,
        ] as [NSAttributedString.Key: Any]

        let l60TextHeight: CGFloat = l60TextContent.boundingRect(with: CGSize(width: l60Rect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: l60FontAttributes, context: nil).height

        context.clip(to: l60Rect)
        l60TextContent.draw(in: CGRect(x: l60Rect.minX, y: l60Rect.minY + (l60TextHeight - l60Rect.height) / 2, width: l60Rect.width, height: l60TextHeight), withAttributes: l60FontAttributes)



        // L30 Drawing
        let l30Rect = CGRect(x: group.minX + 47, y: group.minY + 138, width: 21, height: 28)
        let l30TextContent = "30"
        let l30Style = NSMutableParagraphStyle()
        l30Style.alignment = .center
        let l30FontAttributes = [
            .font: UIFont(name: "AvenirNextCondensed-DemiBold", size: 15)!,
            .foregroundColor: UIColor.black,
            .paragraphStyle: l30Style,
        ] as [NSAttributedString.Key: Any]

        let l30TextHeight: CGFloat = l30TextContent.boundingRect(with: CGSize(width: l30Rect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: l30FontAttributes, context: nil).height

        l30TextContent.draw(in: CGRect(x: l30Rect.minX, y: l30Rect.minY + (l30TextHeight - l30Rect.height) / 2, width: l30Rect.width, height: l30TextHeight), withAttributes: l30FontAttributes)

        // Rectangle Drawing
        //context.translateBy(x: 0, y: 1.81)
        //context.rotate(by: pointerAngle * CGFloat.pi/180)

        let rectanglePath = UIBezierPath()
        rectanglePath.move(to: CGPoint(x: 2, y: 83.08))
        rectanglePath.addCurve(to: CGPoint(x: 2.8, y: -1.33), control1: CGPoint(x: 2.15, y: 82.38), control2: CGPoint(x: 2.8, y: -1.33))
        rectanglePath.addCurve(to: CGPoint(x: 0, y: -3.83), control1: CGPoint(x: 2.59, y: -2.09), control2: CGPoint(x: 2, y: -3.83))
        rectanglePath.addCurve(to: CGPoint(x: -2.78, y: -1.39), control1: CGPoint(x: -2, y: -3.83), control2: CGPoint(x: -2.58, y: -2.12))
        rectanglePath.addCurve(to: CGPoint(x: -2, y: 83.08), control1: CGPoint(x: -2.81, y: -1.31), control2: CGPoint(x: -2, y: 83.08))
        rectanglePath.addCurve(to: CGPoint(x: 0, y: 88.19), control1: CGPoint(x: -2.2, y: 83.03), control2: CGPoint(x: 0, y: 88.19))
        rectanglePath.addCurve(to: CGPoint(x: 2, y: 83.08), control1: CGPoint(x: 0, y: 88.19), control2: CGPoint(x: 1.99, y: 83.14))
        //color3.setFill()





}
*/