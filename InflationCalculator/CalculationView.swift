//
//  ContentView.swift
//  InflationCalculator
//
//  Created by Anthony Agby on 4/24/20.
//  Copyright © 2020 AgbyTech. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = "MMM yyyy"
        return formatter
    }
    
    @State var currencyString: String = ""
    @State var baseDateString: String = ""
    @State var targetDateString: String = ""
    @State private var baseDate = Date()
    @State private var targetDate = Date()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Inflation Calculator")
                .frame(maxWidth: .infinity, alignment: .center)
                .font(.title)
            
            Form {
                HStack {
                    Text("$:")
                    TextField("Enter a dollar amount...", text: $currencyString)
                        .keyboardType(.numbersAndPunctuation)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                //TO DO: need to look into date range for inflation data and potentiall adjust
                DatePicker(selection: $baseDate, in: ...Date(), displayedComponents: .date) {
                    Text("Base Date")
                }

                DatePicker(selection: $targetDate, in: ...Date(), displayedComponents: .date) {
                    Text("Target Date")
                }
            }
            
            Button(action: calculate) {
                Text("Calculate")
                .padding()
                .frame(maxWidth: .infinity, alignment: .center)
                .background(Color.blue)
                .cornerRadius(10)
                .foregroundColor(.orange)
                .font(.title)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.orange, lineWidth: 5)
                )
            }
        }
    }
}

func calculate() {
    print("calculating inflation")
    
     guard let url = URL(string: "https://api.bls.gov/publicAPI/v2/timeseries/data/") else {
               print("Invalid URL")
               return
           }
    
//    // prepare json data
//    let json: String = "CUUR0000SA0"
//    let jsonData = try? JSONSerialization.data(withJSONObject: json)
    
    let jsonObj:Dictionary<String, Any> = ["seriesid": ["CUUR0000SA0"]]
    
    let data = "{\"seriesid\" : [\"CUUR0000SA0\"]}".data(using: .utf8)!
            
    
    
    
    
    
    let stringValue = "{\"seriesid\" : [\"CUUR0000SA0\"], \"startyear\" : \"1987\", \"endYear\" : \"2020\"}"
    let dict = stringValue.toDictionary()
    
    if (!JSONSerialization.isValidJSONObject(dict)) {
        print("is not a valid json object")
        print(dict)
        return
    } else {
        print(dict)
    }
    
    let jsonData = try? JSONSerialization.data(withJSONObject: dict)
        
//    var request = URLRequest(url: url)
//    request.httpMethod = "POST"
//    request.httpBody = jsonData
    
//    URLSession.shared.dataTask(with: request) {data, response, error in
//        if let data = data {
//            print(data.base64EncodedString())
//
//            if let decodedResponse = try? JSONDecoder().decode(String.self, from: data){
//                DispatchQueue.main.async {
//                    print(decodedResponse)
//                }
//
//                return
//            }
//        }
//
//        print("Fetch failed: \(error?.localizedDescription ?? "Unknown Error")")
//    }.resume()
    
    let parameters = ["seriesid": ["CUUR0000SA0", "LAUCN040010000000005"] ]
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    
    do {
        request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
    } catch let error {
        print(error.localizedDescription)
    }

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data, error == nil else {
            print(error?.localizedDescription ?? "No data")
            return
        }
        let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
        if let responseJSON = responseJSON as? [String: Any] {
            print(responseJSON)
        }
    }

    task.resume()
}

extension String{
    func toDictionary() -> NSDictionary {
        let blankDict : NSDictionary = [:]
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
            } catch {
                print(error.localizedDescription)
            }
        }
        return blankDict
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
