import UIKit

class DetailedIAsteroidInfoViewController: UIViewController {
    private var nearObjectsData: NearEarthObjects?
    
    private lazy var detailedAsteroidTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.register(DetailedInfoTableViewCell.self, forCellReuseIdentifier: DetailedInfoTableViewCell.identifier)
        return tableView
    }()
    
    init(nearObjectData: NearEarthObjects?) {
        guard let nearObjectData = nearObjectData else {
            super.init(nibName: nil, bundle: nil)
            return }
        
        self.nearObjectsData = nearObjectData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        view.backgroundColor = .white
        addSubview()
        setupConstraints()
    }
    
    private func setupNavigationController() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemGray6
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationItem.title = nearObjectsData?.name.changeAsteroidNameFormat
        
        let backButton = UIBarButtonItem()
        backButton.title = Localization.back.title
        
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func addSubview() {
        view.addSubview(detailedAsteroidTableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            detailedAsteroidTableView.topAnchor.constraint(equalTo: view.topAnchor),
            detailedAsteroidTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailedAsteroidTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailedAsteroidTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension DetailedIAsteroidInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return DetailsDataTypes.getNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let detailedTableViewCell = tableView.dequeueReusableCell(withIdentifier: DetailedInfoTableViewCell.identifier, for: indexPath) as? DetailedInfoTableViewCell else { return UITableViewCell() }
        
        let detailDataType = DetailsDataTypes.getRow(index: indexPath.section)
        guard let nearObjectsData = nearObjectsData else { return UITableViewCell() }
        
        detailedTableViewCell.configure(with: nearObjectsData, detailsType: detailDataType, index: indexPath.section)
        
        return detailedTableViewCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.cellHeightForDetailViewController
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}

