//
//  File.swift
//  Freshman Task 1
//
//  Created by MacsedProtoss on 2018/11/15.
//  Copyright © 2018 MacsedProtoss. All rights reserved.
//

import UIKit

class AnimationTransition : NSObject{
    var duration = 0.5
    var whiteView = UIView()
    enum transitionMod : Int{
        case present,dismiss,pop
    }
    var mode = transitionMod.present
    var startingPoint = CGPoint.zero{
        didSet{
           whiteView.center = startingPoint
        }

    }
}

extension AnimationTransition:UIViewControllerAnimatedTransitioning{
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if (mode == .present) {
            let containerView = transitionContext.containerView
            if let presentingView = transitionContext.view(forKey: UITransitionContextViewKey.to){
                //whiteView Setup
                let width = CGFloat(presentingView.frame.width/7-8)
                let height = CGFloat(40)
                whiteView.frame = CGRect(x: startingPoint.x, y: startingPoint.y, width: width, height: height)
                whiteView.layer.cornerRadius = 5
                whiteView.backgroundColor = UIColor.white
                whiteView.alpha = 0.75
                
                //
                
                containerView.addSubview(whiteView)
                presentingView.alpha = 0
                containerView.addSubview(presentingView)
                UIView.animate(withDuration: duration, animations: {
                    self.whiteView.transform = CGAffineTransform(scaleX: 15, y: 40)
                    presentingView.alpha = 1
                }, completion: {(success : Bool) in
                    transitionContext.completeTransition(success)
                    self.whiteView.removeFromSuperview()
                    })
            }
                
        }else if (mode == .pop){
            let containerView = transitionContext.containerView
            if let returningView = transitionContext.view(forKey: UITransitionContextViewKey.to){
                //presentedView Setup
                let presentedView = transitionContext.view(forKey: UITransitionContextViewKey.from)
                presentedView?.layer.cornerRadius = 5
                presentedView?.alpha = 0.8
                //presentedView?.backgroundColor = UIColor.white
                //
                
                
                containerView.addSubview(presentedView!)
                returningView.alpha = 0
                containerView.addSubview(returningView)
                UIView.animate(withDuration: duration, animations: {
                    presentedView?.transform = CGAffineTransform(scaleX: 1/10, y: 1/30)
                    presentedView?.center = CGPoint(x: self.startingPoint.x+20, y: self.startingPoint.y)
                    returningView.alpha = 1
                }, completion: {(success : Bool) in
                    transitionContext.completeTransition(success)
                    presentedView?.removeFromSuperview()
                })
            
            
            
            }
        }
    }
    
    



}





/*
class Rectangle : NSObject {
    
    var rectangle = UIView()
    
    var startingPoint = CGPoint.zero{
        didSet{
            rectangle.center = startingPoint
        }
    }
    
    var rectangleColor = UIColor.white
    
    var duration = 0.6
    
    enum RectangleTransitionMod :Int {
        case present,dismiss,pop
    }
    
    var transitionMode : RectangleTransitionMod = .present
}

extension Rectangle:UIViewControllerAnimatedTransitioning{
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        if transitionMode == .present {
            if let presentView = transitionContext.view(forKey: UITransitionContextViewKey.to){
                let viewCenter = presentView.center
                let viewSize = presentView.frame.size
                
                rectangle = UIView()
                rectangle.frame = frameForRectangle(viewCenter: viewCenter, viewSize: viewSize, startPoint: startingPoint)
                rectangle.layer.cornerRadius = rectangle.frame.size.height/4
                rectangle.backgroundColor = rectangleColor
                rectangle.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                containerView.addSubview(rectangle)
                
                presentView.center = startingPoint
                presentView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                presentView.alpha = 0
                containerView.addSubview(presentView)
                
                UIView.animate(withDuration: duration, animations: {
                    self.rectangle.transform = CGAffineTransform.identity
                    presentView.transform = CGAffineTransform.identity
                    presentView.alpha = 1
                    presentView.center = viewCenter
                }, completion: { (success:Bool) in
                    transitionContext.completeTransition(success)
                })
            }
        }else{
            let transitionModeKey = (transitionMode == .pop) ? UITransitionContextViewKey.to : UITransitionContextViewKey.from
            if let returningView = transitionContext.view(forKey: transitionModeKey){
                
                let formerView = transitionContext.view(forKey: UITransitionContextViewKey.from)!
                    let viewCenter = returningView.center
                    let viewSize = returningView.frame.size
                
                    rectangle.frame = frameForRectangle(viewCenter: viewCenter, viewSize: viewSize, startPoint: startingPoint)
                    rectangle.layer.cornerRadius = returningView.frame.height / 4
                    rectangle.center = startingPoint
                
                    UIView.animate(withDuration: duration, animations: {
                        self.rectangle.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                        returningView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                        returningView.center = self.startingPoint
                        returningView.alpha = 1
                    
                        if self.transitionMode == .pop{
                            containerView.insertSubview(formerView, belowSubview: formerView)
                            containerView.insertSubview(returningView, belowSubview: formerView)
                            containerView.insertSubview(self.rectangle, belowSubview: returningView)
                        }
                    
                    }, completion: { (success:Bool) in
                        returningView.center = viewCenter
                        returningView.removeFromSuperview()
                        self.rectangle.removeFromSuperview()
                        transitionContext.completeTransition(success)
                    })
                
            }
            
            
        }
    }
    
    func frameForRectangle (viewCenter : CGPoint,viewSize : CGSize,startPoint :CGPoint) -> CGRect {
        let xLength = fmax(startPoint.x, viewSize.width - startPoint.x)
        let yLength = fmax(startPoint.y, viewSize.height - startPoint.y)
        
        let offesVector = sqrt(xLength*xLength + yLength*yLength)*2
        let size = CGSize(width: offesVector, height: offesVector)
        return CGRect(origin: CGPoint.zero, size: size)
    }
  
}

*/












