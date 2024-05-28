//
//  AddStoryViewController.swift
//  MyStoryBook
//
//  Created by nilesh.patel on 27/05/24.
//

import UIKit

class AddStoryViewController: BaseViewController {
    
    @IBOutlet var txtTitle: UITextField!
    @IBOutlet var txtDate: UITextField!
    @IBOutlet var txtStoryDetail: UITextField!
    
    var isFromEdit: Bool = false
    var category: CategroyModal?
    var story: StoryModal?
    var datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
    }
    
    private func setupUI() {
        self.title = "Add Story Details"
        
        if isFromEdit == true {
            if let story = self.story {
                txtTitle.text = story.title
                txtDate.text = story.date
                txtStoryDetail.text = story.storyDetail
            }
        }
        
        showDatePicker()
    }
    
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        txtDate.inputAccessoryView = toolbar
        txtDate.inputView = datePicker
    }
    
    @objc func donedatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        txtDate.text = formatter.string(from: datePicker.date)
        txtDate.resignFirstResponder()
    }
    
    @objc func cancelDatePicker(){
        txtDate.resignFirstResponder()
    }
    
    
    @IBAction func btnSaveActionHandler(sender: UIBarButtonItem) {
        guard let storyTitle = txtTitle.text, storyTitle != "" else {
            showAlert(withTitle: "MyStoryBool", withMessage: "Please enter title")
            return
        }
        
        guard let date = txtDate.text, date != "" else {
            showAlert(withTitle: "MyStoryBook", withMessage: "Please select date")
            return
        }
        
        guard let storyDetail = txtStoryDetail.text, storyDetail != "" else {
            showAlert(withTitle: "MyStoryBook", withMessage: "Please enter story detail")
            return
        }
        
        if let category = self.category {
            let res = category.stories.contains(where: { $0.title == title })
            if res == false {
                if isFromEdit == true {
                    if let story = self.story {
                        story.title = storyTitle
                        story.date = date
                        story.storyDetail = storyDetail
                        
                        if let row = category.stories.firstIndex(where: {$0.id == story.id}) {
                            category.stories[row] = story
                        }
                    }
                } else {
                    let story = StoryModal.init(title: storyTitle, date: date, storyDetail: storyDetail)
                    category.stories.append(story)
                }
                
                
                do {
                    let encodeData = try JSONEncoder().encode(appDelegate().arrCategories)
                    UserDefaults.standard.set(encodeData, forKey: "Categories")
                    // synchronize is not needed
                } catch { print(error) }
                
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
    
    @IBAction func btnSelectDateActionHandler(_ sender: Any) {
        txtDate.becomeFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
