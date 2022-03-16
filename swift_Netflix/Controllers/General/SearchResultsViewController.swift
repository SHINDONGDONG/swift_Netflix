//
//  SearchResultsViewController.swift
//  swift_Netflix
//
//  Created by 申民鐡 on 2022/03/16.
//

import UIKit

class SearchResultsViewController: UIViewController {
    // MARK: - Properties
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        configures()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        dismiss(animated: true, completion: nil)
        print("touch view")
    }


    // MARK: - Configures
    func configures() {
        view.backgroundColor = .systemGreen
    }

}
