//
//  PayScreenPWProtocol.swift
//  payapp
//
//  Created by Georgy on 2025-07-09.
//

import UIKit

extension PayScreen: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(
        _ pvc: UIPageViewController,
        viewControllerBefore vc: UIViewController
    ) -> UIViewController? {
        guard let idx = slideControllers.firstIndex(of: vc), idx > 0 else { return nil }
        return slideControllers[idx - 1]
    }
    
    func pageViewController(
        _ pvc: UIPageViewController,
        viewControllerAfter vc: UIViewController
    ) -> UIViewController? {
        guard let idx = slideControllers.firstIndex(of: vc),
              idx < slideControllers.count - 1 else { return nil }
        return slideControllers[idx + 1]
    }
    
    func pageViewController(
        _ pvc: UIPageViewController,
        didFinishAnimating _: Bool,
        previousViewControllers _: [UIViewController],
        transitionCompleted completed: Bool
    ) {
        if completed, let current = pvc.viewControllers?.first,
           let idx = slideControllers.firstIndex(of: current) {
            pageControl.currentPage = idx
        }
    }
}
