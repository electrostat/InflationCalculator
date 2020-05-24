//
//  ReadCsv.swift
//  InflationCalculator
//
//  Created by Anthony Agby on 5/23/20.
//  Copyright © 2020 AgbyTech. All rights reserved.
//

import Foundation

func retrieveInflationData(csvFileName: String, csvFileExtension: String) -> [String : [String : Double]] {
    var data = readDataFromCSV(fileName: csvFileName, fileType: csvFileExtension)
    data = cleanRows(file: data!)
    
    return csvToDictionary(data: data!)
}

func readDataFromCSV(fileName:String, fileType: String)-> String!{
    guard let filepath = Bundle.main.path(forResource: fileName, ofType: fileType)
        else {
            return nil
    }
    do {
        var contents = try String(contentsOfFile: filepath, encoding: .utf8)
        contents = cleanRows(file: contents)
        return contents
    } catch {
        print("File Read Error for file \(filepath)")
        return nil
    }
}

func cleanRows(file:String)->String{
    var cleanFile = file
    cleanFile = cleanFile.replacingOccurrences(of: "\r", with: "\n")
    cleanFile = cleanFile.replacingOccurrences(of: "\n\n", with: "\n")
    return cleanFile
}

func csvToDictionary(data: String) -> [String : [String : Double]] {
    var years: [String : [String : Double]] = [:]
    
    let rows = data.components(separatedBy: "\n")
    for row in rows {
        let columns = row.components(separatedBy: ",")
        years[columns[0]] = generateYear(columns: columns)
    }
            
    return years
}

func generateYear(columns: [String]) -> [String : Double] {
    var thisYear: [String : Double] = [:]

    let months = ["jan","feb","mar","apr","may","jun","jul","aug","sep","oct","nov","dec"]
    
    for n in 1...12 {
        thisYear[months[n-1]] = Double(columns[n]) ?? 0.0
    }
    
    return thisYear
}

struct Months {
    var jan = "jan"
    var feb = "feb"
    var mar = "mar"
    var apr = "apr"
    var may = "may"
    var jun = "jun"
    var jul = "jul"
    var aug = "aug"
    var sep = "sep"
    var oct = "oct"
    var nov = "nov"
    var dec = "dec"
}
