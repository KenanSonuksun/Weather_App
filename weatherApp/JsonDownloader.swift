//
//  JsonDownloader.swift
//  weatherApp
//
//  Created by Pars arge on 14.07.2021.
//

import Foundation
import UIKit

class JsonDownloader {
    
    let session : URLSession
    
    init(config : URLSessionConfiguration){
        self.session = URLSession(configuration: config)
    }
    convenience init(){
        self.init(config : URLSessionConfiguration.default)
    }
    typealias JSON = [String : AnyObject]
    func jsonTask(with request : URLRequest , completionHandler completion : @escaping (JSON?,Errors?) -> Void) -> URLSessionDataTask{
        
        let task =  session.dataTask(with: request) { data,response,error in
            guard let httpRequest = response as? HTTPURLResponse else{
                completion(nil,Errors.RequestError)
                return
            }
            if httpRequest.statusCode == 200 {
                if let data = data {
                    do{
                        let jsonData = try! JSONSerialization.jsonObject(with: data, options: []) as? JSON
                        completion(jsonData,nil)
                    }catch{
                        completion(nil,Errors.JsonError)
                    }
                    
                }else{
                    completion(nil,Errors.InvalidData)
                }
            }else {
                completion(nil,Errors.ResponseError)
            }
        }
        return task
    }
}
