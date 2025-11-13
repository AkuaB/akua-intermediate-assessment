//
//  Task.swift
//  ToDoWithWeather
//
//  Created by Akua Afrane-Okese on 2025/11/13.
//

import Foundation
import SwiftData

@Model
class TaskDetails {
    
    @Attribute(.unique) var id = UUID()
    var title: String
    var taskDescription: String
    var isCompleted = false
    
    init(title: String = "",
         taskDescription: String = "",
         isCompleted: Bool = false) {
        self.title = title
        self.taskDescription = taskDescription
        self.isCompleted = isCompleted
    }
}
