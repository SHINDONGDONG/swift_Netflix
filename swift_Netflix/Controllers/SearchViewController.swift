//
//  SearchViewController.swift
//  swift_Netflix
//
//  Created by 申民鐡 on 2022/03/10.
//

import UIKit

class SearchViewController: UIViewController {
    
    //MARK: Properties
    private let discoverTable:UITableView = {
        let tableView = UITableView()
        tableView.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        return tableView
    }()
    
    private var titles:[Title] = [Title]()
    
    //MARK: Init
    override func viewDidLoad() {
        super.viewDidLoad()
        confirue()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        discoverTable.frame = view.bounds
    }
    
    //MARK: Configures
    func confirue(){
        view.backgroundColor = .systemBackground
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        view.addSubview(discoverTable)
        discoverTable.delegate = self
        discoverTable.dataSource = self
        fetchDiscoverMovie()
    }
    
    private func fetchDiscoverMovie() {
        APICaller.shared.getDiscoverMovies { results in
            switch results {
            case .success(let titles):
                self.titles = titles
                DispatchQueue.main.async {
                    self.discoverTable.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension SearchViewController:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = discoverTable.dequeueReusableCell(
            withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else {
                    return UITableViewCell()
                }
        
        let title = titles[indexPath.row]
        let model = TitleViewModel(titleName: title.original_name ?? title.original_title ?? "Unknon name",
                                   posterURL: title.poster_path ?? "Unkown")
        cell.configure(with: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    
}
