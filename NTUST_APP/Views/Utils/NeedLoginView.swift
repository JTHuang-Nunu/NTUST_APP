//
//  NeedLoginView.swift
//  NTUST_APP
//
//  Created by Cheng Pong Huang on 2023/6/12.
//

import SwiftUI

protocol NeedLoginView: View{
    var loginType: LoginType { get }
    var showLoginView: Binding<Bool> { get set }
    func MainBody() -> AnyView
}

extension NeedLoginView{
    var body: some View {
        MainBody()
            .onAppear{
                switch loginType {
                case .Moodle:
                    if !MoodleManager.shared.login_status{
                        showLoginView.wrappedValue = true
                    }
                case .NTUST:
                    if !NTUSTSystemManager.shared.login_status{
                        showLoginView.wrappedValue = true
                    }
                }
            }
            .sheet(isPresented: showLoginView){
                LoginView(loginType: loginType)
            }
    }
}

