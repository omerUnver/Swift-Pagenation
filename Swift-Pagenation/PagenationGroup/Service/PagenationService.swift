//
//  PagenationService.swift
//  Swift-Pagenation
//
//  Created by M.Ömer Ünver on 6.08.2024.
//

import Foundation
class PagenationService : ObservableObject {
    @Published var totalPageData : [Users] = []
    func fetchUserData(page : Int,completion : @escaping(Result<[User], ErrorUrl>) -> Void){
        let url = URL(string: "https://reqres.in/api/users?page=\(page)")
        guard let url = url else {return completion(.failure(.yanlisURL))}
        let urlRequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                print("ERROR")
            }
            guard let response = response as? HTTPURLResponse else {return}
            guard response.statusCode == 200 else {return completion(.failure(.statusCodeError))}
            guard let data = data else {return completion(.failure(.veriGelmedi))}
            do {
                let decodeUserData = try JSONDecoder().decode(Users.self, from: data)
                self.totalPageData.append(decodeUserData)
                completion(.success(decodeUserData.data))
            } catch {
                debugPrint("Error : \(error.localizedDescription)")
                completion(.failure(.veriIslenemedi))
            }
            
            
        }
        .resume()
        
    }
    
    
    
    
}
enum ErrorUrl : Error {
    case yanlisURL
    case veriGelmedi
    case veriIslenemedi
    case statusCodeError
}
