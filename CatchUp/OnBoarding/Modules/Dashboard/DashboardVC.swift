//
//  Dashboard.swift
//  CatchUp
//
//  Created by Navnit Baldha on 31/05/20.
//  Copyright © 2020 Navneet Baldha. All rights reserved.
//

import UIKit
import Koloda
import pop

class DashboardVC: UIViewController
{
    private let numberOfCards: Int = 5
    private let frameAnimationSpringBounciness: CGFloat = 9
    private let frameAnimationSpringSpeed: CGFloat = 16
    private let kolodaCountOfVisibleCards = 2
    private let kolodaAlphaValueSemiTransparent: CGFloat = 0.1
    @IBOutlet weak var kolodaView: CustomKolodaView!
    
    
    //MARK: IBActions
    @IBAction func leftButtonTapped() {
        kolodaView?.swipe(.left)
    }
    
    @IBAction func rightButtonTapped() {
        kolodaView?.swipe(.right)
    }
    
    @IBAction func undoButtonTapped() {
        kolodaView?.revertAction()
    }
    
    @IBAction func boostButton(_ sender: Any) {
        
//        let Push =  BoostVC()
//        self.navigationController?.pushViewController(Push, animated: true)
    }
    
    @IBAction func subscriptionButton(_ sender: Any) {

    }
}

extension DashboardVC
{
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        kolodaView.alphaValueSemiTransparent = kolodaAlphaValueSemiTransparent
        kolodaView.countOfVisibleCards = kolodaCountOfVisibleCards
        kolodaView.delegate = self
        kolodaView.dataSource = self
        kolodaView.animator = BackgroundKolodaAnimator(koloda: kolodaView)
        
        self.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal
    }
    
}

//MARK: KolodaViewDelegate
extension DashboardVC: KolodaViewDelegate {
    
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        kolodaView.resetCurrentCardIndex()
    }
    
    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
       
    }
    
    func kolodaShouldApplyAppearAnimation(_ koloda: KolodaView) -> Bool {
        return true
    }
    
    func kolodaShouldMoveBackgroundCard(_ koloda: KolodaView) -> Bool {
        return false
    }
    
    func kolodaShouldTransparentizeNextCard(_ koloda: KolodaView) -> Bool {
        return true
    }
    
    func koloda(kolodaBackgroundCardAnimation koloda: KolodaView) -> POPPropertyAnimation?
    {
        let animation = POPSpringAnimation(propertyNamed: kPOPViewFrame)
        animation?.springBounciness = frameAnimationSpringBounciness
        animation?.springSpeed = frameAnimationSpringSpeed
        return animation
    }
}

// MARK: KolodaViewDataSource
extension DashboardVC: KolodaViewDataSource {
    
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .default
    }
    
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        return numberOfCards
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        return UIImageView(image: UIImage(named: "cards_\(index + 1)"))
    }
    
    func koloda(_ koloda: KolodaView, viewForCardOverlayAt index: Int) -> OverlayView? {
        return Bundle.main.loadNibNamed("CustomOverlayView", owner: self, options: nil)?[0] as? OverlayView
    }
}
