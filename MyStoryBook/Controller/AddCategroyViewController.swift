//
//  AddCategroyViewController.swift
//  MyStoryBook
//
//  Created by nilesh.patel on 27/05/24.
//

import UIKit

class AddCategroyViewController: BaseViewController {

    @IBOutlet var txtCategoryName: UITextField!
    
    var blockActionHandler:(() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
    }
    
    private func setupUI() {
        self.title = "Add Category"
    }
    
    @IBAction func btnSaveActionHandler(sender: UIBarButtonItem) {
        guard let cateogryName = txtCategoryName.text, cateogryName != "" else {
            showAlert(withTitle: "MyStoryBool", withMessage: "Enter category name")
            return
        }
        
        let res = appDelegate().arrCategories.contains(where: { $0.categoryName == cateogryName })
        if res == false {
            let category = CategroyModal.init(categoryName: cateogryName)
            appDelegate().arrCategories.append(category)
            
            do {
                let encodeData = try JSONEncoder().encode(appDelegate().arrCategories)
                UserDefaults.standard.set(encodeData, forKey: "Categories")
                // synchronize is not needed
            } catch { print(error) }
            
            
            if self.blockActionHandler != nil {
                self.blockActionHandler!()
            }
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
