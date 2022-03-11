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
    
    

    
    //MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier )
    configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Configures
    func configure() {
        contentView.backgroundColor = .systemPink
    }
}
