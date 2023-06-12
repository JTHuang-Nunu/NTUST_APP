//
//  LoginView.swift
//  NTUST_APP
//
//  Created by Cheng Pong Huang on 2023/5/31.
//

import SwiftUI

struct NTUSTLoginView: View {
    @Environment(\.dismiss) var dismiss
    @State private var loginSuccess: Bool = false
    @StateObject private var loginState = LoginState()
    @State private var showAlert: AlertInfo? = nil
    
    
    var body: some View {
        VStack {
            Spacer()
            IconTitle
            Spacer()
            if loginSuccess{
                LoginCompleteView()
            }else{
                loginField
            }
            Spacer()
        }
        .alert(item: $showAlert) { alertType in
            Alert(
                title: Text(alertType.title),
                message: Text(alertType.message),
                dismissButton: .default(Text("確定"))
            )

        }

    }
    
    var IconTitle: some View {
        VStack {
            Image("NTUST_Icon")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .padding(.bottom, 20)
            
            Text("NTUST系統登入")
                .font(.system(size: 30))
                .foregroundColor(Color(hue: 0.65, saturation: 0.132, brightness: 0.454))
                .bold()
                .padding(.bottom, 20)
        }
    }
    
    var loginField: some View {
        
        LoginBlock{ account, password in
            loginState.isTryingLogin = true
            print("Login Button Pressed")
            //收起小鍵盤
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            
            if account.isEmpty || password.isEmpty
            {
                showAlert = loginFailedAlert
                loginState.isTryingLogin = false
                return
            }
            
            
            NTUSTSystemManager.shared.Login(Account: account, Password: password) { success in
                if success {
                    loginSuccess = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                        dismiss()
                    }
                } else {
                    // 登入失敗
                    showAlert = loginFailedAlert
                }
                
                loginState.isTryingLogin = false
            }
        }
        .environmentObject(loginState)
    }
    var loginFailedAlert: AlertInfo{
        AlertInfo(title: "登入失败", message: "請檢查帳號密碼")
    }
    
}

struct NTUSTLoginView_Previews: PreviewProvider {
    static var previews: some View {
        NTUSTLoginView()
    }
}
