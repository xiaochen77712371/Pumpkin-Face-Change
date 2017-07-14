//
//  Graphics.swift
//  Quartz-Drawing-KB
//
//  Created by Kirsten Bauman on 10/31/16.
//  Copyright © 2016 Kirsten Bauman. All rights reserved.
//

import Cocoa

class Graphics: NSView {

    var colorSwitch = 0
    
    
    var x: CGFloat = 400.0
    var y: CGFloat = 50.0
    var r: CGFloat = 40.0
    let bodyWidth = 200.0
    let bodyHeight = 70.0
    
    var lastPoint: CGPoint = CGPoint(x: 0.0, y: 0.0)
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        Swift.print("Use standard init")
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        Swift.print("Use init coder")
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(Graphics.updateColor), userInfo: nil, repeats: true)
    }
    
    override func mouseDown(with event: NSEvent) {
        lastPoint = convert(event.locationInWindow, from: nil)
    }
    
    override func mouseDragged(with event: NSEvent) {
        let point: CGPoint = convert(event.locationInWindow, from: nil)
        x = x + (point.x - lastPoint.x)
        lastPoint = point
        needsDisplay = true
    }
    
    func updateColor() {
        colorSwitch += 1
        if colorSwitch >= 2
        {
            colorSwitch = 0
        }
        needsDisplay = true
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
        if let context = NSGraphicsContext.current()
        {
            let cg = context.cgContext
            
            cg.setFillColor(red: 0.3, green: 0.0, blue: 0.3, alpha: 1.0)
            let rect = CGRect(x: 0.0, y: 0.0, width: self.frame.width, height: self.frame.height)
            cg.fill(rect)
            
            
            
            let pumpkinHandle = CGRect(x: self.frame.width/2.0 - 10.0, y: self.frame.height/2.0 + 80.0, width: 20.0, height: 40.0)
            cg.setFillColor(red: 0.35, green: 0.25, blue: 0.0, alpha: 1.0)
            cg.fill(pumpkinHandle)
            
            let shadowSize1 = CGSize(width: 0.0, height: -3.0)
            let shadowSize2 = CGSize(width: -3.0, height: -3.0)
            let shadowColor = CGColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.85)
            cg.setShadow(offset: shadowSize2, blur: 1.0, color: shadowColor)
            
            // *** Pumpkin drawing ***
            let circleRect = CGRect(x: self.frame.width/2.0 - 100.0, y: self.frame.height/2.0 - 100.0, width: 200.0, height: 200.0)
            let leftSidePumpkin = CGRect(x: self.frame.width/2.0 - 130.0, y: self.frame.height/2.0 - 90.0, width: 120.0, height: 180.0)
            let rightSidePumpkin = CGRect(x: self.frame.width/2.0 + 10.0, y: self.frame.height/2.0 - 90.0, width: 120.0, height: 180.0)
            let middlePumpkin = CGRect(x: self.frame.width/2.0 - 45.0, y: self.frame.height/2.0 - 100.0, width: 90.0, height: 200.0)
            cg.setFillColor(red: 0.8, green: 0.4, blue: 0.0, alpha: 1.0)
            cg.fillEllipse(in: leftSidePumpkin)
            cg.fillEllipse(in: rightSidePumpkin)
            cg.setShadow(offset: shadowSize1, blur: 1.0, color: nil)
            cg.setLineWidth(3.0)
            cg.setStrokeColor(red: 0.75, green: 0.3, blue: 0.0, alpha: 1.0)
            cg.strokeEllipse(in: leftSidePumpkin)
            cg.strokeEllipse(in: rightSidePumpkin)
            cg.setShadow(offset: shadowSize1, blur: 1.0, color: shadowColor)
            cg.fillEllipse(in: circleRect)
            cg.setShadow(offset: shadowSize1, blur: 1.0, color: nil)
            cg.strokeEllipse(in: circleRect)
            cg.strokeEllipse(in: middlePumpkin)
            
            // *** Face carvings ***
            
            changeFace(cg: cg)
            
            cg.setFillColor(red: 0.3, green: 0.0, blue: 0.3, alpha: 1.0)
            let leftCover = CGRect(x: 0.0, y: self.frame.height/2.0 - 150.0, width: self.frame.width/2.0 - 140.0, height: 300.0)
            cg.fill(leftCover)
            let rightCover = CGRect(x: self.frame.width/2.0 + 140.0, y: self.frame.height/2.0 - 150.0, width: self.frame.width/2.0, height: 300.0)
            cg.fill(rightCover)
            
        }
    }

    
    func changeFace(cg: CGContext)
    {
        cg.saveGState()
        y = 0.0
        cg.translateBy(x: x, y: y)
        face1(cg: cg)
        face2(cg: cg)
        face3(cg: cg)
        cg.restoreGState()
    }
    
    func face1(cg: CGContext)
    {
        var i = 0
        if(i == colorSwitch)
        {
            cg.setStrokeColor(red: 0.6, green: 0.18, blue: 0.0, alpha: 1.0)
            cg.setFillColor(red: 0.6, green: 0.18, blue: 0.0, alpha: 1.0)
        }
        else
        {
            cg.setStrokeColor(red: 1.0, green: 0.8, blue: 0.0, alpha: 1.0)
            cg.setFillColor(red: 1.0, green: 0.8, blue: 0.0, alpha: 1.0)
        }
        
        let leftEye = NSBezierPath()
        leftEye.move(to: NSPoint(x: self.frame.width/2.0 - 55.0, y: self.frame.height/2.0 + 70.0))
        leftEye.line(to: NSPoint(x: self.frame.width/2.0 - 70.0, y: self.frame.height/2.0 + 40.0))
        leftEye.line(to: NSPoint(x: self.frame.width/2.0 - 40.0, y: self.frame.height/2.0 + 40.0))
        leftEye.line(to: NSPoint(x: self.frame.width/2.0 - 55.0, y: self.frame.height/2.0 + 70.0))
        leftEye.lineWidth = 18.0
        leftEye.stroke()
        
        let rightEye = NSBezierPath()
        rightEye.move(to: NSPoint(x: self.frame.width/2.0 + 55.0, y: self.frame.height/2.0 + 70.0))
        rightEye.line(to: NSPoint(x: self.frame.width/2.0 + 70.0, y: self.frame.height/2.0 + 40.0))
        rightEye.line(to: NSPoint(x: self.frame.width/2.0 + 40.0, y: self.frame.height/2.0 + 40.0))
        rightEye.line(to: NSPoint(x: self.frame.width/2.0 + 55.0, y: self.frame.height/2.0 + 70.0))
        rightEye.lineWidth = 18.0
        rightEye.stroke()
        
        let smileRect = CGRect(x: self.frame.width/2.0 - 60.0, y: self.frame.height/2.0 - 50.0, width: 120.0, height: 30.0)
        cg.fillEllipse(in: smileRect)
        
        let nose = CGRect(x: self.frame.width/2.0 - 10.0, y: self.frame.height/2.0 - 10.0, width: 20.0, height: 20.0)
        cg.fill(nose)
    }
    
    func face2(cg: CGContext)
    {
        cg.saveGState()
        cg.translateBy(x: 400.0, y: 0.0)
        if(colorSwitch == 0)
        {
            cg.setStrokeColor(red: 0.6, green: 0.18, blue: 0.0, alpha: 1.0)
            cg.setFillColor(red: 0.6, green: 0.18, blue: 0.0, alpha: 1.0)
        }
        if(colorSwitch == 1)
        {
            cg.setStrokeColor(red: 1.0, green: 0.8, blue: 0.0, alpha: 1.0)
            cg.setFillColor(red: 1.0, green: 0.8, blue: 0.0, alpha: 1.0)
        }
        
        let leftEyeRect = CGRect(x: self.frame.width/2.0 - 45.0, y: self.frame.height/2.0 + 40.0, width: 30.0, height: 30.0)
        cg.fillEllipse(in: leftEyeRect)
        let rightEyeRect = CGRect(x: self.frame.width/2.0 + 45.0, y: self.frame.height/2.0 + 40.0, width: 30.0, height: 30.0)
        cg.fillEllipse(in: rightEyeRect)
        let mouthRect = CGRect(x: self.frame.width/2.0 - 20.0, y: self.frame.height/2.0 - 50.0, width: 60.0, height: 90.0)
        cg.fillEllipse(in: mouthRect)
        
        cg.restoreGState()
    }
    
    func face3(cg: CGContext)
    {
        cg.saveGState()
        cg.translateBy(x: 800.0, y: 0.0)
        if(colorSwitch == 0)
        {
            cg.setStrokeColor(red: 0.6, green: 0.18, blue: 0.0, alpha: 1.0)
            cg.setFillColor(red: 0.6, green: 0.18, blue: 0.0, alpha: 1.0)
        }
        if(colorSwitch == 1)
        {
            cg.setStrokeColor(red: 1.0, green: 0.8, blue: 0.0, alpha: 1.0)
            cg.setFillColor(red: 1.0, green: 0.8, blue: 0.0, alpha: 1.0)
        }
        
        let leftEyeRect = CGRect(x: self.frame.width/2.0 - 45.0, y: self.frame.height/2.0 + 40.0, width: 30.0, height: 30.0)
        cg.fill(leftEyeRect)
        let rightEyeRect = CGRect(x: self.frame.width/2.0 + 45.0, y: self.frame.height/2.0 + 10.0, width: 30.0, height: 60.0)
        cg.fill(rightEyeRect)
        let mouthRect = CGRect(x: self.frame.width/2.0 - 70.0, y: self.frame.height/2.0 - 50.0, width: 140.0, height: 50.0)
        cg.fill(mouthRect)
        
        cg.setFillColor(red: 0.8, green: 0.4, blue: 0.0, alpha: 1.0)
        let toothRect1 = CGRect(x: self.frame.width/2.0 - 50.0, y: self.frame.height/2.0 - 53.0, width: 15.0, height: 15.0)
        cg.fill(toothRect1)
        let toothRect2 = CGRect(x: self.frame.width/2.0 + 10.0, y: self.frame.height/2.0 - 8.0, width: 15.0, height: 15.0)
        cg.fill(toothRect2)
        let toothRect3 = CGRect(x: self.frame.width/2.0 + 30.0, y: self.frame.height/2.0 - 53.0, width: 15.0, height: 15.0)
        cg.fill(toothRect3)
        
        cg.restoreGState()
    }
}





