//
//  GettingStartedPagesVC.swift
//  OnBoardingApp
//
//  Created by Navnit Baldha on 31/05/20.
//  Copyright © 2020 Navneet Baldha. All rights reserved.
//

import UIKit
class GettingStartedPagesVC: UIViewController
{
    var pageIndex : Int = 0
    var imageName : String = ""
    var discriptiontext : String = ""
    var mTgettingStarted = TGettingStarted()

    @IBOutlet weak var discriptionLable: UILabel!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var imageView: UIImageView!
}

extension GettingStartedPagesVC: UIGestureRecognizerDelegate
{
    override func viewDidLoad()
    {
          super.viewDidLoad()
          view.layoutIfNeeded()
          imageView.image = UIImage(named: mTgettingStarted.imageName!)
          titleLable.text = mTgettingStarted.title
          discriptionLable.text = mTgettingStarted.descriptions
      }
}
