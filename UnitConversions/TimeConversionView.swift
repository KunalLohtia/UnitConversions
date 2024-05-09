//
//  TimeConversionView.swift
//  UnitConversions
//
//  Created by Kunal L on 5/7/24.
//

import SwiftUI

struct TimeConversionView: View {
    @State private var amount = 0.0
    @State private var initialUnits = ""
    @State private var conversion = ""
    @State private var result: String?
    
    // setting focus state to hide keyboard as needed
    @FocusState private var amountIsFocused: Bool
    
    
    // Function to convert initial input to base unit of seconds
    func convertToSeconds(units: String, val: Double) -> Double {
        switch units {
        case "Minutes":
            return val * 60
        case "Hours":
            return val * 3600
        case "Days":
            return val * 864000
        default:
            return val
        }
    }
    
    // taking seconds and converting to desired unit
    func convertFromSec(amountInSec: Double, to units: String) -> Double {
        switch units {
        case "Minutes":
            return amountInSec / 60
        case "Hours":
            return amountInSec / 3600
        case "Days":
            return amountInSec / 864000
        default:
            return amountInSec
        }
    }
    
    // calling the above functions and formatting
    func convertLength() {
        let amountInSec = convertToSeconds(units: initialUnits, val: amount)
        let output = convertFromSec(amountInSec: amountInSec, to: conversion)
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
                        Text("Seconds").tag("Seconds")
                        Text("Minutes").tag("Minutes")
                        Text("Hours").tag("Hours")
                        Text("Days").tag("Days")
                        
                    }
                    .font(.system(size: 15))
                    .foregroundColor(.gray)
                    .labelsHidden()
                }
            }
            
            Section("What would you like to convert it to?"){
                Picker("Select Unit", selection: $conversion){
                    Text("Seconds").tag("Seconds")
                    Text("Minutes").tag("Minutes")
                    Text("Hours").tag("Hours")
                    Text("Days").tag("Days")
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
            .navigationTitle("Time Conversions")
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
    TimeConversionView()
}
