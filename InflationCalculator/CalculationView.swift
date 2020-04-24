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
            HStack {
                Text("$:")
                TextField("Enter a dollar amount...", text: $currencyString)
                    .keyboardType(.numberPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            Form {
                //TO DO: need to look into date range for inflation data and potentiall adjust
                DatePicker(selection: $baseDate, in: ...Date(), displayedComponents: .date) {
                    Text("Base Date")
                }

                DatePicker(selection: $targetDate, in: ...Date(), displayedComponents: .date) {
                    Text("Target Date")
                }
            }
        }.padding()
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
