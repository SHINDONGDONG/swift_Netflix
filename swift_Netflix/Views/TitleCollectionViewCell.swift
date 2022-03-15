//
//  TitleCollectionViewCell.swift
//  swift_Netflix
//
//  Created by 申民鐡 on 2022/03/15.
//

import UIKit
import SDWebImage


class TitleCollectionViewCell: UICollectionViewCell {
    
    //MARK: Properties
    static let identifier = "TitleCollectionViewCell"
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configures()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.frame = contentView.bounds
    }
    
    //MARK: Configures
    func configures() {
        backgroundColor = .systemPink
    }
    
    //모델이 가지고있는 각 포스터를 추출해준다.
    public func configure(with model: String) {
//        print(model÷)
        //url을 model이름으로 받아서 url에 넣어주고
//        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg") else {
//            return
//        }
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(model)") else {
            return
        }
        print(url)
//        imageview인 posterimageview에 sd_setImage로 하여 url을 넣어준다.
        posterImageView.sd_setImage(with: url, completed: nil)
        
    }
    
    
    
}
