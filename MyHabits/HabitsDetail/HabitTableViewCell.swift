import UIKit

class HabitTableViewCell: UITableViewCell {
    
    //MARK: Set UI elements
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    
    lazy var checkmarkLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textColor = customPurple
        label.text = "✓"
        return label
    }()
    
    //MARK: Init
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubviews(dateLabel, checkmarkLabel)
        useConstraint()
    }
    
    //MARK: Set constraint
    func useConstraint() {
        [dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 11),
         dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
         dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -11),
         checkmarkLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 11),
         checkmarkLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -14),
         checkmarkLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -11)
        ].forEach({$0.isActive = true})
    }
    
    //MARK: Set UI format date
    func setDateFormat(date: Date, check: Bool) {
        let today = Calendar.current.dateComponents([.day], from: Date())
        let checkDate = Calendar.current.dateComponents([.day], from: date)
        if let day = today.day {
            if day == checkDate.day {
                dateLabel.text = "Сегодня"
            } else if day - 1 == checkDate.day {
                dateLabel.text = "Вчера"
            } else {
                let dateformat = DateFormatter()
                dateformat.locale = Locale(identifier: "ru_RU")
                dateformat.dateFormat = "dd MMMM yyyy"
                dateLabel.text = dateformat.string(from: date)
            }
        }
        checkmarkLabel.isHidden = !check
    }
}
