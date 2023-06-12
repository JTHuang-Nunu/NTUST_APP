
/*
 "sno": "500101024",
 "sna": "YouBike2.0_臺灣科技大學正門",

 "sno": "500101025",
 "sna": "YouBike2.0_臺灣科技大學側門",

 "sno": "500101026",
 "sna": "YouBike2.0_公館公園",

 "sno": "500101027",
 "sna": "YouBike2.0_臺灣科技大學後門",

 "sno": "500101028",
 "sna": "YouBike2.0_臺大醫學院附設癌醫中心",
 */

import SwiftUI

class BikeStationViewModel: ObservableObject {
    @Published var bike_stations: [BikeStation] = []
    @Published var isLoading = true
    
    func fetchBikeStations(ntust_sno: [String]) {
        let group = DispatchGroup()
        
        for sno in ntust_sno {
            group.enter()
            
            YouBikeManager.shared.GetBikeStationBySno(sno: sno) { bike_station in
                DispatchQueue.main.async {
                    if let bikeStation = bike_station {
                        self.bike_stations.append(bikeStation)
                    }
                    group.leave()
                }
            }
        }
        
        group.notify(queue: DispatchQueue.main) {
            self.isLoading = false
        }
    }
}

struct YoubikeView: View {
    @StateObject var viewModel = BikeStationViewModel()
    var ntust_sno: [String] = ["500101024", "500101025", "500101026", "500101027", "500101028"]
    
    var body: some View {
        VStack(spacing: 20) {
            if viewModel.isLoading {
                ProgressView()
            } else if viewModel.bike_stations.isEmpty {
                Text("沒有資料")
                    .font(.title)
            } else {
                ScrollView {
                    LazyVStack(spacing: 20) {
                        ForEach(viewModel.bike_stations, id: \.sno) { bikeStation in
                            BikeStationInfoView(bikeStation: bikeStation)
                                .padding(10) // Add padding to create spacing between cards
                        }
                    }
                    .padding()
                }
            }
        }
        .onAppear {
            YouBikeManager.shared.startDataUpdates()
            viewModel.fetchBikeStations(ntust_sno: ntust_sno)
        }
        .navigationBarTitle("台科附近的YouBike", displayMode: .inline)
    }
}

struct BikeStationInfoView: View {
    let bikeStation: BikeStation
    
    var body: some View {
        VStack {
            Text(bikeStation.sna.replacingOccurrences(of: "YouBike2.0_", with: ""))
                .font(.title)
                .fontWeight(.bold) // Make title bold
                .foregroundColor(.white)
            Spacer()

            HStack {
                InfoItemView(title: "目前車輛數量", value: "\(bikeStation.sbi)")
                Spacer()
                InfoItemView(title: "空位數量", value: "\(bikeStation.bemp)")
            }
            .background(Color.white) // Add a white background to the text
        }
        .padding()
        .frame(width: 300, height: 200) // 指定卡片的寬度和高度
        .background(
            ZStack {
                Image("youbike_台科側門") // Add an image as the background
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.black.opacity(0.3)) // Add a semi-transparent layer above the image
            }
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(color: Color.gray.opacity(0.4), radius: 4, x: 0, y: 2)
        )
    }
}

struct InfoItemView: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.headline)
                .foregroundColor(.gray)
            Text(value)
                .font(.subheadline)
                .foregroundColor(.black)
        }
    }
}

struct YoubikeView_Previews: PreviewProvider {
    static var previews: some View {
        YoubikeView()
    }
}
