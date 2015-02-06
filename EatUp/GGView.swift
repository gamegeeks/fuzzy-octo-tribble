//
//  GGView.swift
//  EatUp
//
//  Created by Jeff Ligon on 2/6/15.
//  Copyright (c) 2015 Visceral Origami LLC. All rights reserved.
//

import UIKit

class GGView: UIView {
    var draggableView :DraggableView!
    override init(){
        super.init()
        backgroundColor = UIColor.whiteColor()
        loadDraggableView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.whiteColor()
        loadDraggableView()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension GGView{
    func loadDraggableView(){
        self.draggableView = DraggableView(frame: CGRectMake(60, 60, 200, 260))
        addSubview(self.draggableView)
    }
}