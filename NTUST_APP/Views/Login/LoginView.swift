//
//  LoginView.swift
//  NTUST_APP
//
//  Created by Cheng Pong Huang on 2023/6/12.
//

import SwiftUI

enum LoginType {
    case NTUST
    case Moodle
}

struct LoginView: View {
    @State var loginType: LoginType
    var body: some View {
        VStack{
            switch loginType {
            case .NTUST:
                NTUSTLoginView()
            case .Moodle:
                MoodleLoginView()
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(loginType: .NTUST)
    }
}
