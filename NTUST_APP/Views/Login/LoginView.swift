//
//  LoginView.swift
//  NTUST_APP
//
//  Created by Cheng Pong Huang on 2023/5/31.
//

import SwiftUI

struct LoginView: View {
    @State var Account: String = ""
    @State var Password: String = ""
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
                .foregroundColor(Color(hue: 0.65, saturation: 0.132, brightness: 0.454))
                .bold()
                .padding(.bottom, 20)
        }
    }
    var LoginField: some View{
        VStack{
            TextField("學號", text: $Account)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)
                .padding(.horizontal, 20)
            SecureField("密碼", text: $Password)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)
                .padding(.horizontal, 20)
        }
    }
    var LoginButton: some View{
        Button{
            LoginManager.shared.Login(Account: Account, Password: Password)
        }
        label: {
            Text("登入")
                .font(.system(size: 20))
                .bold()
                .foregroundColor(.white)
                .padding(.vertical, 10)
                .frame(width: 200, height: 50)
                .background(Color(.systemBlue))
                .cornerRadius(10)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
