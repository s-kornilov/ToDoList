import UIKit

class HabitTableViewHeader: UITableViewHeaderFooterView {
    
    //MARK: Set UI elements
    let labelActive: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textColor = customHeaderTable
        label.text = "Активность"
        label.text = label.text?.uppercased()
        return label
    }()

    //MARK: Init
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.addSubview(labelActive)
        useConstraint()
    }

    //MARK: Set constraint
    func useConstraint() {
        [labelActive.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 22),
         labelActive.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
         labelActive.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 16),
        ].forEach({$0.isActive = true})
    }
    
}
