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

struct MoodleLoginView: View {
    @Binding var isLoggedIn: Bool
    
    @State private var account: String = ""
    @State private var password: String = ""
    @State private var isLoading = false
    @State private var alertType: AlertType? = nil
    
    init(isLoggedIn: Binding<Bool> = .constant(false)) {
        self._isLoggedIn = isLoggedIn
    }
    
    var body: some View {
        VStack {
            Spacer()
            IconTitle
            Spacer()
            loginField
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
            Image("Moodle_Icon")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .padding(.bottom, 20)
            
            Text("Moodle系統登入")
                .font(.system(size: 30))
                .foregroundColor(Color(hue: 0.65, saturation: 0.132, brightness: 0.454))
                .bold()
                .padding(.bottom, 20)
        }
    }
    
    var loginField: some View {
        
        LoginBlock{ account, password in
            self.account = account
            self.password = password
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
                    isLoggedIn = true
                    
                    //MoodleManager.shared.Test()
                } else {
                    // 登入失敗
                    print("Login failed")
                    alertType = .loginFailure
                }
                
                isLoading = false
            }
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

struct MoodleLoginView_Previews: PreviewProvider {
    static var previews: some View {
        MoodleLoginView()
    }
}
