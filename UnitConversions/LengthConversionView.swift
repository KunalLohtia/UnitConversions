//
//  LengthConversionView.swift
//  UnitConversions
//
//  Created by Kunal L on 5/7/24.
//

import SwiftUI

struct LengthConversionView: View {
    @State private var amount = 0.0
    @State private var initialUnits = "Meters"
    @State private var conversion = ""
    @State private var result: String?
    
    // setting focus state to hide keyboard as needed
    @FocusState private var amountIsFocused: Bool
    
    // Function to convert initial input to base unit of meters
    func convertToMeters(units: String, val: Double) -> Double {
        switch units {
        case "Kilometers":
            return val * 1000
        case "Miles":
            return val * 1609.34
        case "Yards":
            return val * 0.9144
        case "Feet":
            return val * 0.3048
        default:
            return val
        }
    }
    
    // taking meters and converting to desired unit
    func convertFromMeters(amountInMeters: Double, to units: String) -> Double {
        switch units {
        case "Kilometers":
            return amountInMeters / 1000
        case "Miles":
            return amountInMeters / 1609.34
        case "Yards":
            return amountInMeters / 0.9144
        case "Feet":
            return amountInMeters / 0.3048
        default:
            return amountInMeters
        }
    }
    
    // calling the above functions and formatting
    func convertLength() {
        let amountInMeters = convertToMeters(units: initialUnits, val: amount)
        let output = convertFromMeters(amountInMeters: amountInMeters, to: conversion)
        result = String(format: "%.2f", output)
    }
    
    var body: some View {
        Form {
            Section("Enter Initial Amount") {
                HStack {
                    TextField("Amount", value: $amount, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    Picker("Units", selection: $initialUnits) {
                        Text("Meters").tag("Meters")
                        Text("Kilometers").tag("Kilometers")
                        Text("Feet").tag("Feet")
                        Text("Yards").tag("Yards")
                        Text("Miles").tag("Miles")
                        
                    }
                    .font(.system(size: 15))
                    .foregroundColor(.gray)
                    .labelsHidden()
                }
            }
            
            Section("What would you like to convert it to?"){
                Picker("Select Unit", selection: $conversion){
                    Text("Meters").tag("Meters")
                    Text("Kilometers").tag("Kilometers")
                    Text("Feet").tag("Feet")
                    Text("Yards").tag("Yards")
                    Text("Miles").tag("Miles")
                }
                .pickerStyle(InlinePickerStyle())
                .labelsHidden()
                
                Button(action: {
                        convertLength()
                    }) {
                        Text("Convert")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .buttonStyle(PlainButtonStyle())
            }
            
            
            
            Section {
                if let result = result {
                    Text("\(result) \(conversion)")
                }
                Button(action: {
                                result = nil // Clear the result
                            }) {
                                Text("Clear Results")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.red)
                                    .cornerRadius(10)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
            .navigationTitle("Length Conversions")
            // toolbar modifier specifies toolbar items
            // for a view
            .toolbar {
                // if amount is focused is true,
                // click done to set amount is focused to
                // false
                if amountIsFocused{
                    Button("Done"){
                        amountIsFocused = false
                    }
                }
            }
            }
        }
    }


#Preview {
    LengthConversionView()
}
