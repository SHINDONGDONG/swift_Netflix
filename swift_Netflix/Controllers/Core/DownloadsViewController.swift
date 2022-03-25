//
//  DownloadsViewController.swift
//  swift_Netflix
//
//  Created by 申民鐡 on 2022/03/10.
//

import UIKit

class DownloadsViewController: UIViewController {

    
    //MARK: -Properties
    private let downloadTable:UITableView = {
        let table = UITableView()
        table.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        return table
    }()
    
    private var titles: [TitleIitem] = [TitleIitem]()
    
    
    //MARK: -Init
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        downloadTable.frame = view.bounds
    }
    
    //MARK: -Configures
    func configure(){
        view.backgroundColor = .systemBackground
        title = "Download"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        view.addSubview(downloadTable)
        downloadTable.delegate = self
        downloadTable.dataSource = self
        fetchLocalStorageForDownload()
        NotificationCenter.default.addObserver(forName: NSNotification.Name("Downloaded"), object: nil, queue: nil) { _ in
            self.fetchLocalStorageForDownload()
        }
    }
    
    private func fetchLocalStorageForDownload() {
        DataPersistenceManager.shared.fetchingTitlesFromDatabase { [weak self ] result in
            switch result {
            case .success(let titles):
                DispatchQueue.main.async {
                    self?.titles = titles
                    self?.downloadTable.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }

}


    //MARK: -Extension

extension DownloadsViewController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = downloadTable.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath)
                as? TitleTableViewCell else { return UITableViewCell() }
        
        let movieTitle = titles[indexPath.row]
        cell.configure(with: TitleViewModel(titleName: movieTitle.title ?? movieTitle.name ?? "Unkown", posterURL: movieTitle.poster_path ?? "Unkown"))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            
            DataPersistenceManager.shared.deleteTitleWith(model: titles[indexPath.row]) { [weak self ] result in
                switch result {
                case .success():
                    print("Delete from the database")
                case .failure(let error):
                    print(error)
                }
                self?.titles.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        default:
            break
        }

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        //title에 index 순서대로 넣어준다/
        let title = titles[indexPath.row]
        //title에서 name아니면 title을 넣어줌
        guard let titleName = title.name ?? title.title else { return }
        
        //youtube api를 불러온다.
        APICaller.shared.getMovei(with: titleName) { result in
            switch result {
                //result가 있으면 json파일 videoElement를 불러오고
            case .success(let videoElements):
                //비동기적으로 선언해주고
                DispatchQueue.main.async {
                    //프리뷰 컨트롤러를 선언한다
                    let vc = TitlePreviewViewController()
                    //타이틀프리뷰에서 받을 configure에 위에서 받은 데이터들을 넣어준다.
                    vc.configure(with: TitlePreviewViewModel(
                        title: titleName, youtubeView: videoElements, titleOverView: title.overview ?? "unkown"))
                    //present방식으로 넘겨준다.
                    self.present(vc, animated: true, completion: nil)
                }
            case .failure(let error):
                print(error)
            
            }
        }
    }
}
