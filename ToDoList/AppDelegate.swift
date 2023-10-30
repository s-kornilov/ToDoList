//
//  AppDelegate.swift
//  ToDoList
//
//  Created by Sergei Kornilov on 28/04/2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let tabBarController = UITabBarController()
        
        func createTasksViewController() -> UINavigationController {
            let tasksViewController = TasksViewController()
            tasksViewController.title = "Tasks"
            if #available(iOS 13.0, *) {
                tasksViewController.tabBarItem = UITabBarItem(title: "Tasks", image: UIImage(systemName: "list.bullet.circle"), tag: 0)
            } else {
                tasksViewController.tabBarItem = UITabBarItem(title: "Tasks", image: UIImage(named: "list.bullet.circle"), tag: 0)
            }
            return UINavigationController(rootViewController: tasksViewController)
            
        }
        func createInfoViewController() -> UINavigationController {
            let infoViewController = InfoViewController()
            infoViewController.title = "Info"
            if #available(iOS 13.0, *) {
                infoViewController.tabBarItem = UITabBarItem(title: "Info", image: UIImage(systemName: "info.circle.fill"), tag: 1)
            } else {
                infoViewController.tabBarItem = UITabBarItem(title: "Info", image: UIImage(named: "info.circle.fill"), tag: 1)
            }
            
            return UINavigationController(rootViewController: infoViewController)
            
        }
        
        func createTabBarController() -> UITabBarController {
            UITabBar.appearance().backgroundColor = .white
            tabBarController.viewControllers = [createTasksViewController(), createInfoViewController()]
            
            return tabBarController
        }
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .systemGray6
        window?.rootViewController = createTabBarController()
        window?.makeKeyAndVisible()
        return true
    }

    
}

