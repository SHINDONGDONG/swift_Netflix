//
//  UpcomingViewController.swift
//  swift_Netflix
//
//  Created by 申民鐡 on 2022/03/10.
//

import UIKit

class UpcomingViewController: UIViewController {
    //MARK: Properties
    
    private let upcomingTable:UITableView = {
        let table = UITableView()
        table.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        return table
    }()
    
    private var titles:[Title] = [Title]()
    
    
    //MARK: Init
    override func viewDidLoad() {
        super.viewDidLoad()
        configures()
    }
    //테이블의 크기를 추가 시켜줌.
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        upcomingTable.frame = view.bounds
    }
    
    //MARK: Configures
    func configures(){
        view.backgroundColor = .systemBackground
        //타이틀
        title = "Upcoming"
        //navigationBar 에서 title을 감성있게 왼쪽에 크게만들어준다.
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        //테이블을 추가
        view.addSubview(upcomingTable)
        upcomingTable.delegate = self
        upcomingTable.dataSource = self
        
        fetchUpcoming()
    }
    
    //upcoming의 타이틀을 불러오는 메서드
    private func fetchUpcoming() {
        //APICaller에서 겟업커밍 무비스를 불러와서
        APICaller.shared.getUpcomingMovies { results in
            //results로 넘어오는 데이터가 정상적이라면 titles에 저장후 self.titles에 넣는다.
            switch results {
            case .success(let titles):
                self.titles = titles
                //그것을 비동기로 표현해주고 upcomingtable을 리로드해준다.
                DispatchQueue.main.async {
                    self.upcomingTable.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }

}

extension UpcomingViewController:UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //titles에 들어간 데이터들의 수로 카운트한다.
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = upcomingTable.dequeueReusableCell(
            withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else {
            return UITableViewCell()
        }
        
        let title = titles[indexPath.row]
        cell.configure(with: TitleViewModel(
            titleName: (title.title ?? title.name) ?? "Unknown title Name", posterURL: title.poster_path ?? ""))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.height / 6 //혹은 사이즈 직접입력
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        upcomingTable.deselectRow(at: indexPath, animated: true)
        
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
