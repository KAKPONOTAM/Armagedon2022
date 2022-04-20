import UIKit
protocol AsteroidViewControllerDelegate: AnyObject {
    func didSelect()
}

class AsteroidViewController: UIViewController {
    private var isPaging = true
    fileprivate var isDangerous = false
    private var distanceFormat: DistanceFormat?
    private var asteroidData: AsteroidData?
    private var asteroidDataValuesArray = [NearEarthObjects]()
    private var dangerousAsteroidData = [NearEarthObjects]()
    weak var delegate: AsteroidViewControllerDelegate?
    
    private lazy var asteroidTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AsteroidTableViewCell.self, forCellReuseIdentifier: AsteroidTableViewCell.identifier)
        return tableView
    }()
    
    init(asteroidData: AsteroidData?) {
        self.asteroidData = asteroidData
        super.init(nibName: nil, bundle: nil)
        guard let asteroidValuesArray = self.asteroidData?.nearEarthObjects[NetworkManager.shared.dayToRequest] else { return }
        
        self.asteroidDataValuesArray.append(contentsOf: asteroidValuesArray)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubview()
        setupConstraints()
        setupNavigationControllerTabBar()
        asteroidTableView.tableFooterView = createFooterViewWithLoadSpinner()
    }
    
    private func fetchDataByScroll() {
        isPaging = false
        NetworkManager.shared.currentRequestDay = Calendar.current.date(byAdding: .day, value: 1, to: NetworkManager.shared.currentRequestDay) ?? Date()
        
        NetworkManager.shared.sendRequestAboutAsteroid { [weak self] asteroidData in
            guard let self = self else { return }
            
            self.asteroidDataValuesArray.append(contentsOf: asteroidData.nearEarthObjects[NetworkManager.shared.dayToRequest] ?? [])
            
            self.dangerousAsteroidData.append(contentsOf: self.asteroidDataValuesArray.filter { asteroid in
                asteroid.isPotentiallyHazardousAsteroid == true && !self.dangerousAsteroidData.contains(where: { dangerousAsteroid in
                    dangerousAsteroid.name == asteroid.name
                })})
            
            if self.dangerousAsteroidData.count < 2 {
                self.fetchDataByScroll()
            }
            
            self.asteroidTableView.reloadData()
            self.isPaging = true
        }
    }
    
    private func setupNavigationControllerTabBar() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemGray6
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationItem.title = Localization.armageddon.title
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal.decrease"), style: .plain, target: self, action: #selector(rightBarButtonPressed))
    }
    
    private func addSubview() {
        view.addSubview(asteroidTableView)
    }
    
    @objc private func rightBarButtonPressed() {
        let filterViewController = FilterViewController()
        filterViewController.delegate = self
        navigationController?.pushViewController(filterViewController, animated: true)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            asteroidTableView.topAnchor.constraint(equalTo: view.topAnchor),
            asteroidTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            asteroidTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            asteroidTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func createFooterViewWithLoadSpinner() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        let loadSpinner = UIActivityIndicatorView()
        loadSpinner.center = footerView.center
        loadSpinner.startAnimating()
        
        footerView.addSubview(loadSpinner)
        return footerView
    }
}

extension AsteroidViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let asteroidCell = tableView.dequeueReusableCell(withIdentifier: AsteroidTableViewCell.identifier, for: indexPath) as? AsteroidTableViewCell else { return UITableViewCell() }
        
        let asteroidInfo = isDangerous ? dangerousAsteroidData[indexPath.section] : asteroidDataValuesArray[indexPath.section]
        asteroidCell.delegate = self
        
        asteroidCell.configure(with: asteroidInfo, distanceFormat: distanceFormat ?? DistanceFormat.kilometers, index: indexPath.section)
        return asteroidCell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return isDangerous ? dangerousAsteroidData.count : asteroidDataValuesArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.cellHeightForAsteroidViewController
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailedViewController = DetailedIAsteroidInfoViewController(nearObjectData: isDangerous ? dangerousAsteroidData[indexPath.section] : asteroidDataValuesArray[indexPath.section])
        
        navigationController?.pushViewController(detailedViewController, animated: true)
    }
}

extension AsteroidViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        
        if position > asteroidTableView.contentSize.height - 100 - scrollView.frame.height, isPaging {
            fetchDataByScroll()
        }
    }
}

extension AsteroidViewController: FilterViewControllerDelegate {
    func filtersDidSelected(with distanceFormat: DistanceFormat, isDangerous: Bool) {
        self.distanceFormat = distanceFormat
        self.isDangerous = isDangerous
        asteroidTableView.reloadData()
        fetchDataByScroll()
    }
}

extension AsteroidViewController: AsteroidTableViewCellDelegate {
    func destroyButtonTapped(index: Int) {
        let indexPath = IndexPath(row: 0, section: index)
        let correctRow = self.asteroidTableView.cellForRow(at: indexPath)
        var removedObject: NearEarthObjects?
        
        UIView.animate(withDuration: 0.5) {
            correctRow?.alpha = 0
            correctRow?.isUserInteractionEnabled = false
        } completion: { _ in
            if self.isDangerous {
                 removedObject = self.dangerousAsteroidData.remove(at: index)
                self.asteroidDataValuesArray.removeAll { nearObject in
                    nearObject.name == removedObject?.name
                }
                
            } else {
                removedObject = self.asteroidDataValuesArray.remove(at: index)
            }
            
            guard let removedObject = removedObject else { return }

            TrashManager.shared.onDeleteAsteroidArray.append(removedObject)
            
            self.fetchDataByScroll()
            
            self.asteroidTableView.reloadData()
            correctRow?.isUserInteractionEnabled = true
        }
    }
}
