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
    @State private var markers: [Marker] = []
    @State private var selectedMarker: Marker? = nil
    @State private var offset = CGSize.zero
    @State private var draggingOffset = CGSize.zero
    @State private var ntust_map: UIImage? = UIImage(named: "ntust_map")
    
    var body: some View {
        VStack(spacing: 0) {
            MapContent(ntustMap: ntust_map, markers: $markers, selectedMarker: $selectedMarker, offset: $offset, draggingOffset: $draggingOffset)
                .clipped()
            MarkerInfoView(marker: selectedMarker)
        }
    }
}

struct MapContent: View {
    let ntustMap: UIImage?
    @Binding var markers: [Marker]
    @Binding var selectedMarker: Marker?
    @Binding var offset: CGSize
    @Binding var draggingOffset: CGSize
    
    var body: some View {
        if let image = ntustMap {
            Image(uiImage: image)
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
                    markers = Array(repeating: Marker(position: .zero), count: 5)
                    for i in markers.indices {
                        markers[i] = Marker(position: CGPoint(x: CGFloat.random(in: 0...1), y: CGFloat.random(in: 0...1)))
                    }
                }
        } else {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .background(Color(UIColor.secondarySystemBackground))
        }
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

struct MarkerInfoView: View {
    var marker: Marker?
    
    var body: some View {
        VStack {
            Text("Marker's Location")
                .font(.title)
            if let marker = marker {
                Text("Latitude: \(marker.position.y), Longitude: \(marker.position.x)")
            } else {
                Text("No marker selected")
            }
        }
        .padding()
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
