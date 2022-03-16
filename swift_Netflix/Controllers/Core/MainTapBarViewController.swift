//
//  ViewController.swift
//  swift_Netflix
//
//  Created by 申民鐡 on 2022/03/10.
//

import UIKit

class MainTapBarViewController: UITabBarController {
    //MARK: Properties
    
    
    //MARK: Init
    override func viewDidLoad() {
        super.viewDidLoad()
            configure()
    }
    
    //MARK: Configures
    func configure() {
        view.backgroundColor = .systemYellow
        
        let vc1 = UINavigationController(rootViewController: HomeViewController())
        let vc2 = UINavigationController(rootViewController: UpcomingViewController())
        let vc3 = UINavigationController(rootViewController: SearchViewController())
        let vc4 = UINavigationController(rootViewController: DownloadsViewController())
        
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc2.tabBarItem.image = UIImage(systemName: "play.circle")
        vc3.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        vc4.tabBarItem.image = UIImage(systemName: "arrow.down.to.line")

        vc1.title = "Home"
        vc2.title = "Comming Soon"
        vc3.title = "Top Search"
        vc4.title = "Downloads"
        
        tabBar.tintColor = .label
        
        setViewControllers([vc1,vc2,vc3,vc4], animated: true)
        
    }
}
