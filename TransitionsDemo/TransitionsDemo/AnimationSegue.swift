//
//  TransitionSegue.swift
//  TransitionsDemo
//
//  Created by Gabriel Lanata on 13/8/18.
//  Copyright © 2018 Gabriel Lanata. All rights reserved.
//

import UIKit

struct TransitionAnimation {
    
    enum Style {
        case fade, top, bottom, left, right, match(String)
    }
    var style: Style = .fade
    var start: TimeInterval = 0
    var duration: TimeInterval = 0.5
    
    init(style: Style, start: TimeInterval, duration: TimeInterval) {
        self.style = style
        self.start = start
        self.duration = duration
    }
    
    fileprivate weak var matchedView: UIView? = nil
    
}

extension TransitionAnimation {
    
    fileprivate func prepareClosure(view: UIView, isEntering: Bool) -> (() -> Void) {
        return { () -> Void in
            let window = UIApplication.shared.keyWindow!
            switch self.style {
            case .fade:
                view.alpha = (isEntering ? 0 : 1)
            case .top, .bottom, .left, .right:
                if isEntering {
                    let toRect = view.superview!.convert(view.frame, to: window)
                    switch self.style {
                    case .top:
                        view.transform = CGAffineTransform(translationX: 0, y: (-toRect.maxY)-toRect.minY)
                    case .bottom:
                        view.transform = CGAffineTransform(translationX: 0, y: window.frame.maxY-toRect.minY)
                    case .left:
                        view.transform = CGAffineTransform(translationX: (-toRect.maxX)-toRect.minX, y: 0)
                    case .right:
                        view.transform = CGAffineTransform(translationX: window.frame.maxX-toRect.minX, y: 0)
                    default: fatalError()
                    }
                }
            case .match:
                if let matchedView = self.matchedView {
                    if isEntering {
                        let toRect = view.superview!.convert(view.frame, to: window)
                        let fromRect = matchedView.superview!.convert(matchedView.frame, to: window)
                        var transform = CGAffineTransform.identity
                        transform = transform.translatedBy(x: fromRect.midX-toRect.midX, y: fromRect.midY-toRect.midY)
                        transform = transform.scaledBy(x: fromRect.width/toRect.width, y: fromRect.height/toRect.height)
                        view.transform = transform
                        view.alpha = 0
                    }
                }
            }
        }
    }
    
    fileprivate func animationClosure(view: UIView, isEntering: Bool) -> (() -> Void) {
        return { () -> Void in
            let window = UIApplication.shared.keyWindow!
            switch self.style {
            case .fade:
                view.alpha = (isEntering ? 1 : 0)
            case .top, .bottom, .left, .right:
                if isEntering {
                    view.transform = CGAffineTransform.identity
                } else {
                    let fromRect = view.superview!.convert(view.frame, to: window)
                    switch self.style {
                    case .top:
                        view.transform = CGAffineTransform(translationX: 0, y: (-fromRect.maxY)-fromRect.minY)
                    case .bottom:
                        view.transform = CGAffineTransform(translationX: 0, y: window.frame.maxY-fromRect.minY)
                    case .left:
                        view.transform = CGAffineTransform(translationX: (-fromRect.maxX)-fromRect.minX, y: 0)
                    case .right:
                        view.transform = CGAffineTransform(translationX: window.frame.maxX-fromRect.minX, y: 0)
                    default: fatalError()
                    }
                }
            case .match:
                if let matchedView = self.matchedView {
                    if isEntering {
                        view.transform = CGAffineTransform.identity
                        view.alpha = 1
                    } else {
                        let fromRect = view.superview!.convert(view.frame, to: window)
                        let toRect = matchedView.superview!.convert(matchedView.frame, to: window)
                        var transform = CGAffineTransform.identity
                        transform = transform.translatedBy(x: toRect.midX-fromRect.midX, y: toRect.midY-fromRect.midY)
                        transform = transform.scaledBy(x: toRect.width/fromRect.width, y: toRect.height/fromRect.height)
                        view.transform = transform
                        view.alpha = 0
                    }
                }
            }
        }
    }
    
}

extension UIView {
    
    private static var _transitions: [Int : TransitionAnimation] = [:]
    
