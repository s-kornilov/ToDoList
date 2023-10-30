//
//  InfoViewController.swift
//  ToDoList
//
//  Created by Sergei Kornilov on 28/04/2023.
//

import UIKit

class InfoViewController: UIViewController {
    
    let infoView = InfoView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        infoView.toAutoLayout()
        view.addSubview(infoView)
        setConstraint()
    }
    
    //MARK: Set constraint
    func setConstraint() {
        [infoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
         infoView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
         infoView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
         infoView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ].forEach({$0.isActive = true})
    }
}
