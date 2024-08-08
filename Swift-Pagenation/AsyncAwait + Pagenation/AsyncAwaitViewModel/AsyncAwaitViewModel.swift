//
//  AsyncAwaitViewModel.swift
//  Swift-Pagenation
//
//  Created by M.Ömer Ünver on 8.08.2024.
//

import Foundation

class AsyncAwaitViewModel : ObservableObject {
    @Published var postId = 1
    @Published var totalPage = 0
    var asyncService = AsyncAwaitDataRepository()
    @Published var dataRepo = [AsyncAwaitPagenationViewModel]()
    init(){
        Task {
            await getAsyncAwaitData()
        }
    }
    func getAsyncAwaitData() async {
        Task {
            do {
                let data = try await self.asyncService.asyncAwaitDataRepositoryFunc(postId: postId)
                DispatchQueue.main.async {
                     let dataCount = self.asyncService.totalPageData.count
                    print(dataCount)
                    self.totalPage = dataCount
                    let newData = data.map(AsyncAwaitPagenationViewModel.init)
                    self.dataRepo.append(contentsOf: newData)
                    debugPrint(data)
                }
            } catch {
                debugPrint("Error ViewModel : \(error.localizedDescription)")
            }
            
        }
    }
    func loadMoreContent(currentItem item: AsyncAwaitPagenationViewModel){
        guard let currentIndex = self.dataRepo.firstIndex(where: { $0.id == item.id }) else {
            return
        }
        let thresholdIndex = self.dataRepo.index(self.dataRepo.endIndex, offsetBy: -1)
        debugPrint(thresholdIndex)
        if currentIndex >= thresholdIndex && (postId + 1) <= totalPage {
            postId += 1
            debugPrint("Loading Page: \(postId)")
            Task {
              await getAsyncAwaitData()
            }
        }
    }
}

struct AsyncAwaitPagenationViewModel  {
    var pagenationUser : AsyncAwaitModel
    
    var id : Int {
        pagenationUser.id
    }
    var name : String {
        pagenationUser.name
    }
    var email : String {
        pagenationUser.email
    }
    var body : String {
        pagenationUser.body
    }
    var postId : Int {
        pagenationUser.postId
    }
}
