import UIKit

protocol FilterViewControllerDelegate: AnyObject {
    func filtersDidSelected(with distanceFormat: DistanceFormat, isDangerous: Bool)
}

class FilterViewController: UIViewController {
    weak var delegate: FilterViewControllerDelegate?
    private var isDangerous: Bool
    private var distanceFormat: DistanceFormat
    private var selectedIndex = 0
    
    private lazy var settingsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UnitOfMeasureTableViewCell.self, forCellReuseIdentifier: UnitOfMeasureTableViewCell.identifier)
        tableView.register(DangerStateTableViewCell.self, forCellReuseIdentifier: DangerStateTableViewCell.identifier)
        return tableView
    }()
    
    init() {
        guard let settings = SettingsManager.shared.receiveSettingsButtonsStatement() else {
            isDangerous = false
            distanceFormat = .kilometers
            super.init(nibName: nil, bundle: nil)
            return
        }
        
        selectedIndex = settings.selectedIndex
        isDangerous = settings.isDangerous
        distanceFormat = DistanceFormat.getFormat(atIndex: settings.selectedIndex)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationControllerSetup()
        addSubview()
        setupConstraints()
    }
    
    private func addSubview() {
        view.addSubview(settingsTableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            settingsTableView.topAnchor.constraint(equalTo: view.topAnchor),
            settingsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            settingsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            settingsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func navigationControllerSetup() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemGray6
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationItem.title = Localization.filter.title
        
        let backButton = UIBarButtonItem()
        backButton.title = Localization.back.title
        
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: Localization.done.title, style: .done, target: self, action: #selector(rightBarButtonTapped))
    }
    
    @objc private func leftBarButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func rightBarButtonTapped() {
        delegate?.filtersDidSelected(with: distanceFormat, isDangerous: isDangerous)
        
        let settings = SettingsButtonsStatements(isDangerous: isDangerous, selectedIndex: selectedIndex)
        SettingsManager.shared.saveSettingsButtonsStatement(settingsButtonsStatements: settings)
        navigationController?.popViewController(animated: true)
    }
}

extension FilterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Settings.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Settings.getRow(atIndex: indexPath.row)
        
        switch cell {
        case .unitOfMeasure:
            guard let unitOfMeasureCell = tableView.dequeueReusableCell(withIdentifier: UnitOfMeasureTableViewCell.identifier, for: indexPath) as? UnitOfMeasureTableViewCell else { return UITableViewCell() }
            unitOfMeasureCell.delegate = self
            return unitOfMeasureCell
            
        case .isDangerous:
            guard let asteroidHazardCell = tableView.dequeueReusableCell(withIdentifier: DangerStateTableViewCell.identifier, for: indexPath) as? DangerStateTableViewCell else { return UITableViewCell() }
            asteroidHazardCell.delegate = self
            return asteroidHazardCell
        }
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}

extension FilterViewController: DangerStateTableViewCellDelegate, UnitOfMeasureTableViewCellDelegate {
    func changeDistanceFormat(distanceFormat: DistanceFormat, selectedIndex: Int) {
        self.distanceFormat = distanceFormat
        self.selectedIndex = selectedIndex
    }
    
    func changeToOnlyDangerousAsteroid(isDangerous: Bool) {
        self.isDangerous = isDangerous
    }
}
