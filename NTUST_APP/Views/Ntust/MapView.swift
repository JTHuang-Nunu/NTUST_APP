//
//  MapView.swift
//  NTUST_APP
//
//  Created by Jimmy on 2023/6/11.
//

import SwiftUI

struct Marker: Identifiable {
    let id = UUID()
    let position: CGPoint
}

struct MapView: View {
    @State private var markers: [Marker] = Array(repeating: Marker(position: .zero), count: 5)
    @State private var selectedMarker: Marker? = nil
    @State private var offset = CGSize.zero
    @State private var draggingOffset = CGSize.zero
    @State private var ntust_map: UIImage? = UIImage(named: "ntust_map")
    
    var body: some View {
        Image(uiImage:ntust_map!)
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
                    markers[i] = Marker(position: CGPoint(x: CGFloat.random(in: 0...1), y: CGFloat.random(in: 0...1)))
                }
            }
            .sheet(item: $selectedMarker, content: { marker in
                MarkerDetail(marker: marker)
            })
    }
    
    private var markersOverlay: some View {
        GeometryReader { geo in
            ForEach(markers, id: \.id) { marker in
                Image(systemName: "mappin")
                    .foregroundColor(.red)
                    .offset(x: -10, y: -25) // Offset to center the marker on the point
                    .position(x: geo.size.width * marker.position.x, y: geo.size.height * marker.position.y)
                    .onTapGesture {
                        selectedMarker = marker
                    }
            }
        }
    }
}

struct MarkerDetail: View {
    var marker: Marker
    var body: some View {
        VStack {
            Text("Marker's Location")
                .font(.title)
            Text("Latitude: \(marker.position.y), Longitude: \(marker.position.x)")
        }
        .padding()
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