    var transition: TransitionAnimation? {
        get { return UIView._transitions[self.hash] }
        set { UIView._transitions[self.hash] = newValue }
    }
    
    func getViewsWithTransition() -> [UIView] {
        let allSubviews = getAllSubviews()
        let viewsWithTransition = allSubviews.filter { subview -> Bool in
            return (subview.transition != nil)
        }
        return viewsWithTransition
    }
    
    func getAllSubviews() -> [UIView] {
        var allSubviews: [UIView] = subviews
        for subview in subviews {
            allSubviews += subview.getAllSubviews()
        }
        return allSubviews
    }
    
}

class AnimationSegue: UIStoryboardSegue {
    
    open override func perform() {
        
        // Assign the source and destination views to local variables.
        let sourceView = self.source.view!
        let destinationView = self.destination.view!
        
        // Specify the initial position of the destination view.
        destinationView.frame = sourceView.frame
        
        // Save the destination background color
        let destinationBackgroundColor = destinationView.backgroundColor
        destinationView.backgroundColor = .clear
        
        // Access the app's key window and insert the destination view above the current (source) one.
        let window = UIApplication.shared.keyWindow
        window?.insertSubview(destinationView, aboveSubview: sourceView)
        destinationView.layoutIfNeeded()
        
        // Get views that have transitions
        let sourceViewsWithTransition = sourceView.getViewsWithTransition()
        let destinationViewsWithTransition = destinationView.getViewsWithTransition()
        let allViewsWithTransition = sourceViewsWithTransition + destinationViewsWithTransition
        
        // Get total duration of animations
        let totalDuration: TimeInterval = allViewsWithTransition.reduce(0) { (result, view) -> TimeInterval in
            return max(result, view.transition!.start+view.transition!.duration)
        }
        
        // Get matched views by grouping identifier
        var matchedViews: [String: UIView] = [:]
        for viewWithTransition in sourceViewsWithTransition {
            if case .match(let identifier) = viewWithTransition.transition!.style {
                matchedViews[identifier] = viewWithTransition
            }
        }
        for viewWithTransition in destinationViewsWithTransition {
            if case .match(let identifier) = viewWithTransition.transition!.style {
                if let matchedView = matchedViews[identifier] {
                    matchedView.transition!.matchedView = viewWithTransition
                    viewWithTransition.transition!.matchedView = matchedView
                }
            }
        }
        
        // Prepare views
        for viewWithTransition in sourceViewsWithTransition {
            let transition = viewWithTransition.transition!
            transition.prepareClosure(view: viewWithTransition, isEntering: false)()
        }
        for viewWithTransition in destinationViewsWithTransition {
            let transition = viewWithTransition.transition!
            transition.prepareClosure(view: viewWithTransition, isEntering: true)()
        }
        
        // Animate the transition.
        UIView.animateKeyframes(
            withDuration: totalDuration, delay: 0.0, options: [.beginFromCurrentState],
            animations: { () -> Void in
                for viewWithTransition in destinationViewsWithTransition {
                    let transition = viewWithTransition.transition!
                    UIView.addKeyframe(
                        withRelativeStartTime: transition.start/totalDuration,
                        relativeDuration: transition.duration/totalDuration,
                        animations: transition.animationClosure(view: viewWithTransition, isEntering: true)
                    )
                }
                for viewWithTransition in sourceViewsWithTransition {
                    let transition = viewWithTransition.transition!
                    UIView.addKeyframe(
                        withRelativeStartTime: transition.start/totalDuration,
                        relativeDuration: transition.duration/totalDuration,
                        animations: transition.animationClosure(view: viewWithTransition, isEntering: false)
                    )
                }
        },
            completion: { (Finished) -> Void in
                destinationView.backgroundColor = destinationBackgroundColor
                for viewWithTransition in allViewsWithTransition {
                    viewWithTransition.transform = CGAffineTransform.identity
                    viewWithTransition.alpha = 1
                }
                self.source.present(self.destination as UIViewController, animated: false, completion: nil)
        }
        )
    }
    
}







class CustomSegue: UIStoryboardSegue {
    
    open override func perform() {
        
        let sourceView = self.source.view
        let destinationView = self.destination.view
        
    }
    
}
