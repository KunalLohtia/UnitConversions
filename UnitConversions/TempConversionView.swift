//
//  TempConversionView.swift
//  UnitConversions
//
//  Created by Kunal L on 5/7/24.
//

import SwiftUI

struct TempConversionView: View {
    @State private var amount = 0.0
    @State private var initialUnits = "Fahrenheit"
    @State private var conversion = ""
    @State private var result: String?
    
    // setting focus state to hide keyboard as needed
    @FocusState private var amountIsFocused: Bool
    
    // Function to convert initial input to base unit of celsius
        func convertToCelsius(units: String, val: Double) -> Double {
            switch units {
            case "Fahrenheit":
                return (val - 32) * (5/9)
            case "Kelvin":
                return val - 273.15
            default:
                return val
            }
        }
    
    // taking celsius and converting to desired unit
    func convertFromCelsius(amountInCels: Double, to units: String) -> Double {
        switch units {
        case "Fahrenheit":
            return (amountInCels * (9/5)) + 32
        case "Kelvin":
            return amountInCels + 273.15
        default:
            return amountInCels
        }
    }
    
    // calling the above functions and formatting
    func convertTemp() {
        let amountInCels = convertToCelsius(units: initialUnits, val: amount)
        let output = convertFromCelsius(amountInCels: amountInCels, to: conversion)
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
                        Text("Fahrenheit").tag("Fahrenheit")
                        Text("Celsius").tag("Celsius")
                        Text("Kelvin").tag("Kelvin")
                    }
                    .font(.system(size: 15))
                    .foregroundColor(.gray)
                    .labelsHidden()
                }
            }
            
            Section("What would you like to convert it to?"){
                Picker("Select Unit", selection: $conversion){
                    Text("Fahrenheit").tag("Fahrenheit")
                    Text("Celsius").tag("Celsius")
                    Text("Kelvin").tag("Kelvin")
                }
                .pickerStyle(InlinePickerStyle())
                .labelsHidden()
                
                Button(action: {
                    convertTemp()
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
            .navigationTitle("Temperature Conversions")
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
    TempConversionView()
}
