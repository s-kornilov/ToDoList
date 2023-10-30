//
//  InfoView.swift
//  ToDoList
//
//  Created by Sergei Kornilov on 28/041/2023.
//

import UIKit

class InfoView: UIView {
    
    //MARK: Set UI elements
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.toAutoLayout()
        scrollView.isScrollEnabled = true
        scrollView.backgroundColor = .white
        scrollView.indicatorStyle = .black
        return scrollView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.text = "Lorem Ipsum"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    let textView: UITextView = {
        let textView = UITextView()
        textView.toAutoLayout()
        textView.isScrollEnabled = false
        textView.text = defaultInfoText
        textView.font = .systemFont(ofSize: 17)
        return textView
    }()
    
    //MARK: Init
    init() {
        super.init(frame: .zero)
        scrollView.toAutoLayout()
        scrollView.addSubviews(titleLabel, textView)
        addSubview(scrollView)
        //scrollView.backgroundColor = .orange
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Set constraint
    func setConstraint() {
        [scrollView.topAnchor.constraint(equalTo: topAnchor),
         scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
         scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
         scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
         
         titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 22),
         titleLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
         titleLabel.widthAnchor.constraint(equalToConstant: 218),
         titleLabel.heightAnchor.constraint(equalToConstant: 24),
         
         textView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 62),
         textView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16),
         textView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
         textView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32),
        ].forEach({$0.isActive = true})
    }
}

