//
//  AsyncAwaitView.swift
//  Swift-Pagenation
//
//  Created by M.Ömer Ünver on 8.08.2024.
//

import SwiftUI

struct AsyncAwaitView: View {
    @ObservedObject var vM = AsyncAwaitViewModel()
    var body: some View {
        NavigationView{
            ScrollView {
                
                LazyVStack(alignment: .leading) {
                    ForEach(vM.dataRepo, id: \.id) { user in
                        HStack(alignment: .center) {
                            Image(systemName: "person.fill")
                            VStack(alignment: .leading) {
                                Text("Page : \(user.postId)")
                                Text("Email: \(user.email)")
                                Text("Name : \(user.name)")
                                Text("Body : \(user.body)")
                                Divider()
                            }
                        }
                        .padding(.leading)
                        .padding(.trailing)
                        .onAppear(){
                            vM.loadMoreContent(currentItem: user)
                            
                        }
                    }
                    
                    if vM.postId < vM.totalPage {
                        ProgressView()
                            .padding()
                    }
                }
                
            }
            
            
            
        }
    }
}

#Preview {
    AsyncAwaitView()
}
