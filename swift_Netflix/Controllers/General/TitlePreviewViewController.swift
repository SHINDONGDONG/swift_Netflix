//
//  TitlePreviewViewController.swift
//  swift_Netflix
//
//  Created by 申民鐡 on 2022/03/24.
//

import UIKit
import WebKit

class TitlePreviewViewController: UIViewController {

    //MARK: - Properties
    //WebkitView를 선언해준다.
    private let webKit: WKWebView = {
        let webKit = WKWebView()
        webKit.translatesAutoresizingMaskIntoConstraints = false
        return webKit
    }()
    
    //타이틀라벨을 선언
    private let titleLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = .systemFont(ofSize: 22, weight: .bold)
        return label
    }()
        
    //오버뷰의 라벨을 선언
    private let overviewLabel :UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    private let downloadButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        button.setTitle("Download", for: .normal)
        button.setTitleColor(.white, for: .normal )
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        return button
    }()
    
    
    
    
    //MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configures()
    }
    
    //MARK: - Configures
    
    func configures(){
        view.backgroundColor = .systemBackground
        view.addSubview(webKit)
        view.addSubview(titleLabel)
        view.addSubview(overviewLabel)
        view.addSubview(downloadButton)
        
        configureConstraints()
    }
    
    func configureConstraints() {
        let webKitConstraints = [
            webKit.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webKit.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webKit.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webKit.heightAnchor.constraint(equalToConstant: 250)
        ]
        
        let titleLabelConstraints = [
            titleLabel.topAnchor.constraint(equalTo: webKit.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ]
        
        let overviewLabelConstraints = [
            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            overviewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            overviewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        
        let downloadButtonConstraints = [
            downloadButton.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 25),
            downloadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            downloadButton.heightAnchor.constraint(equalToConstant: 40),
            downloadButton.widthAnchor.constraint(equalToConstant: 120),
        ]
        
        NSLayoutConstraint.activate(webKitConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(overviewLabelConstraints)
        NSLayoutConstraint.activate(downloadButtonConstraints)
    }
    
    //titlePreviewviewmodel 을 받아서 유튜브 id를 빼야함
    func configure(with model: TitlePreviewViewModel) {
        titleLabel.text = model.title
        overviewLabel.text = model.titleOverView
         
        guard let url = URL(string:
        "https://www.youtube.com/embed/\(model.youtubeView.id.videoId)") else { return }
        
        webKit.load(URLRequest(url: url))
    }
}
