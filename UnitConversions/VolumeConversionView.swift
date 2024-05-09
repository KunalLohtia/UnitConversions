//
//  VolumeConversionView.swift
//  UnitConversions
//
//  Created by Kunal L on 5/7/24.
//

import SwiftUI

struct VolumeConversionView: View {
    @State private var amount = 0.0
    @State private var initialUnits = "Milliliters"
    @State private var conversion = ""
    @State private var result: String?
    
    // setting focus state to hide keyboard as needed
    @FocusState private var amountIsFocused: Bool
    
    // Function to convert initial input to base unit of milliliters
    func convertToML(units: String, val: Double) -> Double {
        switch units {
        case "Liters":
            return val * 1000
        case "Cups":
            return val * 236.588
        case "Pints":
            return val * 473.176
        case "Gallons":
            return val * 3785.41
        default:
            return val
        }
    }
    
    // taking milliliters and converting to desired unit
    func convertFromML(amountInML: Double, to units: String) -> Double {
        switch units {
        case "Liters":
            return amountInML / 1000
        case "Cups":
            return amountInML / 236.588
        case "Pints":
            return amountInML / 473.176
        case "Gallons":
            return amountInML / 3785.41
        default:
            return amountInML
        }
    }
    
    // calling the above functions and formatting
    func convertVol() {
        let amountInML = convertToML(units: initialUnits, val: amount)
        let output = convertFromML(amountInML: amountInML, to: conversion)
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
                        Text("Milliliters").tag("Milliliters")
                        Text("Liters").tag("Liters")
                        Text("Cups").tag("Cups")
                        Text("Pints").tag("Pints")
                        Text("Gallons").tag("Gallons")
                        
                    }
                    .font(.system(size: 15))
                    .foregroundColor(.gray)
                    .labelsHidden()
                }
            }
            
            Section("What would you like to convert it to?"){
                Picker("Select Unit", selection: $conversion){
                    Text("Milliliters").tag("Milliliters")
                    Text("Liters").tag("Liters")
                    Text("Cups").tag("Cups")
                    Text("Pints").tag("Pints")
                    Text("Gallons").tag("Gallons")
                }
                .pickerStyle(InlinePickerStyle())
                .labelsHidden()
                
                Button(action: {
                        convertVol()
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
            .navigationTitle("Volume Conversions")
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
    VolumeConversionView()
}
