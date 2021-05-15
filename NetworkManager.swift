//
//  NetworkManager.swift
//  
//
//  Created by Varsha Iyer on 5/10/21.
//

import Foundation
import Alamofire
class NetworkManager {
    

    //TO DO: replace the host
    static let host = "https://cornellconnect.herokuapp.com/"
     
    static func getAllAttractions(completion: @escaping ([Attraction]) -> Void) {
        let endpoint = "\(host)attractions/"
        
        AF.request(endpoint, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let data):
                //TO DO
                let jsonDecoder = JSONDecoder()
                do {
                    let response = try jsonDecoder.decode(Response<[Attraction]>.self, from: data)
                        completion(response.data)
                    
                } catch{
                   print(error)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func getSpecificAttraction(id: Int, completion: @escaping (Attraction) -> Void){
        let endpoint = "\(host)/attractions/\(id)"
        AF.request(endpoint, method: .get, encoding: URLEncoding.default).validate().responseData { response in switch response.result{
        case .success(let data):
            let jsonDecoder = JSONDecoder()

            if let response = try? jsonDecoder.decode(Response<Attraction>.self, from: data){ completion(response.data)

            }
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    
}
    static func getAllPosts(id: Int, completion: @escaping ([Post]) -> Void){
        let endpoint = "\(host)attractions/\(id)/posts/"
        AF.request(endpoint, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()

                if let response = try? jsonDecoder.decode(Response<[Post]>.self, from: data){
                    completion(response.data)
                }
            case.failure(let error):
                print(error.localizedDescription)
            }

        }
    }
    
    static func createPost(id: Int, netid: String, name: String, picture: String, description: String, completion: @escaping ((Post) -> Void)) {
        let endpoint = "\(host)attractions/\(id)/posts/"
        print(endpoint)
        let parameters: [String:Any] = [
            "netid": netid,
            "name": name,
            "picture": picture,
            "description": description
        ]
        AF.request(endpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseData { response in
            switch response.result{
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                
                if let response = try? jsonDecoder.decode(Post.self, from: data){
                    completion(response)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
}



