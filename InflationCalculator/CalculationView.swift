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
    @State var showingDetail = false
    @State var price: Double = 0.0
    @State var rate: Double = 0.0
    
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
            
            Button(action: {
                self.showingDetail.toggle()
//                (self.price, self.rate) = calculate(currencyString: self.currencyString, startDate: self.baseDate, targetDate: self.targetDate)
            }) {
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
            }.sheet(isPresented: $showingDetail) {
                PriceSheet(currencyString: self.currencyString, baseDate: self.baseDate, targetDate: self.targetDate)
            }
        }
    }
}

//func calculate(currencyString: String, startDate: Date, targetDate: Date) -> (Double, Double) {
//    print("calculating inflation")
//
//    if(currencyString.isEmpty) {
//        print("string is empty")
//        //add error message around this
//        return (0, 0)
//    }
//
//    print(currencyString)
//
//    let currency = Double(currencyString)
//
//    let inflationData = retrieveInflationData(csvFileName: "CPIData_1913_2020", csvFileExtension: "csv")
//
//    let yearFormatter = DateFormatter()
//    yearFormatter.dateFormat = "yyyy"
//    let monthFormatter = DateFormatter()
//    monthFormatter.dateFormat = "LLL"
//
//    let startYear = yearFormatter.string(from: startDate)
//    let startMonth = monthFormatter.string(from: startDate).lowercased()
//    let endYear = yearFormatter.string(from: targetDate)
//    let endMonth = monthFormatter.string(from: targetDate).lowercased()
//
//
//    let startCPI = inflationData[startYear]?[startMonth]
//    let endCPI = inflationData[endYear]?[endMonth]
//
//    if (startCPI == endCPI){
//        print("CPIs match")
//        return (0, 0)
//    }
//
//    let rate = calculateInflationRate(cpi1: startCPI ?? 0.0, cpi2: endCPI ?? 0.0)
//    let newPrice = calcPrice(startingPrice: currency!, startCPI: startCPI ?? 0.0, endCPI: endCPI ?? 0.0)
//
//
//    print(String(format: "$%.2f", newPrice))
//    print(String(format: "Inflation Rate: %", rate))
//
//    return (newPrice, rate)
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
