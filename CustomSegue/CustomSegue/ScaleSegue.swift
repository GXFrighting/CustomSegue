//
//  DropSegue.swift
//  text
//
//  Created by Jiang on 2016/10/11.
//  Copyright © 2016年 softgarden. All rights reserved.
//

import UIKit

protocol ViewScaleable {
    var scaleView: UIView { get }
}

class ScaleSegue: UIStoryboardSegue {
    
    override func perform() {
        // 设置目标控制器的转场动画代理
        destination.transitioningDelegate = self
        super.perform()
    }
}

// MARK: UIViewControllerTransitioningDelegate
extension ScaleSegue: UIViewControllerTransitioningDelegate {
    
    // 返回自定义present动画对象
    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController)
        -> UIViewControllerAnimatedTransitioning? {
        
        return ScalePersentAnimator()
    }
    
    // 返回自定义dismiss动画对象
    func animationController(forDismissed dismissed: UIViewController)
        -> UIViewControllerAnimatedTransitioning? {
        
        return ScaleDismissedAnimator()
    }
}

// MARK: PersentAnimator
class ScalePersentAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    // 转场动画
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        // 1. 获取目标控制器
        let toViewController = transitionContext.viewController(forKey: .to)!
        var fromViewController = transitionContext.viewController(forKey: .from)!
        
        if let fromNC = fromViewController as? UINavigationController {
            if let controller = fromNC.topViewController {
                fromViewController = controller
            }
        }
        
        let toView = transitionContext.view(forKey: .to)
        let fromView = transitionContext.view(forKey: .from)
        
        // 2.添加toView到上下文中
        if let toView = toView {
            transitionContext.containerView.addSubview(toView)
        }
        
        // 3.设置toView的初始化位置
        var startFrame = CGRect.zero
        if let scaleView = fromViewController as? ViewScaleable {
            startFrame = scaleView.scaleView.frame
        }
        toView?.frame = startFrame
        toView?.layoutIfNeeded()
        
        // 4.设置动画
        let duration = transitionDuration(using: transitionContext)
        let finalFrame = transitionContext.finalFrame(for: toViewController)
        
        UIView.animate(withDuration: duration, animations: {
            toView?.frame = finalFrame
            toView?.layoutIfNeeded()
            fromView?.alpha = 0
        }) { (finished) in
            fromView?.alpha = 1
            // 动画结束一定要告诉transitionContext完成转场
            transitionContext.completeTransition(true)
        }
    }

    // 转场动画持续时间
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
}

// MARK: DismissedAnimator
class ScaleDismissedAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    // 转场动画
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        // 1.获取控制器
        var toViewController = transitionContext.viewController(forKey: .to)!
        
        if let toNC = toViewController as? UINavigationController {
            if let controller = toNC.topViewController {
                toViewController = controller
            }
        }
        
        let toView = transitionContext.view(forKey: .to)
        let fromView = transitionContext.view(forKey: .from)
        
        // 2.添加到上下文里
        if let toView = toView, let fromView = fromView {
            
            transitionContext.containerView.insertSubview(toView, belowSubview: fromView)
        }
        
        // 3.设置初始化属性
        var finishFrame = CGRect.zero
        if let scaleView = toViewController as? ViewScaleable {
            finishFrame = scaleView.scaleView.frame
        }
        toView?.alpha = 0
        
        // 4.设置动画
        let duration = transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: duration, animations: {
            
            fromView?.frame = finishFrame
            fromView?.layoutIfNeeded()
            toView?.alpha = 1
            
            }) { (finished) in
                transitionContext.completeTransition(true)
        }
    }
    
    // 转场动画持续时间
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
}
