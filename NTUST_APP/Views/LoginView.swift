//
//  LoginView.swift
//  NTUST_APP
//
//  Created by Cheng Pong Huang on 2023/5/31.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        VStack{
            Spacer()
            IconTitle
            Spacer()
            LoginField
            LoginButton
            Spacer()
        }
    }
    
    
    var IconTitle: some View{
        VStack{
            Image("NTUST_Icon")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .padding(.bottom, 20)
            Text("台科生活")
                .font(.system(size: 30))
                .bold()
                .padding(.bottom, 20)
        }
    }
    var LoginField: some View{
        VStack{
            TextField("學號", text: .constant(""))
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)
                .padding(.horizontal, 20)
            SecureField("密碼", text: .constant(""))
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)
                .padding(.horizontal, 20)
        }
    }
    var LoginButton: some View{
        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
            Text("登入")
                .font(.system(size: 20))
                .bold()
                .foregroundColor(.white)
                .padding(.vertical, 10)
                .frame(width: 200, height: 50)
                .background(Color(.systemBlue))
                .cornerRadius(10)
        })
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}