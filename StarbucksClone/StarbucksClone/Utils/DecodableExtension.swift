//
//  DecodableExtension.swift
//  StarbucksClone
//
//  Created by Sarah Crowder on 11/16/23.
//

import Foundation

extension Bundle {
    func decode<T: Codable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }

        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        do {
            let loaded = try decoder.decode(T.self, from: data)
            return loaded
        } catch {
            print("Error decoding json \(error)")
            fatalError("Error decoding json")
            
        }
        
        
       
    }
    
    func decodeTemp<T: Codable>(_ file: String) -> T {
        
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        
        
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        var data = UserDefaults.standard.data(forKey: file) ?? "[]".data(using: .utf8)!
        
        if data == "[]".data(using: .utf8)! {
            print("data is empty.")
            data = "[]".data(using: .utf8)!
        }

        
        guard let loaded = try? decoder.decode(T.self, from:data ) else {
            return try! decoder.decode(T.self, from: "[]".data(using: .utf8)!)
            fatalError("Default decoding failed.")
        }
        print("decoding succeeded! yay!")

        return loaded
    }
    
    func encode<T: Codable>(_ object: T, _ file: String){
        
        let encoder = JSONEncoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        encoder.dateEncodingStrategy = .formatted(formatter)

        do {
            let jsonData = try encoder.encode(object)
            
            // Convert Data to a String for printing
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                //print(jsonString)
                UserDefaults.standard.set(jsonData, forKey: file)
                
                // If you want to print the JSON as a dictionary, you can use JSONSerialization
//                if let jsonDictionary = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
//                    print(jsonDictionary)
//                }
            } else {
                print("Failed to convert Data to String.")
            }
        } catch {
            fatalError("Encoding of object failed.")
        }

        
    }
}
