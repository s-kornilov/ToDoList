import UIKit

class InfoViewController: UIViewController {
    
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
        label.text = "Привычка за 21 день"
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
    
    //MARK: Load view
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)
        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height)
        scrollView.addSubviews(titleLabel, textView)
        useConstraint()
    }
    
    //MARK: Set constraint
    func useConstraint() {
        [scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
         scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
         scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
         scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
         
         titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 22),
         titleLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
         titleLabel.widthAnchor.constraint(equalToConstant: 218),
         titleLabel.heightAnchor.constraint(equalToConstant: 24),
         
         textView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 62),
         textView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
         textView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -16),
        ].forEach({$0.isActive = true})
    }
    
}
