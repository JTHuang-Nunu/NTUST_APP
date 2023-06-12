//
//  ScoreView.swift
//  NTUST_APP
//
//  Created by Jimmy on 2023/6/10.
//

import SwiftUI
import os

struct ScoreView: View{
    @State var scores: [Score]? = nil
    @StateObject var ntustManager = NTUSTSystemManager.shared
    @State var showLoginView = false
    
    private let logger = Logger(subsystem: "NTUSTSystem", category: "ScoreView")
    
    var body: some View{
        Group{
            if ntustManager.login_status{
                content
            }else{
                NeedLoginView(RequireLoginType: .NTUST){
                    showLoginView = true
                }
            }
        }
        .sheet(isPresented: $showLoginView){
            LoginView(loginType: .NTUST)
        }
    }
    
    
    var content: some View{
        Group{
            if scores == nil{
                ProgressView()
                    .task{
                        loadScores()
                    }
            }else{
                ScoreListView(scores: scores!)
            }
        }
        .navigationTitle("學期成績")
    
    }
    
    func loadScores(){
        //assert (NTUSTSystemManager.shared.login_status)
        NTUSTSystemManager.shared.GetNtustScore{ success, scores in
            if success{
                self.scores = scores
            }else{
                self.scores = nil
                print("GetNtustScore Error")
            }
        }
    }
}

struct ScoreListView: View {
    let scores: [Score]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(scores, id: \.academic_year) { score in
                    CardView(score: score)
                }
            }
            .padding(.horizontal, 16)
        }
    }
}

struct CardView: View {
    let score: Score
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("\(String(score.academic_year))學年度")
                .font(.headline)
                .foregroundColor(.white)
                .padding(.vertical, 8)
                .frame(maxWidth: .infinity)
                .background(Color.blue)
            
            Text("平均分數：\(score.average_score, specifier: "%.2f")")
                .padding(.horizontal, 8)
            Text("累計平均分數：\(score.average_score_cumulative, specifier: "%.2f")")
                .padding(.horizontal, 8)
            Text("班級排名：\(score.class_rank)")
                .padding(.horizontal, 8)
            Text("班級累計排名：\(score.class_rank_cumulative)")
                .padding(.horizontal, 8)
            Text("系內排名：\(score.department_rank)")
                .padding(.horizontal, 8)
            Text("系內累計排名：\(score.department_rank_cumulative)")
                .padding(.horizontal, 8)
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray.opacity(0.4), lineWidth: 1)
        )
        .padding(.horizontal, 16)
        .padding(.top, 16)
    }

}



struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreView()
    }
}
