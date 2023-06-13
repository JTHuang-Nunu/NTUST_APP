//
//  AccountView.swift
//  NTUST_APP
//
//  Created by Cheng Pong Huang on 2023/6/8.
//

import SwiftUI

struct AccountView: View {
    @StateObject var moodleManager = MoodleManager.shared
    @StateObject var ntustManager = NTUSTSystemManager.shared
    var moodle: some View{
        NavigationLink(destination: LoginView(loginType: .Moodle)){
            HStack{
                Text("Moodle")
                    .foregroundColor(.black)
                Spacer()
                if moodleManager.login_status{
                    Text("已登入")
                        .foregroundColor(.green)
                }
                    else{
                        Text("未登入")
                            .foregroundColor(.red)
                }
            }
        }
    }
    var ntust: some View{
        NavigationLink(destination: LoginView(loginType: .NTUST)){
            HStack{
                Text("NTUST")
                    .foregroundColor(.black)
                Spacer()
                if ntustManager.login_status{
                    Text("已登入")
                        .foregroundColor(.green)
                }
                    else{
                        Text("未登入")
                            .foregroundColor(.red)
                }
            }
        }
    }
    
    var body: some View {
        Form{
            moodle
            ntust
        }
        .navigationTitle("Account")
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
