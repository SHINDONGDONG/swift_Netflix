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
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        //layout을 선언하구 스크롤 다이렉션을 호리젠탈로 옆으로 할 수 있게만듬
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 140, height: 200)
        //collectionview를 생성
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        //콜렉션뷰에 레지스터를 등록해준다. collectionviewcell을
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
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
}


extension CollectionViewTableViewCell:UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .systemGreen
        return cell
    }
    
    
}
