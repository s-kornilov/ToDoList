//
//  EventsCollectionViewCell.swift
//  ToDoList
//
//  Created by Sergei Kornilov on 28/04/2023.
//

import UIKit

class TasksCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: CustomCollectionViewCellDelegate?
    var indexPath: IndexPath?
    
    //MARK: Set UI elements
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.toAutoLayout()
        nameLabel.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        return nameLabel
    }()
    
    lazy var dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.toAutoLayout()
        dateLabel.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        return dateLabel
    }()
    
    let uncheckImage = UIImage(named: "icon-uncheckmark")
    let checkImage = UIImage(named: "icon-checkmark")
    
    lazy var checkmarkLabel: UIButton = {
        let checkmarkLabel = UIButton()
        checkmarkLabel.toAutoLayout()
        checkmarkLabel.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        return checkmarkLabel
    }()
    
    lazy var taskEditButton: UIButton = {
        let taskEditButton = UIButton()
        taskEditButton.toAutoLayout()
        taskEditButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        taskEditButton.setBackgroundImage(UIImage(named: "icon-menu-v"), for: .normal)
        taskEditButton.isHidden = true
        taskEditButton.backgroundColor = .red
        return taskEditButton
    }()
    
    //MARK: Init
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 8
        contentView.addSubviews(nameLabel, dateLabel, checkmarkLabel, taskEditButton)
        checkmarkLabel.addTarget(self, action: #selector(checkmarkLabelTapped), for: .touchUpInside)
        taskEditButton.addTarget(self, action: #selector(taskEditButtonTapped), for: .touchUpInside)
        let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeGestureRecognizer.direction = .left
        addGestureRecognizer(swipeGestureRecognizer)
        useConstraint()
    }
    
    func configure(with data: TaskItem) {
        nameLabel.text = data.name
        setDateFormat(date: data.date!)
        setCheckMark(checkMark: data.isCompleted)
    }
    
    //MARK: Set constraint
    func useConstraint() {
        [nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
         nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
         
         dateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
         dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
         
         checkmarkLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
         checkmarkLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
         
         taskEditButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
         taskEditButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
         
         
        ].forEach({$0.isActive = true})
    }
    
    //MARK: Set UI format date
    func setDateFormat(date: Date) {
        let currentDate = Date()
        let dateformat = DateFormatter()
        dateformat.locale = Locale(identifier: "ru_RU")
        dateformat.dateFormat = "dd MMMM yyyy"
        dateLabel.text = dateformat.string(from: date)
        if currentDate >= date {
            dateLabel.text = "Expired"
            checkmarkLabel.isEnabled = false
        }
    }
    
    //MARK: Set check marker
    func setCheckMark(checkMark: Bool) {
        if checkMark == true {
            checkmarkLabel.setBackgroundImage(checkImage, for: .normal)
        }else {
            checkmarkLabel.setBackgroundImage(uncheckImage, for: .normal)
        }
    }
    
    //MARK: Event processing functions
    @objc func checkmarkLabelTapped() {
        if let indexPath = indexPath {
            delegate?.taskChecked(at: indexPath)
        }
    }
    
    @objc func taskEditButtonTapped() {
        if let indexPath = indexPath {
            delegate?.taskEditButtonTapped(at: indexPath)
        }
    }
    
    @objc func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        print("work handle")
        // taskEditButton.isHidden = false
        if gesture.state == .changed || gesture.state == .ended {
            if gesture.direction == .left {
                // Пользователь смахнул ячейку влево
                checkmarkLabel.isHidden = true
                UIView.animate(withDuration: 0.3) {
                    // Показать кнопку "Удалить" с анимацией
                    self.taskEditButton.isHidden = false
                    self.taskEditButton.frame.origin.x = self.taskEditButton.frame.origin.x
                }
            }
        }
        
    }
    
}

