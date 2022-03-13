//
//  HomeViewController.swift
//  swift_Netflix
//
//  Created by 申民鐡 on 2022/03/10.
//

import UIKit


private let tableCell = "cell"
class HomeViewController: UIViewController {

    //MARK: Properties
    private let homeFeedTable:UITableView = {
        let table = UITableView(frame: .zero, style: UITableView.Style.grouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.indentfier)
        return table
    }()
    
    
    //MARK: Init
    override func viewDidLoad() {
        super.viewDidLoad()

        configures()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
    }

    //MARK: Configures
    func configures(){
        view.backgroundColor = .systemBackground
        view.addSubview(homeFeedTable)
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        
        let heroHeaderView = HeroHeaderUIView(
            frame:CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.width))
                                              
        homeFeedTable.tableHeaderView = heroHeaderView
    }
}

extension HomeViewController:UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = homeFeedTable.dequeueReusableCell(withIdentifier: tableCell, for: indexPath)
//        cell.textLabel?.text = "aa"
//        cell.backgroundColor = .systemRed
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CollectionViewTableViewCell.indentfier, for: indexPath) as?
                CollectionViewTableViewCell else {
                    return UITableViewCell()
                }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}
