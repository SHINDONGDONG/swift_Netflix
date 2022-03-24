//
//  APICaller.swift
//  swift_Netflix
//
//  Created by 申民鐡 on 2022/03/15.
//

import Foundation


struct Constants {
    //나의 API KEY 를 저장
    static let API_KEY = "30ddc3fde1447b4edde59b88fbfd15f3"
    //baseURL을 저장시켜놓음.
    static let baseURL = "https://api.themoviedb.org"
    
    //Youtube의 API키
    static let YoutubeAPI_KEY = "AIzaSyDfdhhYIogVcQ8ta_W4Nojai7KbVmhkfXw"
    //youtube의 baseURL
    static let YoutubeBaseURL = "https://youtube.googleapis.com/youtube/v3/search?"
    
}

enum APIError: Error {
    case failedTogetData
}


class APICaller {
    static let shared = APICaller()
    
    //트랜딩 영화를 가져온다.
    func getTrendingMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        //우리가 사파리에서 본 json url을 담아준다.
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/movie/day?api_key=\(Constants.API_KEY)&language=ko-KR") else {return}
        
        //url json 파일을 파싱하는 작업을 들어간다.
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                print("Error OMG")
                return
            }
            do {
//                let result = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
//                //result에 json object를 파싱하여 넣는다.
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(error))
            }
            
        }
        //멈춰있던걸 resume하여 재기동
        task.resume()
        }
    
    
    func getTrendingTvs(completion: @escaping (Result<[Title], Error>)-> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/tv/day?api_key=\(Constants.API_KEY)&language=ko-KR") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func getUpcomingMovies(completion: @escaping (Result<[Title], Error>)-> Void) {
        guard let url = URL(
            string: "\(Constants.baseURL)/3/movie/upcoming?api_key=\(Constants.API_KEY)&language=ko-KR&page=1") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func getPopular(completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string:
        "\(Constants.baseURL)/3/movie/popular?api_key=\(Constants.API_KEY)&language=ko-KR&page=1") else {return}
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func getTopRated(completion: @escaping (Result<[Title], Error>)->Void) {
        guard let url = URL(string:
        "\(Constants.baseURL)/3/movie/top_rated?api_key=\(Constants.API_KEY)&language=ko-KR&page=1") else {return}
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func getDiscoverMovies(completion: @escaping (Result <[Title], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/discover/movie?api_key=\(Constants.API_KEY)&language=ko-KR&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate") else {return}
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            } catch { 
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    
    func search(with query: String, completion: @escaping (Result<[Title], Error>) -> Void ) {
        //query를 받을 때 처리해줌
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(Constants.baseURL)/3/search/movie?api_key=\(Constants.API_KEY)&query=\(query)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                print(error)
//                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    
    func getMovei(with query: String, completion: @escaping (Result<VideoElements, Error>) -> Void ) {
        //인자값으로 들어온 query를 가공해주는 작업을 거친 뒤 url에 포함시킨다
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        //url을 만들어줌
        guard let url = URL(string: "\(Constants.YoutubeBaseURL)q=\(query)&key=\(Constants.YoutubeAPI_KEY)") else { return }

        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(YoutubeSearchResponse.self, from: data)
                completion(.success(results.items[0]))
            } catch {
                completion(.failure(error))
                print(error)
            }
        }
        task.resume()
    }
}


