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
    let tot: Int       // 場站總停車格
    let sbi: Int       // 場站目前車輛數量
    let sarea: String     // 場站區域
    let mday: String      // 資料更新時間
    let lat: Double       // 緯度
    let lng: Double       // 經度
    let ar: String        // 地點
    let sareaen: String   // 場站區域英文
    let snaen: String     // 場站名稱英文
    let aren: String      // 地址英文
    let bemp: Int      // 空位數量
    let act: String       // 全站禁用狀態
    let srcUpdateTime: String // 資料來源更新時間 (這個沒有在你的註解列表中，我猜可能是資料來源更新時間)
    let updateTime: String // 資料更新時間 (這個沒有在你的註解列表中，我猜可能是資料更新時間)
    let infoTime: String  // 資訊時間 (這個沒有在你的註解列表中，我猜可能是資訊時間)
    let infoDate: String  // 資訊日期 (這個沒有在你的註解列表中，我猜可能是資訊日期)
}

class YouBikeManager {
    
    // YouBike Manager Singleton
    static let shared = YouBikeManager()
    var tmp_bike_staiton_data: [BikeStation]?
    private var timer: Timer?
    /// 使用網路請求下載 YouBike 資料並解碼為 [BikeStation] 陣列
    ///
    /// - Parameter completion: 下載和解碼完成後的回呼閉包。如果成功，回傳解碼後的 [BikeStation] 陣列；如果失敗，回傳 nil。
    private func GetAllData(completion: @escaping (Bool, [BikeStation]?) -> Void) {
        let url = URL(string: "https://tcgbusfs.blob.core.windows.net/dotapp/youbike/v2/youbike_immediate.json")!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
                completion(false, nil)
            } else if let data = data {
                let decoder = JSONDecoder()
                do {
                    let bikeStations = try decoder.decode([BikeStation].self, from: data)
                    // 現在你可以使用 bikeStations 陣列
                    self.tmp_bike_staiton_data = bikeStations
                    completion(true, bikeStations)
                } catch {
                    print("Error decoding JSON: \(error)")
                    completion(false, nil)
                }
            }
        }
        
        task.resume()
    }
    
    /// 使用站點代號 `sno` 查詢站點資料
    ///
    /// - Parameters:
    ///   - sno: 站點代號
    ///   - completion: 查詢完成後的回呼閉包。如果找到符合的站點資料，回傳該站點資料；如果找不到，回傳 nil。
    public func GetBikeStationBySno(sno: String, completion: @escaping (BikeStation?) -> Void) {
        GetBikeStationData { success, bikeStations in
            if success, let bikeStations = bikeStations {
                let filteredStations = bikeStations.filter { $0.sno == sno }
                let station = filteredStations.first
                completion(station)
            } else {
                completion(nil)
            }
        }
    }
    
    public func GetBikeStationData(completion: @escaping (Bool, [BikeStation]?) -> Void) {
        if let bikeStationData = tmp_bike_staiton_data {
            completion(true, bikeStationData)
        } else {
            GetAllData(completion: completion)
        }
    }
    
    // 開始定時更新資料
    public func startDataUpdates() {
        // 每一分鐘觸發一次更新資料
        timer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { [weak self] _ in
            self?.GetAllData { _, _ in }
        }
        timer?.fire() // 立即觸發一次更新
    }

    // 停止定時更新資料
    public func stopDataUpdates() {
        timer?.invalidate()
        timer = nil
    }
    
    
    
}
