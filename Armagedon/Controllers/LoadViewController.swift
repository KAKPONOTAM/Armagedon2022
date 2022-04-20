import UIKit

class LoadViewController: UIViewController {
    private var asteroidData: AsteroidData?
    
    private let loadImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "loadAsteroid")
        return imageView
    }()
    
    private let loadSpinner: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = .orange
        activityIndicator.startAnimating()
        return activityIndicator
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubview()
        setupConstraints()
        sendDataToAsteroidViewController()
    }
    
    private func addSubview() {
        view.addSubview(loadImageView)
        loadImageView.addSubview(loadSpinner)
    }
    
    private func configureTabBarAndNavigationBar() -> UITabBarController {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemGray6

        let tabBarViewController = UITabBarController()
        let trashViewController = TrashViewController()
        let asteroidViewController = AsteroidViewController(asteroidData: asteroidData)

        let navigationTrashViewController = UINavigationController(rootViewController: trashViewController)
        let navigationAsteroidViewController = UINavigationController(rootViewController: asteroidViewController)
        tabBarViewController.setViewControllers([navigationAsteroidViewController, navigationTrashViewController], animated: true)
        
        navigationAsteroidViewController.tabBarItem = UITabBarItem(title: Localization.asteroid.title, image: UIImage(systemName: "globe"), tag: 0)
        navigationTrashViewController.tabBarItem = UITabBarItem(title: Localization.destroy.title, image: UIImage(systemName: "trash"), tag: 1)
        
        tabBarViewController.modalPresentationStyle = .overFullScreen
        return tabBarViewController
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            loadImageView.topAnchor.constraint(equalTo: view.topAnchor),
            loadImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loadImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            loadSpinner.centerXAnchor.constraint(equalTo: loadImageView.centerXAnchor),
            loadSpinner.centerYAnchor.constraint(equalTo: loadImageView.centerYAnchor)
        ])
    }
    
    private func sendDataToAsteroidViewController() {
        NetworkManager.shared.sendRequestAboutAsteroid { [weak self] asteroidData in
            guard let self = self else { return }
            
            self.asteroidData = asteroidData
            
            self.present(self.configureTabBarAndNavigationBar(), animated: true, completion: nil)
            self.loadSpinner.isHidden = true
        }
    }
}
