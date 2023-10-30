//
//  AddEventView.swift
//  ToDoList
//
//  Created by Sergei Kornilov on 28/04/2023.
//

import UIKit

class AddNewTask: UIView {
    
    //MARK: Set UI elements
    let nameTextFieldLabel: UILabel = {
        let nameTextFieldLabel = UILabel()
        nameTextFieldLabel.toAutoLayout()
        nameTextFieldLabel.text = "Input name of task"
        nameTextFieldLabel.font = .systemFont(ofSize: 14, weight: .regular)
        return nameTextFieldLabel
    }()
    
    let nameTextField: UITextField = {
        let nameTextField = UITextField()
        nameTextField.toAutoLayout()
        nameTextField.backgroundColor = .white
        nameTextField.layer.cornerRadius = 12
        nameTextField.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        nameTextField.textColor = .black
        nameTextField.borderStyle = .line
        
        return nameTextField
    }()
    
    let dateTextFieldLabel: UILabel = {
        let dateTextFieldLabel = UILabel()
        dateTextFieldLabel.toAutoLayout()
        dateTextFieldLabel.text = "Date of task: "
        dateTextFieldLabel.font = .systemFont(ofSize: 14, weight: .regular)
        return dateTextFieldLabel
    }()
    let dateTextField: UITextField = {
        let dateTextField = UITextField()
        dateTextField.toAutoLayout()
        dateTextField.backgroundColor = .white
        dateTextField.layer.cornerRadius = 12
        dateTextField.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        dateTextField.textColor = .black
        dateTextField.layer.borderWidth = 0
        dateTextField.borderStyle = .none
        dateTextField.textAlignment = .center
        dateTextField.isUserInteractionEnabled = false
        return dateTextField
    }()
    
    let datePickerLabel: UILabel = {
        let datePickerLabel = UILabel()
        datePickerLabel.toAutoLayout()
        datePickerLabel.text = "Select date: "
        datePickerLabel.font = .systemFont(ofSize: 14, weight: .regular)
        return datePickerLabel
    }()
    
    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        let currentDate = Date()
        datePicker.toAutoLayout()
        datePicker.minimumDate = Date()
        datePicker.maximumDate = Calendar.current.date(byAdding: .year, value: 1, to: Date())
        datePicker.datePickerMode = .date
        datePicker.locale = Locale.current
        datePicker.preferredDatePickerStyle = .wheels
        return datePicker
    }()
    
    private var stackViewName: UIStackView {
        let stackViewName = UIStackView()
        stackViewName.toAutoLayout()
        
        stackViewName.axis = .vertical
        stackViewName.spacing = 5.0
        
        stackViewName.addArrangedSubview(nameTextFieldLabel)
        stackViewName.addArrangedSubview(nameTextField)
        self.addSubview(stackViewName)
        
        NSLayoutConstraint.activate([
            stackViewName.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            stackViewName.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stackViewName.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
        ])
        return stackViewName
    }
    
    private var stackViewDate: UIStackView {
        let stackViewDate = UIStackView()
        stackViewDate.toAutoLayout()
        
        stackViewDate.axis = .horizontal
        stackViewDate.spacing = 3.0
        
        stackViewDate.addArrangedSubview(dateTextFieldLabel)
        stackViewDate.addArrangedSubview(dateTextField)
        self.addSubview(stackViewDate)
        
        NSLayoutConstraint.activate([
            stackViewDate.topAnchor.constraint(equalTo: stackViewName.topAnchor, constant: 80),
            stackViewDate.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stackViewDate.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
        ])
        return stackViewDate
    }
    
    //MARK: Init
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        
        addSubview(stackViewName)
        addSubview(stackViewDate)
        addSubview(datePickerLabel)
        addSubview(datePicker)
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Set constraint
    func setConstraint() {
        [
            datePickerLabel.topAnchor.constraint(equalTo: stackViewDate.bottomAnchor, constant: 50),
            datePickerLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            datePickerLabel.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor),
            
            datePicker.topAnchor.constraint(equalTo: datePickerLabel.bottomAnchor, constant: 20),
            datePicker.leadingAnchor.constraint(equalTo: leadingAnchor),
            datePicker.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor),
            datePicker.heightAnchor.constraint(equalToConstant: 300),
        ].forEach({$0.isActive = true})
    }
    
}
