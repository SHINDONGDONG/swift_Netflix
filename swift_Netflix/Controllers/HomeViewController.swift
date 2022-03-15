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
    let sectionTitles: [String] = [
        "Trending Movies","Popular","Trending TV","Upcoming Movies","Top rated"]

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
        NavBar()
    }
    
    func NavBar() {
        var image = UIImage(named: "netflixLogo")
        //이미지를 불러올 때 항상 렌더링이 오리지날 파일로 렌더링해서온다.
        image = image?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem =
        UIBarButtonItem(image: image, style: .done, target: self, action: nil)
        
        //navigationItem 오른쪽에 버튼을 생성
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
        ]
        //navigationContoller에서 navigaionBar 컬러를 화이트로 다 바꾸어준다.
        navigationController?.navigationBar.tintColor = .white
        
        
    }
    
}

extension HomeViewController:UITableViewDelegate, UITableViewDataSource {
    
    //tableview의 헤더에 섹션에 관한 옵션을 설정할 수 있다.
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        //header에 대입 - view가 있으면 UITableViewheaderFotterview로 리턴해주고 아니면 아무것도 아닌것을 리턴.
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20,
                                         y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .label
        //header의 텍스트를 row스펠링으로 바꿔줄 수 있다.
        header.textLabel?.text = header.textLabel?.text?.lowercased()
    }
    
    //tableview에서 title을 표현해주는 기본메서드
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
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
    
    //맨 윗부분을 스크롤을 다운시켰을 때 navigation bar가 같이 올라가는 사양으로 만든다.
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //safearea의 탑을 계산하여 넣고
        let defaultOffset = view.safeAreaInsets.top
        //스크롤뷰 컨텐트 offset.y를 + defaultoffset을 넣고
        let offset = scrollView.contentOffset.y + defaultOffset
        // navigationController에 transform 으로 initailizing해준다. x축은 0, y는 min(0, -offset)
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
}
