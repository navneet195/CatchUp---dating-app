//
//  GettingStartedSliderVC.swift
//  OnBoardingApp
//
//  Created by Navnit Baldha on 31/05/20.
//  Copyright © 2020 Navneet Baldha. All rights reserved.
//

import UIKit
class GettingStartedSliderVC: UIViewController
{
    @IBOutlet weak var containerVIew: UIView!
    var pageViewController : UIPageViewController?
    @IBOutlet weak var pageController: UIPageControl!
    var currentIndex : Int = 0
    var dataArray : NSMutableArray = []
    var viewControllers = [UIViewController]()
    
    func viewControllerAtIndex(_ index: Int) -> GettingStartedPagesVC?
    {
        if self.dataArray.count == 0 || index > self.dataArray.count || index < 0
        {
            return nil
        }
        
        // Create a new view controller and pass suitable data.
        let mGettingStartedPagesVC = GettingStartedPagesVC(nibName:Constants.gettingStartedPagesVC , bundle: nil)
        let mTgettingStarted : TGettingStarted = dataArray[index] as! TGettingStarted
        mGettingStartedPagesVC.mTgettingStarted = mTgettingStarted
        mGettingStartedPagesVC.pageIndex = index
        mGettingStartedPagesVC.view.tag = index
        currentIndex = index
        return mGettingStartedPagesVC
    }
    
    
}

extension GettingStartedSliderVC
{
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let mTgettingStarted1 = TGettingStarted()
        mTgettingStarted1.imageName = Constants.walkthrow_1_image_name
        mTgettingStarted1.title = Constants.walkthrow_1_title_txt
        mTgettingStarted1.descriptions = Constants.walkthrow_1_disc_txt
        
        dataArray.add(mTgettingStarted1)
        
        let mTgettingStarted2 = TGettingStarted()
        mTgettingStarted2.imageName = Constants.walkthrow_2_image_name
        mTgettingStarted2.title = Constants.walkthrow_2_title_txt
        mTgettingStarted2.descriptions = Constants.walkthrow_2_disc_txt
        
        dataArray.add(mTgettingStarted2)
        
        let mTgettingStarted3 = TGettingStarted()
        mTgettingStarted3.imageName = Constants.walkthrow_3_image_name
        mTgettingStarted3.title = Constants.walkthrow_3_title_txt
        mTgettingStarted3.descriptions = Constants.walkthrow_3_disc_txt
        
        dataArray.add(mTgettingStarted3)
        pageController.numberOfPages = dataArray.count
        
        self.loadPager()
    }
    
    func loadPager(){
        
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController!.dataSource = self
        pageViewController?.delegate = self
        let startingViewController: GettingStartedPagesVC = viewControllerAtIndex(0)!
        viewControllers = [startingViewController]
        pageViewController!.setViewControllers(viewControllers , direction: .forward, animated: false, completion: nil)
        pageViewController!.view.frame = CGRect(x: 0, y: 0, width: containerVIew.frame.size.width, height: containerVIew.frame.size.height);
        
        addChild(pageViewController!)
        containerVIew.addSubview(pageViewController!.view)
        pageViewController!.didMove(toParent: self)
        self.view.bringSubviewToFront(pageController)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


extension GettingStartedSliderVC: UIPageViewControllerDelegate, UIPageViewControllerDataSource
{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?
    {
        var index = (viewController as! GettingStartedPagesVC).pageIndex
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        index = index - 1
        return viewControllerAtIndex(index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?
    {
        var index = (viewController as! GettingStartedPagesVC).pageIndex
        
        if index == NSNotFound {
            return nil
        }
        
        index = index + 1
        
        if (index == self.dataArray.count) {
            return nil
        }
        
        return viewControllerAtIndex(index)
    }
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool)
    {
        guard completed else { return }
        pageController.currentPage = pageViewController.viewControllers!.first!.view.tag
    }
    
}
