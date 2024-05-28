//
//  HomeViewController.swift
//  MyStoryBook
//
//  Created by nilesh.patel on 27/05/24.
//

import UIKit

class HomeViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
    }
    
    private func setupUI() {
        self.title = "Home Screen"
    }
    
    @IBAction func btnNextActionHandler(_sender: Any) {
        if let storyboard = self.storyboard {
            if let categroyListViewController = storyboard.instantiateViewController(withIdentifier:String.init(describing: CategroyListViewController.self)) as? CategroyListViewController {
                self.navigationController?.pushViewController(categroyListViewController, animated: true)
            }
        }
    }

}
