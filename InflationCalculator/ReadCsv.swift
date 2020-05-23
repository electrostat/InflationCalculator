//
//  ReadCsv.swift
//  InflationCalculator
//
//  Created by Anthony Agby on 5/23/20.
//  Copyright © 2020 AgbyTech. All rights reserved.
//

import Foundation

func runTest(csvFileName: String, csvFileExtension: String) {
    var data = readDataFromCSV(fileName: csvFileName, fileType: csvFileExtension)
    print("raw data: " + data!)
    data = cleanRows(file: data!)
    let csvRows = csv(data: data!)
    print(csvRows[1][1])
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

func csv(data: String) -> [[String]] {
    var result: [[String]] = []
    let rows = data.components(separatedBy: "\n")
    print(rows)
    for row in rows {
        print(row)
        let columns = row.components(separatedBy: ",")
        result.append(columns)
    }
    return result
}
