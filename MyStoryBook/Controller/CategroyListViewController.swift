//
//  CategroyListViewController.swift
//  MyStoryBook
//
//  Created by nilesh.patel on 27/05/24.
//

import UIKit

class CategroyListViewController: BaseViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var lblNoDataFound : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
    }
    
    private func setupUI() {
        self.title = "Category List"
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.refreshTableViewUI()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(btnAddCategotyActionHandler))
    }
    
    private func refreshTableViewUI() {
        tableView.isHidden = appDelegate().arrCategories.count > 0 ? false : true
        lblNoDataFound.isHidden = appDelegate().arrCategories.count > 0 ? true : false
    }
    
    @objc func btnAddCategotyActionHandler(sender: UIBarButtonItem) {
        if let storyboard = self.storyboard {
            if let addCategroyViewController = storyboard.instantiateViewController(withIdentifier:String.init(describing: AddCategroyViewController.self)) as? AddCategroyViewController {
                addCategroyViewController.blockActionHandler = {
                    self.refreshTableViewUI()
                    self.tableView.reloadData()
                }
                self.navigationController?.pushViewController(addCategroyViewController, animated: true)
            }
        }
    }
    
}

extension CategroyListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appDelegate().arrCategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
            let cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
            var cellContext = cell.defaultContentConfiguration()
            cellContext.text = appDelegate().arrCategories[indexPath.row].categoryName
            cell.contentConfiguration = cellContext
            return cell
        }
        
        var cellContext = cell.defaultContentConfiguration()
        cellContext.text = appDelegate().arrCategories[indexPath.row].categoryName
        cell.contentConfiguration = cellContext
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let storyboard = self.storyboard {
            if let storyListViewController = storyboard.instantiateViewController(withIdentifier:String.init(describing: StoryListViewController.self)) as? StoryListViewController {
                storyListViewController.category = appDelegate().arrCategories[indexPath.row]
                self.navigationController?.pushViewController(storyListViewController, animated: true)
            }
        }
    }
}
