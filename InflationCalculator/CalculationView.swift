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
    let inflationData = retrieveInflationData(csvFileName: "CPIData_1913_2020", csvFileExtension: "csv")
    
    print(inflationData)
    
    let jan1987 = inflationData["1987"]?["jan"]
    let mar2020 = inflationData["2020"]?["mar"]
    
    calculateInflationRate(cpi1: jan1987 ?? 0.0, cpi2: mar2020 ?? 0.0)
    
    let newPrice = calcPrice(startingPrice: 100.00, startCPI: jan1987 ?? 0.0, endCPI: mar2020 ?? 0.0)
    print(String(format: "$%.2f", newPrice))
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
