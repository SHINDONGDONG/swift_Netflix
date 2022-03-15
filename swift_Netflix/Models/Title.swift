//
//  Movie.swift
//  swift_Netflix
//
//  Created by 申民鐡 on 2022/03/15.
//

import Foundation

//가져온 api를 모델로서 사용할 수 있게 추출한다.
struct TrendingTitleResponse: Codable {
    let results: [Title]
}

struct Title: Codable {
//가지고온 Json파일중 사용할 것들을 model struct에 넣어준다.
    let id: Int
    let media_type: String?
    let original_name: String?
    let original_title: String?
    let poster_path: String?
    let overview: String?
    let vote_count: Int
    let release_date: String?
    let vote_average: Double
}
