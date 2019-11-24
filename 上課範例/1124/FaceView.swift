//
//  FaceView.swift
//  faceDetect1
//
//  Created by 徐國堂 on 2019/11/24.
//  Copyright © 2019 徐國堂. All rights reserved.
//

import UIKit

class FaceView: UIView {

    /*
    override func draw(_ rect: CGRect) {
        let bezier = UIBezierPath(ovalIn: rect)
        UIColor.blue.setFill()
        bezier.fill()
    }
 */
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()!;
        var myRect = rect;
        myRect.origin = CGPoint(x:10,y:10)
        myRect.size = CGSize(width:30,height:30)
        context.addRect(myRect)
        context.setFillColor(UIColor.blue.cgColor)
        context.fillPath()
        
    }
    

}
