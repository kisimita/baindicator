//
//  BAIndicator.swift
//  CustomIndicator
//
//  Created by RBVH on 1/22/19.
//  Copyright © 2019 Bosch. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int, a: Int = 255) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: CGFloat(a) / 255.0)
    }
    
    convenience init(argb: Int) {
        self.init(
            red: (argb >> 16) & 0xFF,
            green: (argb >> 8) & 0xFF,
            blue: argb & 0xFF,
            a: (argb >> 24) & 0xFF
        )
    }
}

public enum AnimationSpeed {
    case Fast
    case Medium // 0.2, 0.5
    case Slow
}

fileprivate struct AnimationState {
    var color: (UIColor, UIColor)
    var position: (CGFloat, CGFloat, CGFloat, CGFloat)
    init(_ positionState: (CGFloat, CGFloat, CGFloat, CGFloat),_ colorState: (UIColor, UIColor)) {
        self.position = positionState
        self.color = colorState
    }
}

fileprivate struct PositionState {
    static let Postion1: (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)
    static let Postion2: (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)
    static let Postion3: (CGFloat, CGFloat, CGFloat, CGFloat) = (0, -1, 0, 1)
    static let Postion4: (CGFloat, CGFloat, CGFloat, CGFloat) = (-1, 0, 1, 0)
}

fileprivate struct ColorState {
    static let Color1: (UIColor, UIColor) = (Configuration.partColor1, Configuration.partColor1)
    static let Color2: (UIColor, UIColor) = (Configuration.partColor2, Configuration.partColor2)
    static let Color3: (UIColor, UIColor) = (Configuration.partColor31, Configuration.partColor32)
    static let Color4: (UIColor, UIColor) = (Configuration.partColor4, Configuration.partColor4)
    static let Color5: (UIColor, UIColor) = (Configuration.partColor51, Configuration.partColor52)
    static let Color6: (UIColor, UIColor) = (Configuration.partColor6, Configuration.partColor6)
    static let Color7: (UIColor, UIColor) = (Configuration.partColor71, Configuration.partColor72)
    static let Color8: (UIColor, UIColor) = (Configuration.partColor8, Configuration.partColor8)
    static let Color9: (UIColor, UIColor) = (Configuration.partColor91, Configuration.partColor92)
    static let Color10: (UIColor, UIColor) = (Configuration.partColor10, Configuration.partColor10)
    static let Color11: (UIColor, UIColor) = (Configuration.partColor111, Configuration.partColor112)
    static let Color12: (UIColor, UIColor) = (Configuration.partColor12, Configuration.partColor12)
    static let Color13: (UIColor, UIColor) = (Configuration.partColor131, Configuration.partColor132)
    static let Color14: (UIColor, UIColor) = (Configuration.partColor14, Configuration.partColor14)
    static let Color15: (UIColor, UIColor) = (Configuration.partColor151, Configuration.partColor152)
    static let Color16 :(UIColor, UIColor) = (Configuration.partColor16, Configuration.partColor16)
    
}

fileprivate struct Configuration {
    static let partColor1 = UIColor(argb: 0x00ffffff)
    static let partColor2 = UIColor(argb: 0xff50237f)
    static let partColor31 = UIColor(argb: 0xffb90276)
    static let partColor32 = UIColor(argb: 0xff50237f)
    static let partColor4 = UIColor(argb: 0xffe20015)
    static let partColor51 = UIColor(argb: 0xffe20015)
    static let partColor52 = UIColor(argb: 0xff50237f)
    static let partColor6 = UIColor(argb: 0xff006249)
    static let partColor71 = UIColor(argb: 0xffe20015)
    static let partColor72 = UIColor(argb: 0xff006249)
    static let partColor8 = UIColor(argb: 0xff78be20)
    static let partColor91 = UIColor(argb: 0xff78be20)
    static let partColor92 = UIColor(argb: 0xff006249)
    static let partColor10 = UIColor(argb: 0xff00a8b0)
    static let partColor111 = UIColor(argb: 0xff78be20)
    static let partColor112 = UIColor(argb: 0xff00a8b0)
    static let partColor12 = UIColor(argb: 0xff008ecf)
    static let partColor131 = UIColor(argb: 0xff008ecf)
    static let partColor132 = UIColor(argb: 0xff00a8b0)
    static let partColor14 = UIColor(argb: 0xff005691)
    static let partColor151 = UIColor(argb: 0xff008ecf)
    static let partColor152 = UIColor(argb: 0xff005691)
    static let partColor16 = UIColor(argb: 0xffb90276)
}

