//
//  SearchResultsViewController.swift
//  swift_Netflix
//
//  Created by 申民鐡 on 2022/03/16.
//

import UIKit

class SearchResultsViewController: UIViewController {
    // MARK: - Properties
    public let searchResultsCollectionView: UICollectionView = {
        let  layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical
        //기기의 UIScreen의 메인 bounds width를 3으로 나눈 크기
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 10, height: 200)
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TitleCollectionViewCell.self,
                                forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        return collectionView
    }()

//    public let searchResultsCollectionView: UITableView = {
//          layout.scrollDirection = .vertical
//          //기기의 UIScreen의 메인 bounds width를 3으로 나눈 크기
//          let collectionView = UITableView()
//        collectionView.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
//          return collectionView
//      }()

    
    public var titles: [Title] = [Title]()
    
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        configures()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchResultsCollectionView.frame = view.bounds
    }
    
    // MARK: - Configures
    func configures() {
        view.backgroundColor = .systemBackground
        view.addSubview(searchResultsCollectionView)
        
        searchResultsCollectionView.delegate = self
        searchResultsCollectionView.dataSource = self
        //contentinset  = 즉 세이프에리어를 항상 적용시켜서 보여준다.
//        searchResultsCollectionView.contentInsetAdjustmentBehavior = .always
        searchResultsCollectionView.backgroundColor = .systemBackground
    }

}

//extension SearchResultsViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return titles.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = searchResultsCollectionView.dequeueReusableCell(
//            withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else {
//                return UITableViewCell()
//            }
//        let title = titles[indexPath.row]
//        cell.configure(with: TitleViewModel(
//            titleName: (title.original_title ?? title.original_name) ?? "Unknown title Name", posterURL: title.poster_path ?? ""))
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 120
//    }
//}
 
extension SearchResultsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = searchResultsCollectionView.dequeueReusableCell(
            withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else {
                return UICollectionViewCell()
            }
        let title = titles[indexPath.row]
        cell.configure(with: title.poster_path ?? "Unknown Image")
        return cell
    }


}
