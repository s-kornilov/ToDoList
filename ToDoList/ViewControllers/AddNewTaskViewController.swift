//
//  AddEventViewController.swift
//  ToDoList
//
//  Created by Sergei Kornilov on 28/04/2023.
//

import UIKit

class AddNewTaskViewController: UIViewController {
    
    let addNewTask = AddNewTask()
    var taskModel = TaskBase(tasks: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNewTask.toAutoLayout()
        view.addSubview(addNewTask)
        view.backgroundColor = .white
        addNewTask.datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        // Setup constraint
        setConstraint()
        
        // Setup navigation bar
        setupNavigationBar()
    }
    
    //MARK: Set constraint
    func setConstraint() {
        [addNewTask.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
         addNewTask.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
         addNewTask.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
         addNewTask.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ].forEach({$0.isActive = true})
    }
    
    func setupNavigationBar() {
        navigationItem.title = "Add new task"
        let taskSaveButton = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(tapSaveButon))
        navigationItem.rightBarButtonItem = taskSaveButton
        let taskCancelButton = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(taskCancelButtonTap))
        navigationItem.leftBarButtonItem = taskCancelButton
    }
    
    @objc func taskCancelButtonTap() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func tapSaveButon() {
        saveData()
    }
    
    @objc func datePickerValueChanged() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        addNewTask.dateTextField.text = dateFormatter.string(from: addNewTask.datePicker.date)
    }
    
    func saveData() {
        taskModel.loadDatabase()
        taskModel.tasks.append(TaskItem(name: addNewTask.nameTextField.text!, date: addNewTask.datePicker.date))
        taskModel.saveDatabase()
        TasksViewController.collectionView.reloadData()
        self.dismiss(animated: true, completion: nil)
    }
    
}
