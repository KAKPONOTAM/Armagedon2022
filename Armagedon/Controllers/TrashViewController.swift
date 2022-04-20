import UIKit

class TrashViewController: UIViewController {
    var onDeleteAsteroidList = [NearEarthObjects]() {
        didSet {
            destroyListTableView.reloadData()
        }
    }
    
    lazy var destroyListTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(OnDeleteAsteroidTableViewCell.self, forCellReuseIdentifier: OnDeleteAsteroidTableViewCell.identifier)
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    private let sendABrigadeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Отправить бригаду", for: .normal)
        button.addTarget(self, action: #selector(sendBrigadeButtonPressed), for: .touchUpInside)
        button.backgroundColor = .red
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationController()
        addSubview()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        onDeleteAsteroidList = TrashManager.shared.onDeleteAsteroidArray
    }
    
    private func setupNavigationController() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemGray6
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationItem.title = Localization.destroy.title
    }
    
    private func addSubview() {
        view.addSubview(destroyListTableView)
        view.addSubview(sendABrigadeButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            destroyListTableView.topAnchor.constraint(equalTo: view.topAnchor),
            destroyListTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            destroyListTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            destroyListTableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 3 / 3.5)
        ])
        
        NSLayoutConstraint.activate([
            sendABrigadeButton.topAnchor.constraint(equalTo: destroyListTableView.bottomAnchor),
            sendABrigadeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 70),
            sendABrigadeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70),
            sendABrigadeButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    @objc private func sendBrigadeButtonPressed() {
        let alert = UIAlertController(title: AlertsTitle.askForAction.title, message: AlertsTitle.messageDescription.title, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: AlertsTitle.ok.title, style: .default) { _ in
            self.onDeleteAsteroidList.removeAll()
            TrashManager.shared.onDeleteAsteroidArray.removeAll()
            let descriptionAlert = UIAlertController(title: AlertsTitle.congrats.title, message: AlertsTitle.congratsDescription.title, preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: AlertsTitle.ok.title, style: .default, handler: nil)
            
            descriptionAlert.addAction(okAction)
            
            self.present(descriptionAlert, animated: true)
        }
        
        let cancelAction = UIAlertAction(title: AlertsTitle.cancel.title, style: .cancel, handler: nil)
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
}

extension TrashViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return onDeleteAsteroidList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let onDeleteAsteroidCell = tableView.dequeueReusableCell(withIdentifier: OnDeleteAsteroidTableViewCell.identifier, for: indexPath) as? OnDeleteAsteroidTableViewCell else { return UITableViewCell() }
        onDeleteAsteroidCell.configure(with: onDeleteAsteroidList[indexPath.row])
        
        return onDeleteAsteroidCell
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.cellHeightForDetailViewController
    }
}
