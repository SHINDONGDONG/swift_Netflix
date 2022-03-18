//
//  CollectionViewTableViewCell.swift
//  swift_Netflix
//
//  Created by 申民鐡 on 2022/03/11.
//

import UIKit

class CollectionViewTableViewCell: UITableViewCell {

    //MARK: Properties
    static let indentfier = "CollectionViewTableViewCell"
    
    private var title: [Title] = [Title]()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        //layout을 선언하구 스크롤 다이렉션을 호리젠탈로 옆으로 할 수 있게만듬
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 140, height: 200)
        //collectionview를 생성
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        //콜렉션뷰에 레지스터를 등록해준다. collectionviewcell을

        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        collectionView.backgroundColor = .systemBackground
        return collectionView
    }()
    

    
    //MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier )
    configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //collectionview도 마찬가지로 크기가 지정되어있어야 표현이가능함.
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
    
    
    
    //MARK: Configures
    func configure() {
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    //데이터를 넣는작업이다.
    public func configures(with titles: [Title]) {
        self.title = titles
        //비동기작업
        DispatchQueue.main.async { [weak self] in
            //비동기작업이 될때 마다 리로드해준다.
            self?.collectionView.reloadData()
        }
    }
}


extension CollectionViewTableViewCell:UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return title.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //collectionview지정이 없을땐 기본 uicollecionviewcell로 리턴해주라.
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else {
                return UICollectionViewCell()
            }

        //model에 poster_path를 당마주고
        guard let model = title[indexPath.row].poster_path else {
            return UICollectionViewCell()
        }
        //titleCollectionviewcell의 configure 메서드에 넣어준다.
        cell.configure(with: model)
        
        return cell
    }
    
    
}
