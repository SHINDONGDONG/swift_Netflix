//
//  HeroHeaderUIView.swift
//  swift_Netflix
//
//  Created by 申民鐡 on 2022/03/13.
//

import UIKit

class HeroHeaderUIView: UIView {

    //MARK: Properties
    private let  heroImageView:UIImageView = {
        let imageView = UIImageView()
        //정확한 비율로 화면채우기
        imageView.contentMode = .scaleAspectFill
        //image가 영역 이내로 제한된다.
        imageView.clipsToBounds = true
        //이미지를 넣는다
        imageView.image = UIImage(named: "heroImage")
        return imageView
    }()
    
    //UIImage Header에 Play버튼을 넣어준다.
    private let playButton:UIButton = {
        let button = UIButton()
        //버튼의 이름
        button.setTitle("Play", for: UIControl.State.normal)
        //버튼의 보더 색상
        button.layer.borderColor = UIColor.white.cgColor
        //버튼의 보더 굵기
        button.layer.borderWidth = 1
        //버튼의 자동 컨스트레인트를 false로
        button.translatesAutoresizingMaskIntoConstraints = false
        //cornerRadius로 둘그랗게 만듬
        button.layer.cornerRadius = 5
        return button
    }()
    
    //UIImage Header에 Downloads버튼을 넣어준다.
    private let downloadButton:UIButton = {
        let button = UIButton()
        //버튼의 이름
        button.setTitle("Downloads", for: UIControl.State.normal)
        //버튼의 보더 색상
        button.layer.borderColor = UIColor.white.cgColor
        //버튼의 보더 굵기
        button.layer.borderWidth = 1
        //버튼의 자동 컨스트레인트를 false로
        button.translatesAutoresizingMaskIntoConstraints = false
        //cornerRadius로 둘그랗게 만듬
        button.layer.cornerRadius = 5
        return button
    }()
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        heroImageView.frame = bounds
    }
    
    //MARK: Configures
    func configure() {
        addSubview(heroImageView)
        addGradient()
        addSubview(playButton)
        addSubview(downloadButton)
        applyConstraints()
    }
    //button에 대한 method
    func applyConstraints() {
        let playButtonConstraints = [
            
            //왼쪽에 붙여주고 거기서 90만큼 떨어뜨려준다.
            playButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 70),
            //이미지뷰에 바텀에 붙여주고 그만큼 위로 50올려준다
            playButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            //버튼을 늘려주어 좀 더 멋있게 표현시켜준다.
            playButton.widthAnchor.constraint(equalToConstant: 120)
        ]
        
        let downloadButtonConstraints = [
            downloadButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -70),
            downloadButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            downloadButton.widthAnchor.constraint(equalToConstant: 120)
        ]
        
        //constranint를 액티브 시켜줌으로 적용시켜준다.
        NSLayoutConstraint.activate(playButtonConstraints)
        NSLayoutConstraint.activate(downloadButtonConstraints)
    }
    
    //그라데이션 레이어 메서드
    func addGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            //색상 순서에따라 그라데이션 적용이된다.
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        //그라데이션 레이어에 프레임을 넣어준다.
        gradientLayer.frame = bounds
        //layer에 addsublayer 그라데이션을 추가시켜줌
        layer.addSublayer(gradientLayer)
    }
    

}
