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
    
    
}
