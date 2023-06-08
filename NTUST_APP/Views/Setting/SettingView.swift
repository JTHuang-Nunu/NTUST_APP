//
//  SettingView.swift
//  NTUST_APP
//
//  Created by Cheng Pong Huang on 2023/6/3.
//

import SwiftUI

struct SettingView: View {
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
                Picker(selection: .constant(0), label: Text("Language")){
                    Text("English").tag(0)
                    Text("Chinese").tag(1)
                }
            }
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
