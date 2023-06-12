//
//  MapView.swift
//  NTUST_APP
//
//  Created by Jimmy on 2023/6/11.
//

import SwiftUI


struct Marker: Identifiable, Equatable {
    let id = UUID()
    var position: CGPoint
    var place_name: String
    var place_ename: String
    var picture_name: String
    
    static func == (lhs: Marker, rhs: Marker) -> Bool {
        return lhs.id == rhs.id
    }
}

struct MapView: View {
    @State private var markers: [Marker] = [Marker(position: CGPoint(x: 798, y: 950), place_name: "大門口警衛室", place_ename: "Main Gate", picture_name: "main_gate"),      //警衛室
                                            Marker(position: CGPoint(x: 598, y: 740), place_name: "第4教學大樓", place_ename: "T4", picture_name: "T4"),      //T4第四教學大樓
                                            Marker(position: CGPoint(x: 592, y: 891), place_name: "綜合研究大樓", place_ename: "RB", picture_name: "RB"),      //RB綜合研究大樓
                                            Marker(position: CGPoint(x: 201, y: 820), place_name: "研揚大樓1樓川堂販賣機旁", place_ename: "TR", picture_name: "TR"),      //TR研揚大樓
                                            Marker(position: CGPoint(x: 215, y: 615), place_name: "體育館", place_ename: "GYM", picture_name: "GYM"),      //體育館
                                            Marker(position: CGPoint(x: 317, y: 630), place_name: "健康中心", place_ename: "Health Center", picture_name: "health_center"),      //健康中心
                                            Marker(position: CGPoint(x: 466, y: 586), place_name: "學生活動中心一樓", place_ename: "Student Center 1F", picture_name: "student_center_1f"),      //學生活動中心
                                            Marker(position: CGPoint(x: 609, y: 428), place_name: "第一學生宿舍", place_ename: "Dormitory 1", picture_name: "dorm1"),      //第一宿舍
                                            Marker(position: CGPoint(x: 840, y: 435), place_name: "第二學生宿舍", place_ename: "Dormitory 2", picture_name: "dorm2"),      //第二宿舍
                                            Marker(position: CGPoint(x: 759, y: 418), place_name: "第三學生宿舍", place_ename: "Dormitory 3", picture_name: "dorm3"),      //第三學生宿舍
                                            Marker(position: CGPoint(x: 947, y: 422), place_name: "電資館", place_ename: "EE", picture_name: "EE"),      //EE電資館
                                            Marker(position: CGPoint(x: 947, y: 549), place_name: "管理學院", place_ename: "MA", picture_name: "MA"),      //MA管理大樓
                                            Marker(position: CGPoint(x: 949, y: 678), place_name: "工程二館", place_ename: "E2", picture_name: "E2"),      //E2工程二館
                                            Marker(position: CGPoint(x: 1067, y: 865), place_name: "國際大樓", place_ename: "IB", picture_name: "IB")]     //IB國際大樓
                                            
    @State private var selectedMarker: Marker? = nil
    @State private var offset = CGSize.zero
    @State private var draggingOffset = CGSize.zero
    @State private var ntust_map: UIImage? = UIImage(named: "ntust_map")
    
    var body: some View {
        if ntust_map != nil {
            Image(uiImage: ntust_map!)
                .resizable()
                .scaledToFill()
                .overlay(markersOverlay)
                .offset(x: offset.width + draggingOffset.width, y: offset.height + draggingOffset.height)
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            self.draggingOffset = gesture.translation
                        }
                        .onEnded { gesture in
                            self.offset.width += gesture.translation.width
                            self.offset.height += gesture.translation.height
                            self.draggingOffset = CGSize.zero
                        }
                )
                .onAppear {
                    for i in markers.indices {
                        markers[i].position.x = markers[i].position.x / ntust_map!.size.width + 0.01
                        markers[i].position.y = markers[i].position.y / ntust_map!.size.height + 0.02
                    }
                }
                .sheet(item: $selectedMarker, content: { marker in
                    MarkerDetail(marker: marker)
                        .presentationDetents([.height(250), .medium])
                        .toggleStyle(.button)
                })
        } else {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .background(Color(UIColor.secondarySystemBackground))
          }
    }
    
    private var markersOverlay: some View {
        GeometryReader { geo in
            ForEach(markers, id: \.id) { marker in
                let position = CGPoint(x: marker.position.x * geo.size.width, y: marker.position.y * geo.size.height)
                
                Button(action: {
                    withAnimation {
                        selectedMarker = marker
                    }
                }) {
                    Image("aed_icon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                }
                .buttonStyle(PlainButtonStyle())
                .position(position)
                .opacity(selectedMarker == marker ? 0.5 : 1.0)
            }
        }
    }


}

struct MarkerDetail: View {
    var marker: Marker
    
    var body: some View {
        HStack(spacing: 16) {
            VStack(spacing: 8){
                Text(marker.place_name)
                    .font(.title)
                    .fontWeight(.bold)
                
                Text(marker.place_ename)
                    .font(.subheadline)
            }
            
            Image(marker.picture_name)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 200, maxHeight: 200)
        }
        .padding()
        .cornerRadius(16)
        .ignoresSafeArea()
    }
}



struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