public class BAIndicator: UIView {

    private var animationDuration = 1.0
    private var isRepeated = true
    
    private var rectWidth: CGFloat = 16.0
    private var rectHeight: CGFloat = 16.0
    private var startRectX: CGFloat!
    private var startRectY: CGFloat!
    private let moveDistance: CGFloat = 16.0
    private let margin: CGFloat = 12
    
    private var rect1: UIView!
    private var rect2: UIView!
    
    private var stateIndex = 1
    private var timer: Timer!
    private var animationStateDuration = 1.0
    private var animationSpeed: AnimationSpeed = .Fast
    
    private var states:[AnimationState] = [
        AnimationState(PositionState.Postion1, ColorState.Color1),
        AnimationState(PositionState.Postion2, ColorState.Color2),
        AnimationState(PositionState.Postion3, ColorState.Color3),
        AnimationState(PositionState.Postion2, ColorState.Color4),
        AnimationState(PositionState.Postion4, ColorState.Color5),
        AnimationState(PositionState.Postion2, ColorState.Color6),
        AnimationState(PositionState.Postion3, ColorState.Color7),
        AnimationState(PositionState.Postion2, ColorState.Color8),
        AnimationState(PositionState.Postion4, ColorState.Color9),
        AnimationState(PositionState.Postion2, ColorState.Color10),
        AnimationState(PositionState.Postion3, ColorState.Color11),
        AnimationState(PositionState.Postion2, ColorState.Color12),
        AnimationState(PositionState.Postion4, ColorState.Color13),
        AnimationState(PositionState.Postion2, ColorState.Color14),
        AnimationState(PositionState.Postion3, ColorState.Color15),
        AnimationState(PositionState.Postion2, ColorState.Color16),
    ]
    
    public init(frame: CGRect, isRepeated: Bool = true, backgroundColor: UIColor = UIColor.white, speed: AnimationSpeed = .Fast) {
        super.init(frame: frame)
        self.isRepeated = isRepeated
        self.backgroundColor = backgroundColor
        self.animationSpeed = speed
        calculateStartValues()
        createLoadingUIParts()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        calculateStartValues()
        createLoadingUIParts()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func calculateStartValues() {
        rectWidth = (self.frame.width - (margin * 2)) / 3
        rectHeight = (self.frame.height - (margin * 2)) / 3
        startRectX = self.frame.width/2 - rectWidth / 2
        startRectY = self.frame.height/2 - rectHeight / 2
        switch animationSpeed {
        case .Fast:
            animationDuration = 0.2
            animationStateDuration = 0.2
            break
        case .Medium:
            animationDuration = 0.5
            animationStateDuration = 0.5
            break
        case .Slow:
            animationDuration = 1.0
            animationStateDuration = 1.0
        }
    }
    
    private func createLoadingUIParts() {
        rect1 = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        rect1.backgroundColor = UIColor.clear
        
        rect2 = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        rect2.backgroundColor = UIColor.clear
        
        self.addSubview(rect1)
        self.addSubview(rect2)
        
    }
    
    public func startAmination() {
        stateIndex = -1
        timer = Timer.scheduledTimer(timeInterval: animationStateDuration, target: self, selector: #selector(self.doAnimation), userInfo: nil, repeats: true)
    }
    
    public func stopAnimation() {
        if timer != nil {
            timer.invalidate()
            timer = nil
        }
    }
    
    @objc private func doAnimation() {
        if isRepeated == true {
            if(self.stateIndex < states.count - 1) {
                self.stateIndex += 1
            } else {
                self.stateIndex = 0
            }
        } else {
            if stateIndex == (states.count - 1) {
                timer.invalidate()
                timer = nil
            }
        }
        
        UIView.animate(withDuration: animationDuration, animations: {
            let (rect1X, rect1Y, rect2X, rect2Y) = self.states[self.stateIndex].position
            let (color1, color2) = self.states[self.stateIndex].color
            
            self.rect1.frame = CGRect(x: self.startRectX + rect1X * self.rectWidth , y: self.startRectY + rect1Y * self.rectHeight,
                                      width: self.rectWidth, height: self.rectHeight)
            self.rect1.backgroundColor = color1
            
            self.rect2.frame = CGRect(x: self.startRectX + rect2X * self.rectWidth, y: self.startRectY + rect2Y * self.rectHeight,
                                      width: self.rectWidth, height: self.rectHeight)
            self.rect2.backgroundColor = color2
        })
        
        
    }
}
