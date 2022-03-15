//
//  Extensions.swift
//  swift_Netflix
//
//  Created by 申民鐡 on 2022/03/15.
//

import Foundation

extension String {
    
    //String을 Extension해서 Title의 첫번째 인자만 대문자로 만들고 나머지들은 lower로 떨어뜨림.
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
}
