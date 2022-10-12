import UIKit

class HabitViewController: UIViewController, UITextFieldDelegate, UIColorPickerViewControllerDelegate {
    
    //MARK: Set variables
    var habit: Habit?
    var habitName: String = ""
    //var titlePost: String = "Создать привычку" UINavbar
    
    var date: Date = Date() {
        didSet {
            let dateformat = DateFormatter()
            dateformat.dateFormat = "HH:mm a"
            dateValue.text = dateformat.string(from: date)
        }
    }
    var habitCurrentColor: UIColor = customPurple {
        didSet {
            colorButton.backgroundColor = habitCurrentColor
        }
    }
    
    //MARK: Set navigation
    lazy var viewTitle: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.text = "Создать"
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.toAutoLayout()
        button.setTitle("Отменить", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        button.setTitleColor(customPurple, for: .normal)
        button.addTarget(self, action: #selector(cancelHabit), for: .touchUpInside)
        return button
    }()
    
    lazy var saveButton: UIButton = {
        let button = UIButton()
        button.toAutoLayout()
        button.setTitle("Сохранить", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        button.setTitleColor(customPurple, for: .normal)
        button.addTarget(self, action: #selector(saveHabit), for: .touchUpInside)
        return button
    }()
    
    lazy var stackHeaderView: UIStackView = {
        let stackView = UIStackView()
        stackView.toAutoLayout()
        stackView.distribution = .fillProportionally
        stackView.axis = .horizontal
        return stackView
    }()
    
    //MARK: Set UI elements
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.textColor = .black
        label.numberOfLines = 1
        label.text = "Название"
        label.text = label.text?.uppercased()
        return label
    }()
    
    lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.toAutoLayout()
        textField.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        textField.textColor = customBlue
        textField.backgroundColor = .white
        textField.leftViewMode = .always
        textField.placeholder = "Бегать по утрам, спать 8 часов и т.п."
        textField.returnKeyType = .done
        textField.delegate = self
        textField.addTarget(self, action: #selector(nameTextChanged), for: .editingChanged)
        return textField
    }()
    
    lazy var colorLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.textColor = .black
        label.text = "Цвет"
        label.text = label.text?.uppercased()
        return label
    }()
    
    lazy var colorButton: UIButton = {
        let colorButton = UIButton()
        colorButton.toAutoLayout()
        colorButton.backgroundColor = habitCurrentColor
        colorButton.layer.cornerRadius = 30 / 2
        colorButton.isUserInteractionEnabled = true
        colorButton.addTarget(self, action: #selector(tapColorButton), for: .touchUpInside)
        return colorButton
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.textColor = .black
        label.numberOfLines = 1
        label.text = "Время"
        label.text = label.text?.uppercased()
        return label
    }()
    
    lazy var dateText: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.textColor = .black
        label.numberOfLines = 1
        label.text = "Каждый день в "
        return label
    }()
    
    lazy var dateValue: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        
        let dateformat = DateFormatter()
        dateformat.dateFormat = "h:mm a"
        
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textColor = customPurple
        label.text = dateformat.string(from: date)
        return label
    }()
    
    lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.toAutoLayout()
        datePicker.date = date
        datePicker.backgroundColor = .white.withAlphaComponent(0.9)
        datePicker.datePickerMode = .time
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.tintColor = customPurple
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        return datePicker
    }()
    
    lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.toAutoLayout()
        button.backgroundColor = .white
        button.setTitle("Удалить привычку", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.addTarget(self, action: #selector(deleteHabit), for: .touchUpInside)
        return button
    }()
    
    //MARK: Init edit or add habit
    init(_ editHabit: Habit?) {
        super.init(nibName: nil, bundle: nil)
        habit = editHabit
        if let currentHabit = habit {
            date = currentHabit.date
            habitCurrentColor = currentHabit.color
            habitName = currentHabit.name
            nameTextField.text = habitName
            viewTitle.text = "Править"
            deleteButton.isHidden = false
        } else {
            viewTitle.text = "Создать"
            deleteButton.isHidden = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Load view
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        stackHeaderView.addArrangedSubview(cancelButton)
        stackHeaderView.addArrangedSubview(viewTitle)
        stackHeaderView.addArrangedSubview(saveButton)
        
        view.addSubviews(stackHeaderView, nameLabel, nameTextField, colorLabel, colorButton, dateLabel, dateText, dateValue, datePicker, deleteButton)
        
        useConstraint()
    }
    
    //MARK: Event - save
    @objc func saveHabit() {
        if nameTextField.text!.isEmpty {
            let alert = UIAlertController(title: "Ошибка", message: "Не заполнено название ", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Понятно", style: .default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
        else {
            if let currentHabit = habit {
                currentHabit.name = nameTextField.text!
                currentHabit.date = date
                currentHabit.color = habitCurrentColor
                HabitsStore.shared.save()
                HabitsViewController.collectionView.reloadData()
                
                let viewControllers = self.navigationController!.viewControllers
                let lastTwoVC = viewControllers[viewControllers.count - 3]
                self.navigationController?.popToViewController(lastTwoVC, animated: true)
                
            } else {
                let newHabit = Habit(name: nameTextField.text!, date: date, color: habitCurrentColor)
                let store = HabitsStore.shared
                if !store.habits.contains(newHabit) {
                    store.habits.append(newHabit)
                    HabitsViewController.collectionView.reloadData()
                }
            }
            self.navigationController?.popViewController(animated: true)
        }
        self.navigationController?.navigationBar.isHidden = false
    }
    
    //MARK: Event - cancel
    @objc func cancelHabit() {
        self.navigationController?.popViewController(animated: true)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    
    //MARK: Event - changes fields
    @objc func nameTextChanged() {
        if let text = nameTextField.text {
            habitName = text
        }
    }
    
    @objc func dateChanged( _ sender: UIDatePicker) {
        date = sender.date
    }
    
    @objc func tapOnView() {
        nameTextField.resignFirstResponder()
    }
    
    @objc func tapColorButton() {
        let colorPicker = UIColorPickerViewController()
        colorPicker.delegate = self
        present(colorPicker, animated: true, completion: nil)
    }
    
    //MARK: Set constrains
    func useConstraint() {
        [stackHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
         stackHeaderView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
         stackHeaderView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
         
         
         nameLabel.topAnchor.constraint(equalTo: stackHeaderView.bottomAnchor, constant: 21),
         nameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
         nameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
         nameLabel.heightAnchor.constraint(equalToConstant: nameLabel.font.pointSize),
         
         nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16),
         nameTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
         nameTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
         colorLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 16),
         colorLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
         colorLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 16),
         
         colorButton.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 16),
         colorButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
         colorButton.heightAnchor.constraint(equalToConstant: 30),
         colorButton.widthAnchor.constraint(equalToConstant: 30),
         
         dateLabel.topAnchor.constraint(equalTo: colorButton.bottomAnchor, constant: 16),
         dateLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
         dateLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
         
         dateText.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 16),
         dateText.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
         
         dateValue.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 16),
         dateValue.leadingAnchor.constraint(equalTo: dateText.trailingAnchor, constant: 16),
         
         datePicker.topAnchor.constraint(equalTo: dateText.bottomAnchor, constant: 16),
         datePicker.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
         datePicker.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 16),
         
         deleteButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
         deleteButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
         
        ].forEach({$0.isActive = true})
    }
    
    //MARK: Func delete habit
    @objc func deleteHabit() {
        let alertController = UIAlertController(title: "Удалить привычку", message: "Вы хотите удалить привычку \"\(nameTextField.text ?? "Без имени")\"?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        let deleteAction = UIAlertAction(title: "Удалить", style: .destructive) { (action) -> Void in
            if let currentHabit = self.habit {
                HabitsStore.shared.habits.removeAll(where: {$0 == currentHabit})
                HabitsViewController.collectionView.reloadData()
            }
            HabitDetailsViewController.isDeleted = true
            
            let viewControllers = self.navigationController!.viewControllers
            let lastVC = viewControllers[viewControllers.count - 3]
            self.navigationController?.popToViewController(lastVC,animated:true)
        }
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        self.present(alertController, animated: true, completion: nil)
        self.navigationController?.navigationBar.isHidden = true
    }
    
}

//MARK: Extension HabitVC
extension HabitViewController {
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        habitCurrentColor = viewController.selectedColor
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        return true;
    }
}
