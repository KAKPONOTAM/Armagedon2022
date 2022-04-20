import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let loadViewController = LoadViewController()
        
        let navigationRootViewController = UINavigationController(rootViewController: loadViewController)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationRootViewController
        window?.backgroundColor = .black
        window?.makeKeyAndVisible()
        
        SettingsManager.shared.reset()
        
        return true
    }
}



