//
//  ContentView.swift
//  Swift-Pagenation
//
//  Created by M.Ömer Ünver on 6.08.2024.
//

import SwiftUI

struct PagenationHomeView: View {
    @ObservedObject var vM = PagenationListViewModel()
    var body: some View {
        NavigationView{
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(vM.pagenationData, id: \.id) { user in
                        HStack(alignment: .center) {
                            AsyncImage(url: URL(string: user.avatar)) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 70, height: 90)
                            .clipShape(Circle())
                            VStack(alignment: .leading) {
                                Text("Email: \(user.email)")
                                HStack(spacing: 1) {
                                    Text("Name : \(user.firstName)")
                                    Text(user.lastName)
                                }
                                
                                
                            }
                        }
                        .padding(.leading)
                        .padding(.trailing)
                        .onAppear(){
                            vM.loadMoreContent(currentItem: user)
                        }
                    }
                }
                if vM.page < vM.totalPage {
                    ProgressView()
                        .padding()
                }
            }
            
            
            
        }
    }
    
}

#Preview {
    PagenationHomeView()
}
