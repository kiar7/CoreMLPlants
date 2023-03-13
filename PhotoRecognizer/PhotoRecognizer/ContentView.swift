//
//  ContentView.swift
//  PhotoRecognizer
//
//  Created by Kiar on 14/11/22.
//
import SwiftUI

struct ContentView: View {
    @State var isPresenting: Bool = false
    @State var uiImage: UIImage?
    @State var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    @ObservedObject var classifier: ImageClassifier
    
    var body: some View
    {
        VStack
        {
            HStack
            {
                Image(systemName: "photo")
                    .onTapGesture
                {
                    let cappella = UIImpactFeedbackGenerator(style: .heavy)
                    cappella.impactOccurred()
                        isPresenting = true
                        sourceType = .photoLibrary
                }
                
                Image(systemName: "camera")
                    .onTapGesture
                {
                    let cappella = UIImpactFeedbackGenerator(style: .heavy)
                    cappella.impactOccurred()
                        isPresenting = true
                        sourceType = .camera
                }
            }
            .font(.title)
            .foregroundColor(.blue)
            
            Rectangle()
                .strokeBorder()
                .foregroundColor(.green)
                .overlay(
                    Group {
                        if (uiImage != nil)
                        {
                            Image(uiImage: uiImage!)
                                .resizable()
                                .scaledToFit()
                        }
                    }
                )
            VStack
            {
                Button(action:
                {
                    if (uiImage != nil)
                    {
                        classifier.detect(uiImage: uiImage!)
                    }
                })
                {
                    Image(systemName: "globe.europe.africa.fill")
                        .resizable().frame(width: 30, height: 30)
                        .foregroundColor(.green)
                        .font(.title)
                        
                }
                
                Group
                {
                    if let imageClass = classifier.imageClass
                    {
                        HStack
                        {
                            Text("This is: ")
                                .font(.caption)
                            Text(imageClass)
                                .bold()
                        }
                    }
                    else
                    {
                        HStack
                        {
                            Text("This is: ")
                                .font(.caption)
                                
                        }
                    }
                }
                .font(.subheadline)
                .padding()
            }
        }
        
        .sheet(isPresented: $isPresenting)
        {
            ImagePicker(uiImage: $uiImage, isPresenting:  $isPresenting, sourceType: $sourceType)
                .onDisappear{
                    if (uiImage != nil)
                    {
                        classifier.detect(uiImage: uiImage!)
                    }
                }
        }
        
        .padding()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(classifier: ImageClassifier())
    }
}
