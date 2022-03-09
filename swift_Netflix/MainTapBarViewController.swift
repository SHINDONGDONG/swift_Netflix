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
        
        setViewControllers([vc1,vc2,vc3,vc4], animated: true)
        
    }
}
