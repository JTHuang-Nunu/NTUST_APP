//
//  NeedLoginView.swift
//  NTUST_APP
//
//  Created by Cheng Pong Huang on 2023/6/12.
//

import SwiftUI

class LoginStatus: ObservableObject {
    @Published var isLoginMoodle: Bool = MoodleManager.shared.login_status
    @Published var isLoginNTUST: Bool = NTUSTSystemManager.shared.login_status
}

struct NeedLoginView: View {
    let RequireLoginType: LoginType
    let action: () -> Void
    
    @EnvironmentObject var loginStatus: LoginStatus

    var body: some View {
        switch RequireLoginType{
        case .Moodle:
            if loginStatus.isLoginMoodle {
                EmptyView()
            } else {
                MoodleRequireView
            }
        case .NTUST:
            if loginStatus.isLoginNTUST {
                EmptyView()
            } else {
                NTUSTRequireView
            }
        }
    }
    var MoodleRequireView: some View{
        VStack{
            Text("需要Moodle系統登入")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding()
            
            Button{
                action()
            }label: {
                Text("登入")
                    .font(.body)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            
            }
        }
    }
    var NTUSTRequireView: some View{
        VStack{
            Text("需要NTUST系統登入")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding()
            
            Button{
                action()
            }label: {
                Text("登入")
                    .font(.body)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            
            }
        }
    }
}

struct NeedLoginView_Previews: PreviewProvider {
    static var previews: some View {
        NeedLoginView(RequireLoginType: .Moodle){
            print("press 登入")
        }
            .environmentObject(LoginStatus())
    
    }
}


