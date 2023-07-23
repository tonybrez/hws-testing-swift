//
//  User.swift
//  testing-swift
//
//  Created by Anthony Benitez-Rodriguez on 7/23/23.
//

import Foundation

class User {
    let name: String
    var projects: [Project] = []
    var outstandingTasksString: String {
        var result = 0
        for project in projects {
            result += project.items.count
        }
        return "\(result) items"
    }
    
    init(name: String) {
        self.name = name
    }
    
    func addProject(_ project: Project) {
        projects.append(project)
    }
}

class Project {
    let name: String
    var items: [ToDoItem] = []
    
    init(name: String) {
        self.name = name
    }
    
    func addItem(_ item: ToDoItem) {
        items.append(item)
    }
}

class ToDoItem {
    let name: String
    
    init(name: String) {
        self.name = name
    }
}
