//
//  Login.swift
//  CatchUp
//
//  Created by Navnit Baldha on 31/05/20.
//  Copyright © 2020 Navneet Baldha. All rights reserved.
//

import UIKit
class Login: UIViewController
{
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var loignButton: UIButton!
    @IBAction func loginTapped(_ sender: Any)
    {
        let mainStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
        let dashboardVC = mainStoryboard.instantiateViewController(withIdentifier: "DashboardVC") as? DashboardVC
        self.navigationController?.pushViewController(dashboardVC!, animated: false)
    }
}

extension Login
{
    override func viewDidLoad() {
           super.viewDidLoad()
           // Do any additional setup after loading the view.
       }
}
