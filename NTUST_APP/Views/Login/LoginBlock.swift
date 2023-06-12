//
//  LoginBlock.swift
//  NTUST_APP
//
//  Created by Cheng Pong Huang on 2023/6/11.
//

import SwiftUI

class LoginState: ObservableObject {
    @Published var isTryingLogin = false
}


struct LoginBlock: View {
    @State private var account: String = ""
    @State private var password: String = ""
    @EnvironmentObject var loginState: LoginState
    
    public let action: (String, String) -> Void
    var body: some View {
        VStack {
            TextField("帳號", text: $account)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)
                .padding(.horizontal, 20)
            
            SecureField("密碼", text: $password)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
            LoginButton
                .disabled(loginState.isTryingLogin)
        }
    }
    var LoginButton: some View {
        Button{
            action(account, password)
        }label: {
            if loginState.isTryingLogin{
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .frame(width: 200, height: 50)
                    .background(Color(.systemBlue))
                    .cornerRadius(10)
            }
            else{
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

}

struct LoginBlock_Previews: PreviewProvider {
    static var previews: some View {
        LoginBlock{ account, password in
            
            print("Login Button Pressed")
        }
        .environmentObject(LoginState())
    }
}
