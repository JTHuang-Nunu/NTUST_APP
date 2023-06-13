
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
    @Published var isRefreshing = false
    
    //fetch youbike 的資料
    func fetchBikeStations(ntust_sno: [String]) {
        //dispatch group
        let group = DispatchGroup()
        
        //將需要的 sno 來去查詢
        for sno in ntust_sno {
            group.enter()
            
            //取得資訊
            YouBikeManager.shared.GetBikeStationBySno(sno: sno) { bike_station in
                DispatchQueue.main.async {
                    if let bikeStation = bike_station {
                        self.bike_stations.append(bikeStation)
                        print(bikeStation.sna)
                        print(bikeStation.sbi)
                        print(bikeStation.bemp)
                    }
                    group.leave()
                }
            }
        }
        
        //改變 state
        group.notify(queue: DispatchQueue.main) {
            self.isLoading = false
            self.isRefreshing = false
        }
    }
}

struct YoubikeView: View {
    @StateObject var viewModel = BikeStationViewModel()
    var ntust_sno: [String] = ["500101024", "500101025", "500101026", "500101027", "500101028"] //ntust 的 manager
    
    var body: some View {
        VStack(spacing: 20) {
            if viewModel.isRefreshing {
                ProgressView()
            } else if viewModel.isLoading {
                ProgressView()
            } else if viewModel.bike_stations.isEmpty {
                Text("沒有資料")
                    .font(.title)
            } else {
                ScrollView {
                    LazyVStack(spacing: 20) {
                        ForEach(viewModel.bike_stations, id: \.sno) { bikeStation in
                            BikeStationInfoView(bikeStation: bikeStation, imageName: bikeStation.sna.replacingOccurrences(of: "YouBike2.0_", with: "").appending("_圖片"))
                                .padding(10)
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
        .navigationBarItems(trailing:       //navigation 新增重整 button
            Button(action: {
                viewModel.bike_stations = []
                viewModel.isRefreshing = true
                viewModel.fetchBikeStations(ntust_sno: ntust_sno)
            }) {
                Image(systemName: "arrow.clockwise")
                    .resizable()
                    .frame(width: 20, height: 20)
            }
        )
    }
}


struct BikeStationInfoView: View {
    let bikeStation: BikeStation
    let imageName: String
    @State private var isSheetPresented = false // Add this line
    
    var body: some View {
        VStack(alignment: .center) {
            Text(bikeStation.sna.replacingOccurrences(of: "YouBike2.0_", with: ""))
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .padding([.horizontal, .bottom], 10)

            Spacer()

            HStack(spacing: 5) {
                InfoItemView(title: "車輛數量", value: "\(bikeStation.sbi)")
                Text("|")
                    .foregroundColor(.gray)
                InfoItemView(title: "空位數量", value: "\(bikeStation.bemp)")
            }
            .background(Color.white)
            .cornerRadius(15)
        }
        .padding()
        .frame(width: 300, height: 200)
        .background(
            ZStack {
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.black.opacity(0.3))
            }
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(color: Color.gray.opacity(0.4), radius: 4, x: 0, y: 2)
        )
        .onTapGesture {
            self.isSheetPresented = true
        }
        .sheet(isPresented: $isSheetPresented) {
            Text("地址: \(bikeStation.ar)")
                .padding()
            .toggleStyle(.automatic)
            .presentationDetents([.height(100)])
        }
    }
}



struct InfoItemView: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack() {
            Text(title)
                .font(.headline)
                .foregroundColor(.black)
                .padding(.horizontal)
                .padding(.vertical, 2)
            Text(value)
                .font(.subheadline)
                .foregroundColor(.black)
                .padding(.horizontal)
        }
        .padding(.vertical ,5)
    }
}

struct YoubikeView_Previews: PreviewProvider {
    static var previews: some View {
        YoubikeView()
    }
}
