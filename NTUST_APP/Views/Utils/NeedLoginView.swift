//
//  NeedLoginView.swift
//  NTUST_APP
//
//  Created by Cheng Pong Huang on 2023/6/12.
//

import SwiftUI

struct NeedLoginView: View {
    let RequireLoginType: LoginType
    let action: () -> Void
    @StateObject var moodleManager = MoodleManager.shared
    @StateObject var NTUSTManager = NTUSTSystemManager.shared

    var body: some View {
        switch RequireLoginType{
        case .Moodle:
            if moodleManager.login_status {
                EmptyView()
            } else {
                MoodleRequireView
            }
        case .NTUST:
            if NTUSTManager.login_status {
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
    
    }
}


