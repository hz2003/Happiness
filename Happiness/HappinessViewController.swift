//
//  HappinessViewController.swift
//  Happiness
//
//  Created by He Zhe on 15-05-01.
//  Copyright (c) 2015 HZ. All rights reserved.
//

import UIKit

class HappinessViewController: UIViewController, FaceViewDataSource{
    
    @IBOutlet weak var faceView: FaceView! {
        didSet {
            faceView.dataSource = self
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView, action: "scale:"))
//            faceView.addGestureRecognizer(UIPanGestureRecognizer(target: faceView, action: "changeHappiness:"))
        }
    }
    
    var happiness: Int = 0 { // 0 = very sad, 100 = ecstatiic
        didSet {
            happiness = min(max(happiness, 0), 100)
            println("happiness = \(happiness)")
            updateUI()
        }
    }

    private struct Constants {
        static let HappinessGestureScale: CGFloat = 1
    }
    @IBAction func changeHappiness(gesture: UIPanGestureRecognizer){
        println("gesture translation \(gesture.translationInView(faceView))")
        println("gesture state \(gesture.state)")
        switch gesture.state {
        case .Ended: fallthrough
        case .Changed:
            let translation = gesture.translationInView(faceView)
            let happinessChange = -Int(translation.y / Constants.HappinessGestureScale)
            if happinessChange != 0 {
                happiness += happinessChange
                gesture.setTranslation(CGPointZero, inView: faceView)
            }
        default: break
        }
    }
    
    func updateUI() {
        faceView.setNeedsDisplay()
    }
    
    func smilinessForFaceView(sender: FaceView) -> Double? {
        return Double(happiness - 50) / 50
    }
    
}
