//
//  TitleTableViewCell.swift
//  swift_Netflix
//
//  Created by 申民鐡 on 2022/03/16.
//

import UIKit

class TitleTableViewCell: UITableViewCell {

    //MARK: Properties
    //cell register등록할 때 필요한 identifier
    static let identifier = "TitleTableViewCell"
    
    //타이틀 포스트이미지뷰를 생성
    private let titlesPosterUIImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
     
    //타이틀 라벨을 생성
    private let titleLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    //button을 생성
    private let playTitleButton:UIButton = {
        let button = UIButton()
        //버튼 이미지생성
        //image에 uiimage 등, withconfirugration에서 심볼컨피그레이션으로 폰트사이즈를 40으로 주어 크기를키운다
        let image = UIImage(systemName: "play.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 40))
        button.setImage(image, for: .normal)
        //버튼의 기본 이미지색상
        button.tintColor = .label
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
    
    //MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configures()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Configures
    func configures() {
        //imageview를 추가
        contentView.addSubview(titlesPosterUIImageView)
        //타이틀라벨을 추가
        contentView.addSubview(titleLabel)
        //버튼을 추가
        contentView.addSubview(playTitleButton)
        
        applyConstraints()
    }
    
    //label button imageview등의 크기,위치를 지정하는 메서드
    private func applyConstraints() {
        let titlesPosterUIImageViewConstraints = [
            titlesPosterUIImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titlesPosterUIImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            titlesPosterUIImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            titlesPosterUIImageView.widthAnchor.constraint(equalToConstant: 100)
        ]
        let titleLabelConstraints = [
            titleLabel.leadingAnchor.constraint(equalTo: titlesPosterUIImageView.trailingAnchor, constant: 20),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ]
        //button Constraints값 설정
        let playTitleButtonConstraints = [
            playTitleButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            playTitleButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        NSLayoutConstraint.activate(titlesPosterUIImageViewConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        //button constraints active활성
        NSLayoutConstraint.activate(playTitleButtonConstraints)
    }
    
    //TilteViewModel클래스에서 모델을 넘겨받아와 image를 set 해주는 메서드
    public func configure(with model: TitleViewModel) {

        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(model.posterURL)") else {
            return
        }
        titlesPosterUIImageView.sd_setImage(with: url, completed: nil)
        titleLabel.text = model.titleName
    }
    
}
