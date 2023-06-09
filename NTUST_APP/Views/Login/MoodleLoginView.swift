//
//  LoginView.swift
//  NTUST_APP
//
//  Created by Cheng Pong Huang on 2023/5/31.
//

import SwiftUI
import LocalAuthentication

class AlertInfo: Identifiable {
    let id = UUID()
    let title: String
    let message: String
    init(title: String, message: String) {
        self.title = title
        self.message = message
    }
}

struct MoodleLoginView: View {
    @Environment(\.dismiss) var dismiss
    @State private var loginSuccess: Bool = false
    @StateObject private var loginState = LoginState()
    @State private var showAlert: AlertInfo? = nil
    @AppStorage("UseFaceID") var useFaceID: Bool = false
    @AppStorage("MoodleAccount") var moodleAccount: String = ""
    
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
        
        LoginBlock(account: moodleAccount){ account, password in
            tryLogin(account: account, password: password)
        }
        .environmentObject(loginState)
        .onAppear{
            if useFaceID{
                let password = KeychainService.shared.retrivePassword(for: moodleAccount)
                if password != nil{
                    authenticate()
                }
            }
        }
    }
    var loginFailedAlert: AlertInfo{
        AlertInfo(title: "登入失敗", message: "請檢查帳號密碼")
    }
    private func tryLogin(account: String, password: String){
        loginState.isTryingLogin = true
        moodleAccount = account
        print("Login Button Pressed")
        //收起小鍵盤
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        
        if account.isEmpty || password.isEmpty
        {
            showAlert = loginFailedAlert
            loginState.isTryingLogin = false
            return
        }
        
        
        MoodleManager.shared.Login(Account: account, Password: password) { success in
            if success {
                withAnimation{
                    loginSuccess = true
                    loginState.isTryingLogin = false
                    KeychainService.shared.save(password, for: account)
                    moodleAccount = account
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                        dismiss()
                    }
                    
                }
                
            } else {
                // 登入失敗
                showAlert = loginFailedAlert
                loginState.isTryingLogin = false
            }
            
            
        }
    }
    private func authenticate(){
        let context = LAContext()
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
            let reason = "使用生物辨識登入"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success{
                        let password = KeychainService.shared.retrivePassword(for: moodleAccount)
                        if let password = password{
                            tryLogin(account: moodleAccount, password: password)
                        }
                    }
                }
            }
        }
        else{
            print("無法使用生物辨識")
        }
    
    }
    
}

struct MoodleLoginView_Previews: PreviewProvider {
    static var previews: some View {
        MoodleLoginView()
    }
}
