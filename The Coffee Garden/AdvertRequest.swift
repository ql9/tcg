//
//  AdvertRequest.swift
//  The Coffee Garden
//
//  Created by Quốc Lê on 8/31/20.
//  Copyright © 2020 Quốc Lê. All rights reserved.
//

import Foundation

enum AdvertError: Error{
    case noData
    case canNotProcess
}

struct AdvertRequest{
    let url: URL
    init(){
        let resourceString = "https://thawing-falls-33830.herokuapp.com/ads"
        guard let url = URL(string: resourceString) else {fatalError()}
        self.url = url
    }
    
    func getAdvert(completion: @escaping (Result<[Advert], AdvertError>) -> Void){
        let dataTask = URLSession.shared.dataTask(with: url){data, _, _ in
            guard let jsonData = data else{
                completion(.failure(.noData))
                return
            }
            
            do{
                let decoder = JSONDecoder()
                let adverts = try decoder.decode([Advert].self, from: jsonData)
                completion(.success(adverts))
                
            }
            catch{
                completion(.failure(.canNotProcess))
            }
        }
        dataTask.resume()
    }
    
}
