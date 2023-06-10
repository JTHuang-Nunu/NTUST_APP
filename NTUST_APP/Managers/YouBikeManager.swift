//
//  YouBikeManager.swift
//  NTUST_APP
//
//  Created by Jimmy on 2023/6/9.
//

import Foundation

struct BikeStation: Codable {
    let sno: String       // 站點代號
    let sna: String       // 場站中文名稱
    let tot: String       // 場站總停車格
    let sbi: String       // 場站目前車輛數量
    let sarea: String     // 場站區域
    let mday: String      // 資料更新時間
    let lat: Double       // 緯度
    let lng: Double       // 經度
    let ar: String        // 地點
    let sareaen: String   // 場站區域英文
    let snaen: String     // 場站名稱英文
    let aren: String      // 地址英文
    let bemp: String      // 空位數量
    let act: String       // 全站禁用狀態
    let srcUpdateTime: String // 資料來源更新時間 (這個沒有在你的註解列表中，我猜可能是資料來源更新時間)
    let updateTime: String // 資料更新時間 (這個沒有在你的註解列表中，我猜可能是資料更新時間)
    let infoTime: String  // 資訊時間 (這個沒有在你的註解列表中，我猜可能是資訊時間)
    let infoDate: String  // 資訊日期 (這個沒有在你的註解列表中，我猜可能是資訊日期)
}

class YouBikeManager{
    
    //YouBike Manager Singleton
    static let shared = YouBikeManager()
    
    private func getAllData(completion: @escaping (Bool, [BikeStation]?) -> Void){
        let url = URL(string: "https://tcgbusfs.blob.core.windows.net/dotapp/youbike/v2/youbike_immediate.json")!

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
                completion(false, nil)
            } else if let data = data {
                let decoder = JSONDecoder()
                do {
                    let bikeStations = try decoder.decode([BikeStation].self, from: data)
                    // now you can use the bikeStations array
                    for station in bikeStations {
                        print(station.sna)
                    }
                    completion(false, bikeStations)
                } catch {
                    print("Error decoding JSON: \(error)")
                    completion(false, nil)
                }
            }
        }

        task.resume()
    }
    
}
