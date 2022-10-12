import UIKit

class HabitCollectionViewCell: UICollectionViewCell {
    
    var habit: Habit?
    
    //MARK: Set UI elements
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .systemGray2
        label.numberOfLines = 1
        return label
    }()
    
    lazy var countLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textColor = .systemGray
        label.numberOfLines = 1
        return label
    }()
    
    lazy var checkMark: UIButton = {
        let button = UIButton()
        button.toAutoLayout()
        button.layer.cornerRadius = 19
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(tapCheck), for: .touchUpInside)
        return button
    }()
    
    //MARK: Init
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 8
        contentView.addSubviews(nameLabel, dateLabel, countLabel, checkMark)
        useConstraint()
    }
    
    //MARK: Func - Tap to cell
    func tapToCell(habit: Habit) {
        self.habit = habit
        nameLabel.text = habit.name
        nameLabel.textColor = habit.color
        dateLabel.text = habit.dateString
        countLabel.text = "Счётчик: " + String(habit.trackDates.count)
        if habit.isAlreadyTakenToday {
            checkMark.backgroundColor = habit.color
            checkMark.layer.borderWidth = 1
            checkMark.layer.borderColor = habit.color.cgColor
            checkMark.setTitle("✓", for: .normal)
            checkMark.isUserInteractionEnabled = false
        } else {
            checkMark.backgroundColor = .white
            checkMark.layer.borderWidth = 1
            checkMark.layer.borderColor = habit.color.cgColor
            checkMark.backgroundColor = .white
            checkMark.setTitle("", for: .normal)
            checkMark.isUserInteractionEnabled = true
        }
    }
    
    @objc func tapCheck() {
        if let trackHabit = habit {
            HabitsStore.shared.track(trackHabit)
            HabitsViewController.collectionView.reloadData()
        }
    }
    
    //MARK: Set constrains
    func useConstraint() {
        [nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
         nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
         
         dateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
         dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
         
         checkMark.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
         checkMark.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 40),
         checkMark.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -26),
         checkMark.widthAnchor.constraint(equalToConstant: 38),
         checkMark.heightAnchor.constraint(equalToConstant: 38),
         
         countLabel.topAnchor.constraint(equalTo: checkMark.bottomAnchor, constant: 9),
         countLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
         countLabel.trailingAnchor.constraint(equalTo: checkMark.leadingAnchor, constant: 72)
        ].forEach({$0.isActive = true})
    }
}
