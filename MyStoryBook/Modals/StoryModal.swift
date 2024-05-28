//
//  StoryModal.swift
//  MyStoryBook
//
//  Created by nilesh.patel on 27/05/24.
//

import Foundation

var storyId = 1

class StoryModal: Codable {
    
    let id: Int
    var title: String
    var date: String
    var storyDetail: String
    
    init(title: String, date: String, storyDetail: String) {
        self.id = storyId
        self.title = title
        self.date = date
        self.storyDetail = storyDetail
       
        storyId += 1
    }
}
