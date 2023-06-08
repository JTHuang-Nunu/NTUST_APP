//
//  LoginView.swift
//  NTUST_APP
//
//  Created by Cheng Pong Huang on 2023/5/31.
//

import SwiftUI

struct LoginView: View {
    @State private var account: String = ""
    @State private var password: String = ""
    @State private var isLoading = false
    @State private var loginFailed = false
    
    var body: some View {
        VStack {
            Spacer()
            IconTitle
            Spacer()
            LoginField
            LoginButton
            Spacer()
        }
        .overlay(
            Group {
                if isLoading {
                    VStack {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        
                        Text("登入中...")
                            .foregroundColor(.white)
                            .padding(.top, 10)
                    }
                    .padding()
                    .background(Color.black)
                    .cornerRadius(10)
                }
            }
        )
    }
    
    var IconTitle: some View {
        VStack {
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
    
    var LoginField: some View {
        VStack {
            TextField("學號", text: $account)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)
                .padding(.horizontal, 20)
            
            SecureField("密碼", text: $password)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)
                .padding(.horizontal, 20)
        }
    }
    
    var LoginButton: some View {
        Button(action: {
            isLoading = true
            LoginManager.shared.Login(Account: "username", Password: "password") { success in
                if success {
                    // 登入成功
                    print("Login successful")
                } else {
                    // 登入失敗
                    print("Login failed")
                }
                isLoading = false
            }
        }) {
            Text("登入")
                .font(.system(size: 20))
                .bold()
                .foregroundColor(.white)
                .padding(.vertical, 10)
                .frame(width: 200, height: 50)
                .background(Color(.systemBlue))
                .cornerRadius(10)
        }
        .disabled(isLoading)
        .alert(isPresented: $loginFailed) {
            Alert(
                title: Text("登入失败"),
                message: Text("請檢查您的帳號和密碼。"),
                dismissButton: .default(Text("確定"))
            )
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
