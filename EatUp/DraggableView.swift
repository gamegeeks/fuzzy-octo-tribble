//
//  DraggableView.swift
//  EatUp
//
//  Created by Jeff Ligon on 2/5/15.
//  Copyright (c) 2015 Visceral Origami LLC. All rights reserved.
//

import UIKit



class DraggableView: UIView {
    enum OverLayMode: Printable{
        case OverlayModeLeft
        case OverlayModeRight
        
        var description: String{
        switch self{
        case .OverlayModeRight: return "Right"
        case .OverlayModeLeft: return "Left"
            }
        }
    }
    var mode:OverLayMode!
    var imageView:UIImageView!
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        self.mode = OverLayMode.OverlayModeLeft
        
        backgroundColor = UIColor.whiteColor()
        var thumbDownImage:UIImage = UIImage(named: "ThumbDown")!
        imageView = UIImageView(image: thumbDownImage)
        addSubview(imageView)
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DraggableView{
    func setMode(mode: OverLayMode)->(){
        if self.mode == mode{
            return
        }
        if mode == OverLayMode.OverlayModeLeft{
            imageView.image = UIImage(named: "ThumbDown")
        }else{
            imageView.image = UIImage(named: "ThumbUp")
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = CGRectMake(50, 50, 100, 100)
    }
    
}