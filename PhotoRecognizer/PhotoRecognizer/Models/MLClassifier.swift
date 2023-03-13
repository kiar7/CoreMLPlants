//
//  MLClass.swift
//  PhotoRecognizer
//
//  Created by Kiar on 14/11/22.
//

import CoreML
import Vision
import CoreImage

struct Classifier {
    
    private(set) var results: String?
    let detectionConfidence: Float = 0.85
   
    
    mutating func detect(ciImage: CIImage)
    {
        var founded: Bool = true
        
        guard let model = try? VNCoreMLModel(for: MyImageClassifier2_1(configuration: MLModelConfiguration()).model)
        else
        {
            return
        }
        
        let request = VNCoreMLRequest(model: model)
        
        let handler = VNImageRequestHandler(ciImage: ciImage, options: [:])
        
        try? handler.perform([request])
        
        guard let results = request.results as? [VNClassificationObservation]
        else
        {
            return
        }
        
        for _ in results
        {
            let resultConfidence = results.first?.confidence ?? 0
            
            if(resultConfidence >= detectionConfidence)
            {
                _ = results.first?.identifier ?? "Nothing"
                _ = results.first?.confidence ?? 0
               founded = true
            }
            else
            {
                founded = false
            }
        }
       
            if(!founded)
            {
                self.results = "not a plants"
            }
            else
            {
                self.results = results.first?.identifier
            }
    }
}// fine classe
