//
//  SettingView.swift
//  NTUST_APP
//
//  Created by Cheng Pong Huang on 2023/6/3.
//

import SwiftUI

struct SettingView: View {
    @AppStorage("UseFaceID") var UseFaceID: Bool = false
    var body: some View {
        NavigationStack{
            settingForm
                .navigationBarTitle("Setting")
        
        }
    }
    var settingForm: some View{
        Form{
            // do switching language using picker
            Section(header: Text("General")){
                
                Toggle(isOn: $UseFaceID, label: {
                    Text("使用FaceID解鎖")
                })
                
            }
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}

class LoginSetting: ObservableObject{
    @Published var UseFaceID: Bool = false
    @Published var MoodleAccount: String = ""
    @Published var MoodlePassword: String = ""
    @Published var NTUSTAccount: String = ""
    @Published var NTUSTPassword: String = ""
}
