//
//  Card.swift
//  NTUST_APP
//
//  Created by Cheng Pong Huang on 2023/5/31.
//

import SwiftUI

struct Card: View {
    var IconName: String
    var Title: String
    let Action: () -> Void // 增加一个参数来表示按钮的操作
    
    var body: some View {
        Button(action: {
            // 调用按钮的操作
            Action()
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 22, style: .continuous)
                    .fill(Color.white)
                    .shadow(color: Color.black.opacity(0.1), radius: 20, x: 0, y: 10)
                
                VStack {
                    // Circle Icon
                    Image(systemName: IconName)
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 4))
                        .shadow(radius: 10)
                        .padding()
                    
                    Text(Title)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding(.bottom)
                }
            }
            .frame(width: 144, height: 164)
            .padding()
        }
    }
}


struct Card_Previews: PreviewProvider {
    static var previews: some View {
        Card(IconName: "house", Title: "Home"){
            
        }
    }
}
