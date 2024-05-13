//
//  EditPhoto.swift
//  NOSTYLE
//
//  Created by Gleb Korotkov on 09.05.2024.
//

import Foundation
import SwiftUI

struct EditPhotoView: View {
    var image: UIImage
    @State var selectTab = "1"
    let tabs = ["original", "filters", "rotate", "resize", "paint"]
    
    /*init(){
        UITabBar.appearance().isHidden = true
    }*/
    
    var body: some View {
        Button{
            
        } label: {
            HStack{
                Image("save")
                    .resizable()
                    .frame(width: 27, height: 27)
            }
        }
        Spacer()
        ZStack(alignment: .bottom){
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
        }
        ZStack(alignment: .bottom){
            TabView(selection: $selectTab){
                Text("original")
                    .tag("original")
                FiltersView()
                    .tag("filters")
                Text("original")
                    .tag("rotate")
                Text("resize")
                    .tag("resize")
                Text("paint")
                    .tag("paint")
            }
            HStack{
                ForEach(tabs, id: \.self){
                    tab in
                    TabBarItem(tab: tab, selected: $selectTab)
                }
            }
            .padding(.top, 20)
            .padding(.bottom, 5)
            .frame(maxWidth: .infinity)
            .background(Color("MainBG"))
        }
    }
}

struct TabBarItem: View {
    @State var tab: String
    @Binding var selected: String
    var body: some View {
        ZStack{
            Button{
                withAnimation(.spring()){
                    selected = tab
                }
            } label: {
                HStack{
                    Image(tab)
                        .resizable()
                        .frame(width: 27, height: 27)
                    if selected == tab{
                        Text(tab)
                            .font(.system(size: 14))
                            .foregroundColor(.black)
                    }
                }
            }
        }
        .opacity(selected == tab ? 1 : 0.7)
        .padding(.vertical, 10)
        .padding(.horizontal, 17)
        .background(selected == tab ? .white: Color("MainBG"))
        .clipShape(Capsule())
        
    }
}
