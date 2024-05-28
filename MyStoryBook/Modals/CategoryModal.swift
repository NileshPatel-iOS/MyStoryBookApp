//
//  CategoryModal.swift
//  MyStoryBook
//
//  Created by nilesh.patel on 27/05/24.
//

import Foundation

var categoryId = 1

class CategroyModal: Codable {
    
    let id: Int
    let categoryName: String
    var stories : [StoryModal] = []
    
    init(categoryName: String) {
        self.id = categoryId
        self.categoryName = categoryName
        
        categoryId += 1
    }
    
}
