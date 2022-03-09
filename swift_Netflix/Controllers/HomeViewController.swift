//
//  HomeViewController.swift
//  swift_Netflix
//
//  Created by 申民鐡 on 2022/03/10.
//

import UIKit

class HomeViewController: UIViewController {
    //MARK: Properties

    //MARK: Init
    override func viewDidLoad() {
        super.viewDidLoad()

        configures()
    }

    //MARK: Configures
    func configures(){
        view.backgroundColor = .systemOrange
    }
}
