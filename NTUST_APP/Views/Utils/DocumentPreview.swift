//
//  DocumentPreview.swift
//  NTUST_APP
//
//  Created by Jimmy on 2023/6/13.
//

import SwiftUI
import QuickLook

struct DocumentPreview: View {
    let url: URL
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        
        QLPreview(url: url)
            .navigationBarTitle(Text(url.lastPathComponent), displayMode: .inline)
    }
}

struct QLPreview: UIViewControllerRepresentable {
    var url: URL

    func makeUIViewController(context: UIViewControllerRepresentableContext<QLPreview>) -> UIViewController {
        let controller = QLPreviewController()
        controller.dataSource = context.coordinator
        return controller
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<QLPreview>) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, QLPreviewControllerDataSource {
        var parent: QLPreview

        init(_ controller: QLPreview) {
            self.parent = controller
            super.init()
        }

        func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
            return 1
        }

        func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
            return parent.url as QLPreviewItem
        }
    }
}
