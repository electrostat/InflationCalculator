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


