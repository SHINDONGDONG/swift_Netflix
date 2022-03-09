//
//  ViewController.swift
//  swift_Netflix
//
//  Created by 申民鐡 on 2022/03/10.
//

import UIKit

class MainTapBarViewController: UITabBarController {
    //MARK: Properties
    
    
    //MARK: Init
    override func viewDidLoad() {
        super.viewDidLoad()
            configure()
    }
    
    //MARK: Configures
    func configure() {
        view.backgroundColor = .systemYellow
        
    }
}



#if DEBUG
import SwiftUI
struct ViewControllerRepresentable: UIViewControllerRepresentable {
    //update
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
    //makeui
    @available(iOS 13.0, *)
    func makeUIViewController(context: Context) -> UIViewController {
        MainTapBarViewController()
    }
}
struct ViewController_Previews : PreviewProvider {
    static var previews: some View {
        ViewControllerRepresentable()
            .previewDisplayName("미리보기")
    }
}
#endif
