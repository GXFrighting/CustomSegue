//
//  PhotoViewController.swift
//  text
//
//  Created by Jiang on 2016/10/11.
//  Copyright © 2016年 softgarden. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, ViewScaleable {
    
    @IBOutlet var imageView: UIImageView!
    
    var scaleView: UIView {
        return imageView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func unwindToPhotoViewController(segue: UIStoryboardSegue) {
        
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "photoDetail" {
//            segue.destination.transitioningDelegate = self
//        }
//    }
}

//extension PhotoViewController: UIViewControllerTransitioningDelegate {
//    
//    func animationController(forPresented presented: UIViewController,
//                             presenting: UIViewController,
//                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        return ScalePresentAnimationController()
//    }
//    
//    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        
//        return ScaleDismissAnimationControllerScale()
//    }
//}
