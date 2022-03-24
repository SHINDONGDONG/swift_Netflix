//
//  YoutubeSearchResponse.swift
//  swift_Netflix
//
//  Created by 申民鐡 on 2022/03/24.
//

import Foundation


//
//{
//    etag = KYr1DTxfh8fcGKEMfEHr3v1yd0I;
//    items =     (
//                {
//            etag = 0sGg5g5KQTO7gjdI9rsy6eK2FNI;
//            id =             {
//                kind = "youtube#video";
//                videoId = uq2OGLUel0M;
//            };
//            kind = "youtube#searchResult";
//        },
//                {
//            etag = "lk8409-m28s-u0WqMRhDC0vgfsE";
//            id =             {
//                kind = "youtube#video";
//                videoId = 0Dj2kq5Neus;
//            };
//            kind = "youtube#searchResult";
//        },
//                {
//            etag = BmzqtxPSygtlb6XkP6KT3HOIcMs;
//            id =             {
//                kind = "youtube#playlist";
//                playlistId = "PLAna5Puze0TEr9sxk34ksojiX4Rq9F_Uy";
//            };
//            kind = "youtube#searchResult";
//        },
//                {
//            etag = "7UboJMIrQupqmQDzXlM_1RJx7Zk";
//            id =             {
//                kind = "youtube#video";
//                videoId = "71xBu_VHTfY";
//            };
//            kind = "youtube#searchResult";
//        },
//                {
//            etag = br8hN1WnwfeuK8cmuvBIPZaEWiw;
//            id =             {
//                kind = "youtube#video";
//                videoId = okUNLqtHRP8;
//            };
//            kind = "youtube#searchResult";
//        }
//    );
//    kind = "youtube#searchListResponse";
//    nextPageToken = CAUQAA;
//    pageInfo =     {
//        resultsPerPage = 5;
//        totalResults = 1000000;
//    };

//언랩핑 1단계
struct YoutubeSearchResponse: Codable{
    let items: [VideoElements]
}
//언랩핑 2단계
struct VideoElements: Codable {
    let id: IdVideoElements
}
//언랩핑 3단계로 json파일을 까는중
struct IdVideoElements: Codable {
    let kind: String
    let videoId: String
}
