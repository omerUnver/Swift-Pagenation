//
//  PagenationViewModel.swift
//  Swift-Pagenation
//
//  Created by M.Ömer Ünver on 6.08.2024.
//

import Foundation
class PagenationListViewModel : ObservableObject {
    var pagenationService = PagenationService()
    var page : Int = 1
    @Published var totalPage = 0
    @Published var pagenationData = [PagenationViewModel]()
    init(){
        getUserDataViewModel()
    }
    func getUserDataViewModel(){
        pagenationService.fetchUserData(page: page) { result in
            switch result {
            case .failure(let error):
                debugPrint("ErrorViewModel : \(error.localizedDescription)")
            case .success(let user):
                DispatchQueue.main.async {
                    if let first = self.pagenationService.totalPageData.first {
                        self.totalPage = first.total_pages
                        debugPrint("Total Pages: \(self.totalPage)")
                    }
                    let newUserData = user.map(PagenationViewModel.init)
                    self.pagenationData.append(contentsOf: newUserData)
                    
                    
                }
            }
        }
    }
    
    func loadMoreContent(currentItem item: PagenationViewModel){
        guard let currentIndex = self.pagenationData.firstIndex(where: { $0.id == item.id }) else {
            return
        }
        let thresholdIndex = self.pagenationData.index(self.pagenationData.endIndex, offsetBy: -1)
        debugPrint(thresholdIndex)
        if currentIndex >= thresholdIndex && (page + 1) <= totalPage {
            page += 1
            debugPrint("Loading Page: \(page)")
            getUserDataViewModel()
        }
        
        
        
    }
}
struct PagenationViewModel {
    var pagenationUser : User
    var id : Int {
        pagenationUser.id
    }
    var email : String {
        pagenationUser.email
    }
    var firstName : String {
        pagenationUser.first_name
    }
    var lastName : String {
        pagenationUser.last_name
    }
    var avatar : String {
        pagenationUser.avatar
    }
    
}

