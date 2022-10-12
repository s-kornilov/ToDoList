import UIKit

class HabitDetailsViewController: UIViewController {
    
    let habit: Habit
    static var isDeleted = false
    
    //MARK: Set tableView
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.toAutoLayout()
        tableView.refreshControl = UIRefreshControl()
        tableView.isScrollEnabled = true
        tableView.separatorInset = .zero
        tableView.rowHeight = 44
        tableView.refreshControl?.addTarget(HabitDetailsViewController.self, action: #selector(updateTable), for: .valueChanged)
        return tableView
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Init habit
    init(_ habit: Habit) {
        self.habit = habit
        super.init(nibName: nil, bundle: nil)
    }
    
    //MARK: Load view
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Править", style: .plain, target: self, action: #selector(editTap))
        
        view.backgroundColor = .white
        view.addSubviews(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(HabitTableViewCell.self, forCellReuseIdentifier: "habitViewCell")
        tableView.register(HabitTableViewHeader.self, forHeaderFooterViewReuseIdentifier: "habitHeaderCell")
        
        useConstraint()
    }
    
    //MARK: view did appear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        title = habit.name
    }
    
    //MARK: Set Constraint
    func useConstraint() {
        [tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
         tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
         tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
         tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ].forEach({$0.isActive = true})
    }
    
    //MARK: Functions
    @objc func editTap() {
        self.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(HabitViewController(habit), animated: true)
    }
    
    @objc func updateTable() {
        tableView.reloadData()
        tableView.refreshControl?.endRefreshing()
    }
}

//MARK: Extension HabitDetailsVC
extension HabitDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HabitsStore.shared.dates.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =  tableView.dequeueReusableCell(withIdentifier: "habitViewCell", for: indexPath) as? HabitTableViewCell else { return UITableViewCell() }
        let date = HabitsStore.shared.dates[indexPath.row]
        cell.setDateFormat(date: date, check: HabitsStore.shared.habit(habit, isTrackedIn: date))
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "habitHeaderCell") as? HabitTableViewHeader else { return nil }
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
}
