import UIKit

class HabitProgressViewCell: UICollectionViewCell {
    
    //MARK: Set UI elements
    lazy var progressLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.text = "Все получится!"
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.backgroundColor = .white
        label.textColor = .systemGray
        label.numberOfLines = 1
        return label
    }()
    
    lazy var percentLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.backgroundColor = .white
        label.textColor = .systemGray
        label.numberOfLines = 1
        return label
    }()
    
    lazy var progressBar: UIProgressView = {
        let progress = UIProgressView(progressViewStyle: .bar )
        progress.toAutoLayout()
        progress.trackTintColor = customLightGray
        progress.progressTintColor = customPurple
        progress.layer.cornerRadius = 5
        progress.clipsToBounds = true
        progress.layer.sublayers![1].cornerRadius = 3.5
        progress.subviews[1].clipsToBounds = true
        return progress
    }()
    
    //MARK: Init
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 14
        contentView.addSubviews(progressLabel, percentLabel, progressBar)
        useConstraint()
    }
    
    //MARK: Calculate progress
    func calculateProgress() {
        progressBar.progress = HabitsStore.shared.todayProgress
        percentLabel.text = String(Int(HabitsStore.shared.todayProgress * 100)) + "%"
    }
    
    //MARK: Set constraint
    func useConstraint() {
        [progressLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
         progressLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
         
         percentLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
         percentLabel.leadingAnchor.constraint(equalTo: progressLabel.trailingAnchor, constant: 16),
         percentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
         
         progressBar.topAnchor.constraint(equalTo: progressLabel.bottomAnchor, constant: 8),
         progressBar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
         progressBar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
         progressBar.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
         progressBar.heightAnchor.constraint(equalToConstant: 7)
        ].forEach({$0.isActive = true})
    }
}
