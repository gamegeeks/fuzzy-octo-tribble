//
//  OverlayView.swift
//  EatUp
//
//  Created by Jeff Ligon on 2/5/15.
//  Copyright (c) 2015 Visceral Origami LLC. All rights reserved.
//

import UIKit

class DraggableView : UIView{
    
    var panGestureRecognizer: UIPanGestureRecognizer!
    var originalPoint :CGPoint!
    var overlayView : OverlayView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "dragged:")
        panGestureRecognizer.delegate = self
        addGestureRecognizer(panGestureRecognizer)
        
        loadImageAndStyle()
        
        self.overlayView = OverlayView(frame: self.bounds)
        self.overlayView.alpha = 0
        addSubview(self.overlayView)
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit{
        removeGestureRecognizer(panGestureRecognizer)
    }
    
    @IBAction func dragged(gestureRecognizer:UIPanGestureRecognizer){
        let xDistance = gestureRecognizer.translationInView(self).x
        let yDistance = gestureRecognizer.translationInView(self).y
        switch(gestureRecognizer.state){
        case .Began:
            self.originalPoint = self.center
        case .Changed:
            let rotationStrength :CGFloat = min(xDistance / 320 , 1)
            let rotationAngel: CGFloat = (2.0 * CGFloat(M_PI) / 16.0 * rotationStrength)
            let scaleStrength: CGFloat = 1 - fabs(rotationStrength) / 4
            let scale :CGFloat = max(scaleStrength, 0.93)
            let transform :CGAffineTransform = CGAffineTransformMakeRotation(rotationAngel)
            let scaleTransform = CGAffineTransformScale(transform, scale,scale)
            self.transform = scaleTransform
            self.center = CGPointMake(originalPoint.x + xDistance, originalPoint.y + yDistance)
            updateOverlay(xDistance)
        case .Ended:
            resetViewPositionsAndTransformations()
            
        default: break
        }
    }
    
}

extension DraggableView : UIGestureRecognizerDelegate{
    
}

extension DraggableView{
    
    
    func loadImageAndStyle(){
        let imageView :UIImageView = UIImageView(image: UIImage(named: "bar"))
        addSubview(imageView)
        layer.cornerRadius = 8
        layer.shadowOffset = CGSizeMake(7,7)
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.5
    }
    
    func updateOverlay(distance:CGFloat){
        if distance > 0{
            overlayView.setMode(OverlayView.OverLayMode.OverlayModeRight)
        } else if distance <= 0 {
            overlayView.setMode(OverlayView.OverLayMode.OverlayModeLeft)
        }
        
        let leftSide : CGFloat = CGFloat( fabsf(Float(distance) / 100.0) )
        let overLayStrength :CGFloat = min( leftSide, 0.4)
        overlayView.alpha = overLayStrength
    }
        func resetViewPositionsAndTransformations(){
            UIView.animateWithDuration(0.2, animations: {
                self.center = self.originalPoint
                self.transform = CGAffineTransformMakeRotation(0.0)
                self.overlayView.alpha = 0;
            })
        }
}