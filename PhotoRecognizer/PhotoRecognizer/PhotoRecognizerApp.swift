//
//  PhotoRecognizerApp.swift
//  PhotoRecognizer
//
//  Created by Kiar on 14/11/22.
//

import SwiftUI

@main
struct PhotoRecognizerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(classifier: ImageClassifier())
        }
    }
}