/*
class CircularTransition: NSObject {
    
    var circle = UIView()
    
    var startingPoint = CGPoint.zero {
        didSet {
            circle.center = startingPoint
        }
    }
    
    var circleColor = UIColor.white
    
    var duration = 0.6
    
    enum CircularTransitionMode:Int {
        case present, dismiss, pop
    }
    
    var transitionMode:CircularTransitionMode = .present
    
}

extension CircularTransition:UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        if transitionMode == .present {
            if let presentedView = transitionContext.view(forKey: UITransitionContextViewKey.to) {
                let viewCenter = presentedView.center
                let viewSize = presentedView.frame.size
                
                circle = UIView()
                
                circle.frame = frameForCircle(withViewCenter: viewCenter, size: viewSize, startPoint: startingPoint)
                
                circle.layer.cornerRadius = circle.frame.size.height / 4
                circle.center = startingPoint
                circle.backgroundColor = circleColor
                circle.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                containerView.addSubview(circle)
                
                
                presentedView.center = startingPoint
                presentedView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                presentedView.alpha = 0
                containerView.addSubview(presentedView)
                
                UIView.animate(withDuration: duration, animations: {
                    self.circle.transform = CGAffineTransform.identity
                    presentedView.transform = CGAffineTransform.identity
                    presentedView.alpha = 1
                    presentedView.center = viewCenter
                    
                }, completion: { (success:Bool) in
                    transitionContext.completeTransition(success)
                })
            }
            
        }else{
            let transitionModeKey = (transitionMode == .pop) ? UITransitionContextViewKey.to : UITransitionContextViewKey.from
            
            if let returningView = transitionContext.view(forKey: transitionModeKey) {
                let viewCenter = returningView.center
                let viewSize = returningView.frame.size
                
                
                circle.frame = frameForCircle(withViewCenter: viewCenter, size: viewSize, startPoint: startingPoint)
                
                circle.layer.cornerRadius = circle.frame.size.height / 4
                circle.center = startingPoint
                
                UIView.animate(withDuration: duration, animations: {
                    self.circle.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                    returningView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                    returningView.center = self.startingPoint
                    returningView.alpha = 0
                    
                    if self.transitionMode == .pop {
                        containerView.insertSubview(self.circle, belowSubview: self.circle)
                        containerView.insertSubview(returningView, belowSubview: self.circle)
                    }
                    
                    
                }, completion: { (success:Bool) in
                    returningView.center = viewCenter
                    returningView.removeFromSuperview()
                    
                    //self.circle.removeFromSuperview()
                    
                    transitionContext.completeTransition(success)
                    
                })
                
            }
            
            
        }
        
    }
    

    
    func frameForCircle (withViewCenter viewCenter:CGPoint, size viewSize:CGSize, startPoint:CGPoint) -> CGRect {
        let xLength = fmax(startPoint.x, viewSize.width - startPoint.x)
        let yLength = fmax(startPoint.y, viewSize.height - startPoint.y)
        
        let offestVector = sqrt(xLength * xLength + yLength * yLength) * 2
        let size = CGSize(width: offestVector, height: offestVector)
        
        return CGRect(origin: CGPoint.zero, size: size)
    }
        
}


*/

