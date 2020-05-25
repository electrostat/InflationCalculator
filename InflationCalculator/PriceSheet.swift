//
//  PriceSheet.swift
//  InflationCalculator
//
//  Created by Anthony Agby on 5/25/20.
//  Copyright © 2020 AgbyTech. All rights reserved.
//

import SwiftUI

struct PriceSheet: View {
    var currencyString: String
    var baseDate: Date
    var targetDate: Date
    
    @State var price: Double = 0.0
    @State var inflationrate: Double = 0.0
    
    
    
    var body: some View {
        VStack{
            Text(String(format: "$%.2f", price)).font(.system(size: 60))
            Text(String(format: "inflation Multiplier: %.f", inflationrate)).font(.system(size: 25))
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
            .onAppear {
                self.calculate(currencyString: self.currencyString, startDate: self.baseDate, targetDate: self.targetDate)
        }
    }
    
    func calculate(currencyString: String, startDate: Date, targetDate: Date) {
        print("calculating inflation")
        
        if(currencyString.isEmpty) {
            print("string is empty")
            //add error message around this
            return
        }
        
        print(currencyString)
        
        let currency = Double(currencyString)
        
        let inflationData = retrieveInflationData(csvFileName: "CPIData_1913_2020", csvFileExtension: "csv")
        
        let yearFormatter = DateFormatter()
        yearFormatter.dateFormat = "yyyy"
        let monthFormatter = DateFormatter()
        monthFormatter.dateFormat = "LLL"
        
        let startYear = yearFormatter.string(from: startDate)
        var startMonth = monthFormatter.string(from: startDate).lowercased()
        let endYear = yearFormatter.string(from: targetDate)
        var endMonth = monthFormatter.string(from: targetDate).lowercased()
        
        //check to keep months updated to most recent month (mar as of 5/25/20
        if (endYear == "2020") {
            endMonth = checkMonth(month: endMonth)
        }
        
        if (startYear == "2020") {
            startMonth = checkMonth(month: startMonth)
        }
        
        
        let startCPI = inflationData[startYear]?[startMonth]
        let endCPI = inflationData[endYear]?[endMonth]
        
        if (startCPI == endCPI){
            print("CPIs match")
            return
        }
        
        let rate = calculateInflationRate(cpi1: startCPI ?? 0.0, cpi2: endCPI ?? 0.0)
        let newPrice = calcPrice(startingPrice: currency!, startCPI: startCPI ?? 0.0, endCPI: endCPI ?? 0.0)
        
        
        print(String(format: "$%.2f", newPrice))
        print(String(format: "Inflation Rate: %", rate))
        
        inflationrate = rate
        price = newPrice
    }
    
}

func checkMonth(month: String) -> String {
    if(month == "jan" || month == "feb" || month == "mar") {
        return month
    } else {
        return "mar"
    }
}


struct PriceSheet_Previews: PreviewProvider {
    static var previews: some View {
        PriceSheet(currencyString: "25.00", baseDate: Date(), targetDate: Date())
    }
}
