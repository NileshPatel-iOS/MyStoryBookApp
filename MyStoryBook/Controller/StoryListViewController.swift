//
//  StoryListViewController.swift
//  MyStoryBook
//
//  Created by nilesh.patel on 27/05/24.
//

import UIKit

class StoryListViewController: BaseViewController {
    
    @IBOutlet var collectionView : UICollectionView!
    @IBOutlet var lblNoDataFound : UILabel!
    
    var category: CategroyModal?
    
    let reuseIdentifier = "storyCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
    }
    
    private func setupUI() {
        self.title = "Stories"
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        if let category = self.category {
            collectionView.isHidden = category.stories.count > 0 ? false : true
            lblNoDataFound.isHidden = category.stories.count > 0 ? true : false
        }
        
        // Register cell classes
        //collectionView.register(StoryCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        // Set background color
        collectionView.contentInset = UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)
        collectionView.backgroundColor = UIColor.clear
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(btnAddStoryDetailActionHandler))
    }
    
    @objc func btnAddStoryDetailActionHandler(sender: UIBarButtonItem) {
        self.redirectToAddStoryViewController(isFromEdit: false, story: nil)
    }
    
    func redirectToAddStoryViewController(isFromEdit: Bool, story: StoryModal?) {
        if let category = self.category {
            if let storyboard = self.storyboard {
                if let addStoryViewController = storyboard.instantiateViewController(withIdentifier:String.init(describing: AddStoryViewController.self)) as? AddStoryViewController {
                    addStoryViewController.category = category
                    addStoryViewController.isFromEdit = isFromEdit
                    addStoryViewController.story = story
                    self.navigationController?.pushViewController(addStoryViewController, animated: true)
                }
            }
        }
    }
}

// MARK: UICollectionViewDataSource
extension StoryListViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Return the number of sections
        if let category = category {
            return category.stories.count > 0 ? category.stories.count : 0
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Configure the cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! StoryCollectionViewCell
        cell.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        cell.editButton.tag = indexPath.item
        if let category = self.category {
            cell.title.text = category.stories[indexPath.item].title 
            cell.date.text = category.stories[indexPath.item].date
            cell.layer.cornerRadius = 10
            cell.layer.masksToBounds = true
            cell.blockEditActionHandler = { index in
                self.redirectToAddStoryViewController(isFromEdit: true, story: category.stories[index])
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  30
        let collectionViewSize = UIScreen.main.bounds.size.width - padding
          return CGSize(width: collectionViewSize/2, height: collectionViewSize/2)
    }
}

class StoryCollectionViewCell : UICollectionViewCell {
    
    @IBOutlet var title: UILabel!
    @IBOutlet var date: UILabel!
    @IBOutlet var editButton: UIButton!
    
    var blockEditActionHandler:((_ tag: Int) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func btnEditActionHandler(sender: UIButton) {
        if self.blockEditActionHandler != nil {
            self.blockEditActionHandler!(sender.tag)
        }
    }
}
