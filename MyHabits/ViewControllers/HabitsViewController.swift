import UIKit

class HabitsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    //MARK: Set collection view
    static let layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 12
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layout.sectionInsetReference = .fromContentInset
        return layout
    }()
    
    static let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: HabitsViewController.layout)
        collectionView.toAutoLayout()
        collectionView.backgroundColor = customLightGray
        return collectionView
    }()
    
    //MARK: Load view
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = customLightGray
        
        //add button in tabBar
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addNewHabit))
        
        HabitsViewController.collectionView.dataSource = self
        HabitsViewController.collectionView.delegate = self
        
        view.addSubview(HabitsViewController.collectionView)
        
        HabitsViewController.collectionView.register(HabitProgressViewCell.self, forCellWithReuseIdentifier: "habitProgress")
        HabitsViewController.collectionView.register(HabitCollectionViewCell.self, forCellWithReuseIdentifier: "habitViewCell")
        
        useConstraint()
    }
    
    //MARK: viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Сегодня"
    }
    
    //MARK: Func add Habit
    @objc func addNewHabit() {
        self.navigationController?.pushViewController(HabitViewController(nil), animated: false)
        HabitsViewController().navigationItem.title = "Создать"
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    //MARK: Set constraint
    func useConstraint() {
        [HabitsViewController.collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
         HabitsViewController.collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
         HabitsViewController.collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
         HabitsViewController.collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ].forEach({$0.isActive = true})
    }
}

//MARK: Extension HabitsVC
extension HabitsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return HabitsStore.shared.habits.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "habitProgress", for: indexPath) as? HabitProgressViewCell else { return UICollectionViewCell() }
            cell.calculateProgress()
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "habitViewCell", for: indexPath) as? HabitCollectionViewCell else { return UICollectionViewCell() }
            cell.tapToCell(habit: HabitsStore.shared.habits[indexPath.item - 1])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0 {
            return CGSize(width: collectionView.frame.width - (16 * 2), height: 60)
        } else {
            return CGSize(width: collectionView.frame.width - (16 * 2), height: 130)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !(indexPath.item == 0) {
            guard let item = collectionView.cellForItem(at: indexPath) as? HabitCollectionViewCell else { return }
            if let habit = item.habit {
                navigationController?.pushViewController(HabitDetailsViewController(habit), animated: false)
                navigationController?.navigationBar.prefersLargeTitles = false
                
            }
        }
    }
}
