import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let tabBarController = UITabBarController()
        
        func createHabitsViewController() -> UINavigationController {
            let habitsViewController = HabitsViewController()
            habitsViewController.title = "Привычки"
            habitsViewController.tabBarItem = UITabBarItem(title: "Привычки", image: UIImage(named: "habits_tab_icon"), selectedImage: nil)
            return UINavigationController(rootViewController: habitsViewController)
            
        }
        func createInfoViewController() -> UINavigationController {
            let infoViewController = InfoViewController()
            infoViewController.title = "Информация"
            infoViewController.tabBarItem = UITabBarItem(title: "Информация", image: UIImage(systemName: "info.circle.fill"), tag: 1)
            //profileViewController.navigationBar.isHidden = true
            return UINavigationController(rootViewController: infoViewController)
            
        }
        
        func createTabBarController() -> UITabBarController {
            UITabBar.appearance().backgroundColor = .white
            tabBarController.viewControllers = [createHabitsViewController(), createInfoViewController()]
            return tabBarController
        }

        UITabBar.appearance().tintColor = customPurple
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.rootViewController = createTabBarController()
        window?.makeKeyAndVisible()
        
        return true
    }
}
