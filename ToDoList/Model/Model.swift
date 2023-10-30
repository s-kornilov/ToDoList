//
//  EventsController.swift
//  ToDoList
//
//  Created by Sergei Kornilov on 28/04/2023.
//

import Foundation

struct TaskItem: Codable {
    var name: String
    var date: Date?
    var isCompleted: Bool = false
}

protocol SaveTaskDelegate: AnyObject {
    func saveData()
}

protocol CustomCollectionViewCellDelegate: AnyObject {
    func taskChecked(at indexPath: IndexPath)
    func taskEditButtonTapped(at indexPath: IndexPath)
}

class TaskBase {
    public var tasks: [TaskItem] = []
    
    init(tasks: [TaskItem]) {
        self.tasks = tasks
    }

    func loadDatabase() {
        do {
            if let data = UserDefaults.standard.data(forKey: "database") {
            tasks = try JSONDecoder().decode([TaskItem].self, from: data)
            }
        } catch{
            print(error)
        }
    }
    
    func saveDatabase() {
        do {
            let data = try JSONEncoder().encode(tasks)
            UserDefaults.standard.set(data, forKey: "database")
            UserDefaults.standard.synchronize()
        } catch {
            print(error)
        }
    }
}
