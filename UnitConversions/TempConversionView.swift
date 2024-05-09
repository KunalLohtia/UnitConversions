//
//  TempConversionView.swift
//  UnitConversions
//
//  Created by Kunal L on 5/7/24.
//

import SwiftUI

struct TempConversionView: View {
    @State private var amount = 0.0
    @State private var initialUnits = ""
    @State private var conversion = ""
    @State private var result: String?
    
    // setting focus state to hide keyboard as needed
    @FocusState private var amountIsFocused: Bool
    
    // Function to convert temperature
    func convertTemperature() {
        let inputTemperature = amount
        let outputTemperature: Double
        
        let initialUnitsTrimmed = initialUnits.trimmingCharacters(in: .whitespacesAndNewlines)
        let conversionTrimmed = conversion.trimmingCharacters(in: .whitespacesAndNewlines)
        
        switch (initialUnitsTrimmed, conversionTrimmed) {
        case ("Fahrenheit", "Celsius"):
            outputTemperature = (inputTemperature - 32) * (5/9)
        case ("Celsius", "Fahrenheit"):
            outputTemperature = (inputTemperature * (9/5)) + 32
        case ("Kelvin", "Celsius"):
            outputTemperature = inputTemperature - 273.15
        case ("Celsius", "Kelvin"):
            outputTemperature = inputTemperature + 273.15
        case ("Kelvin", "Fahrenheit"):
            outputTemperature = (inputTemperature - 273.15) * (9/5) + 32
        case ("Fahrenheit", "Kelvin"):
            outputTemperature = (inputTemperature - 32) * (5/9) + 273.15
        default:
            outputTemperature = inputTemperature
        }
        
        result = String(format: "%.2f", outputTemperature)
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
                    convertTemperature()
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
