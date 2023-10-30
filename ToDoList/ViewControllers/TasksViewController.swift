//
//  TasksViewController.swift
//  ToDoList
//
//  Created by Sergei Kornilov on 28/04/2023.
//

import UIKit

class TasksViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, CustomCollectionViewCellDelegate {
    var taskBase = TaskBase(tasks: [])
    
    let addNewTaskVC = AddNewTaskViewController()
    
    static let layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layout.sectionInsetReference = .fromContentInset
        return layout
    }()
    
    static let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: TasksViewController.layout)
        collectionView.toAutoLayout()
        collectionView.backgroundColor = .systemGray6
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TasksViewController.collectionView.register(TasksCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        
        TasksViewController.collectionView.dataSource = self
        TasksViewController.collectionView.delegate = self
        view.addSubview(TasksViewController.collectionView)
        
        //Set addTask button
        let addNewTaskButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewTaskButtonTapped))
        navigationItem.rightBarButtonItem = addNewTaskButton
        
        useConstraint()
    }
    
    //MARK: Set constraint
    func useConstraint() {
        [TasksViewController.collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
         TasksViewController.collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
         TasksViewController.collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
         TasksViewController.collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ].forEach({$0.isActive = true})
    }
    
    //MARK: Event processing functions
    @objc func addNewTaskButtonTapped() {
        let addNewTaskViewController = AddNewTaskViewController()
        let targetPresentVC = UINavigationController(rootViewController: addNewTaskViewController)
        present(targetPresentVC, animated: true, completion: nil)
    }
    
    func taskChecked(at indexPath: IndexPath) {
        if taskBase.tasks[indexPath.row].isCompleted == false {
            taskBase.tasks[indexPath.row].isCompleted = true
        }else {
            taskBase.tasks[indexPath.row].isCompleted = false
        }
        print(taskBase.tasks[indexPath.item])
        taskBase.saveDatabase()
        TasksViewController.collectionView.reloadItems(at: [indexPath])
    }
    
    func taskEditButtonTapped(at indexPath: IndexPath) {
        taskBase.tasks.remove(at: indexPath.item)
        print(taskBase.tasks[indexPath.item])
        taskBase.saveDatabase()
        TasksViewController.collectionView.reloadData()
    }
    
}

extension TasksViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        taskBase.loadDatabase()
        return taskBase.tasks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! TasksCollectionViewCell
        let data = taskBase.tasks[indexPath.item]
        cell.delegate = self
        cell.indexPath = indexPath
        cell.configure(with: data)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0 {
            return CGSize(width: collectionView.frame.width - (16 * 2), height: 90)
        } else {
            return CGSize(width: collectionView.frame.width - (16 * 2), height: 90)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, canEditItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
}


