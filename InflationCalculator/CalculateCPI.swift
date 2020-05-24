//
//  CalculateCPI.swift
//  InflationCalculator
//
//  Created by Anthony Agby on 5/24/20.
//  Copyright © 2020 AgbyTech. All rights reserved.
//

import Foundation

func calculateInflationRate(cpi1:Double, cpi2:Double) -> Double {
    return 100 * ((cpi2 - cpi1)/cpi1)
}

//calculate new prices in a forwards direction (older year to a more recent year)
//1970 Price x (2011 CPI / 1970 CPI) = 2011 Price
func calcPrice(startingPrice : Double, startCPI: Double, endCPI: Double) -> Double {
    return startingPrice * (endCPI/startCPI)
}
