//
//  TabBarViewController.swift
//  IOSChitChat
//
//  Created by Nazar Kopeyka on 19.04.2023.
//

import UIKit

class TabBarViewController: UITabBarController {

    let chatList: UIViewController /* 101 */
    
    init(chatList: UIViewController) { /* 102 */
        self.chatList = chatList /* 103 */
        super.init(nibName: nil, bundle: nil) /* 104 */
    }
    
    required init?(coder: NSCoder) { /* 106 */
        fatalError("init(coder:) has not been implemented") /* 107 */
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpViewControllers() /* 105 */
    }
    
    private func setUpViewControllers() { /* 96 */
        let settings = SettingsViewController() /* 98 */
        
        let nav1 = UINavigationController(rootViewController: chatList) /* 99 */
        let nav2 = UINavigationController(rootViewController: settings) /* 100 */
        
        nav1.tabBarItem = UITabBarItem(title: "Chat",
                                       image: UIImage(systemName: "message"),
                                       tag: 1) /* 108 */
        nav2.tabBarItem = UITabBarItem(title: "Settings",
                                       image: UIImage(systemName: "gear"),
                                       tag: 2) /* 109 */
        
        setViewControllers([nav1, nav2], animated: true) /* 97 */
    }
}
