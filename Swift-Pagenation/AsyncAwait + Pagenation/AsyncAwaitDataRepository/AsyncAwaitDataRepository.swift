//
//  AsyncAwaitDataRepository.swift
//  Swift-Pagenation
//
//  Created by M.Ömer Ünver on 8.08.2024.
//

import Foundation

class AsyncAwaitDataRepository : ObservableObject {
    @Published var totalPageData : [AsyncAwaitModel] = []
    func asyncAwaitDataRepositoryFunc(postId : Int) async throws -> [AsyncAwaitModel]{
        let url = URL(string: "https://jsonplaceholder.typicode.com/comments?postId=\(postId)")
        guard let url = url else {throw URLError(.badURL)}
        let (data, response) = try await URLSession.shared.data(from: url)
                guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let decodeData = try decoder.decode([AsyncAwaitModel].self, from: data)
            self.totalPageData.append(contentsOf: decodeData)
            return decodeData
        } catch {
            throw URLError(.cannotDecodeContentData)
        }
       
    }
}
