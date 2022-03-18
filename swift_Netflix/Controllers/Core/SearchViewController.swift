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
    
    //uisearchcontroller를 만들어준다.
    private let searchController: UISearchController = {
        //컨트롤러에 controller는 우리가만든 searchresultsviewcontroller를 넣어준다.
        let controller = UISearchController(searchResultsController: SearchResultsViewController())
        //search 화면에 placeholder
        controller.searchBar.placeholder = "Search for a Movie or a TV"
        controller.searchBar.searchBarStyle = .minimal
        return controller
    }()
    
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
        //naviBar의 cancel을 색상바꿔줌.
        navigationController?.navigationBar.tintColor = .label
        view.addSubview(discoverTable)
        discoverTable.delegate = self
        discoverTable.dataSource = self
        fetchDiscoverMovie()
        
        navigationItem.searchController = self.searchController
        searchController.searchResultsUpdater = self
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

extension SearchViewController:UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        //updateSearchResults의 searchbar를 선언
        let searchBar = searchController.searchBar
        
        guard let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              //qeury에 글짜가있는데 count가 3개이상인경우
              query.trimmingCharacters(in: .whitespaces).count >= 3,
              let resultsController = searchController.searchResultsController
                as? SearchResultsViewController else {return}
        
        APICaller.shared.search(with: query) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let titles):
                    print(titles)
                    resultsController.titles = titles
                    resultsController.searchResultsCollectionView.reloadData()
                case .failure(let error):
                    print(error )
                }
            }
            
        }
        
    }
    
}
