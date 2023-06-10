//
//  ScoreView.swift
//  NTUST_APP
//
//  Created by Jimmy on 2023/6/10.
//

import SwiftUI

struct ScoreView: View {
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
        let scores = [
            Score(academic_year: 1111, average_score: 3.65, average_score_cumulative: 3.38, class_rank: 22, class_rank_cumulative: 30, department_rank: 46, department_rank_cumulative: 64),
            Score(academic_year: 1102, average_score: 3.83, average_score_cumulative: 3.36, class_rank: 23, class_rank_cumulative: 32, department_rank: 48, department_rank_cumulative: 66),
            // 其他 Score 对象
        ]

        ScoreView(scores: scores)
    }
}
