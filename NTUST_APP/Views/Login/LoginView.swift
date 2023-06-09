//
//  LoginView.swift
//  NTUST_APP
//
//  Created by Cheng Pong Huang on 2023/5/31.
//

import SwiftUI

enum AlertType: Identifiable {
    case loginSuccess
    case loginFailure
    
    var id: AlertType { self }
}

struct LoginView: View {
    @State private var account: String = ""
    @State private var password: String = ""
    @State private var isLoading = false
    @State private var alertType: AlertType? = nil
    
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
        .alert(item: $alertType) { alertType in
            switch alertType {
            case .loginSuccess:
                return Alert(
                    title: Text("登入成功"),
                    message: Text("歡迎回來 \(account)"),
                    dismissButton: .default(Text("確定"))
                )
            case .loginFailure:
                return Alert(
                    title: Text("登入失败"),
                    message: Text(errorMessage()),
                    dismissButton: .default(Text("確定"))
                )
            }
        }
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
            print("Login Button Pressed")
            //收起小鍵盤
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            
            
            
            if account.isEmpty || password.isEmpty
            {
                alertType = .loginFailure
                return
            }
            
            isLoading = true
            MoodleManager.shared.Login(Account: account, Password: password) { success in
                if success {
                    // 登入成功
                    print("Login successful")
                    alertType = .loginSuccess
                    
                    //MoodleManager.shared.Test()
                    //切換 view 到 MainView
                    
                } else {
                    // 登入失敗
                    print("Login failed")
                    alertType = .loginFailure
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
    }
    
    func errorMessage() -> String {
        if account.isEmpty && password.isEmpty {
            return "帳號和密碼皆為空"
        } else if account.isEmpty {
            return "帳號為空"
        } else if password.isEmpty {
            return "密碼為空"
        } else {
            return "請檢查您的帳號和密碼。"
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
