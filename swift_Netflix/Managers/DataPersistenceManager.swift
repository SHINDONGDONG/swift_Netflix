//
//  DataPersistenceManager.swift
//  swift_Netflix
//
//  Created by 申民鐡 on 2022/03/25.
//

import Foundation
import UIKit
import CoreData

class DataPersistenceManager {
    
    //Error일때
    enum DatabaseError: Error {
        case failedToSaveData
        case failedToFetchData
        case failedToDeleteData
    }
    //자기자신을 항상 메모리에 띄우고있다.
    static let shared = DataPersistenceManager()
    
    func downloadTitleWith(model: Title, completion: @escaping(Result<Void, Error>) -> Void){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        let item = TitleIitem(context: context)
        
        //title에서 추출한것들을 titleItem에 넣어준다(core data)
        item.title = model.title
        item.id = Int64(model.id)
        item.name = model.name
        item.overview = model.overview
        item.poster_path = model.poster_path
        item.media_type = model.media_type
        item.release_date = model.release_date
        item.vote_count = Int64(model.vote_count)
        item.vote_average = model.vote_average
        
        //성공이되면 context를 세이브하고
        do {
            try context.save()
            completion(.success(()))
        } catch {
            print(error)
            completion(.failure(DatabaseError.failedToSaveData))
        }
    }
    
    func fetchingTitlesFromDatabase(competion: @escaping (Result<[TitleIitem], Error>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        
        let request: NSFetchRequest<TitleIitem>
        
        request = TitleIitem.fetchRequest()
        
        do {
            let titles = try context.fetch(request)
            competion(.success(titles))
        } catch {
            competion(.failure(DatabaseError.failedToFetchData))
        }
    }
    
    func deleteTitleWith(model: TitleIitem, completion: @escaping (Result<Void,Error> )-> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        
        context.delete(model)
        
        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(DatabaseError.failedToDeleteData))
            
        }
    }
    
}
