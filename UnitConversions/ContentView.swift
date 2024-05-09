//
//  ContentView.swift
//  UnitConversions
//
//  Created by Kunal L on 5/7/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            VStack {
                Text("Welcome to the Unit Conversions App!")
                    .padding()
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding()
                
                Text("Select what type of conversions you want to do")
                    .padding()
                    .multilineTextAlignment(.center)
                    .padding()
                
                NavigationLink(destination: TempConversionView()) {
                    HStack {
                        Image(systemName: "thermometer")
                            .imageScale(.large)
                            .padding(.trailing, 5)
                        Text("Temperature Conversions")
                            .fontWeight(.bold)
                            .font(.system(size: 20))
                    }
                    .padding()
                    .frame(width: 400, height: 50)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                
                NavigationLink(destination: LengthConversionView()) {
                    HStack {
                        Image(systemName: "ruler")
                            .imageScale(.large)
                            .padding(.trailing, 5)
                        Text("Length Conversions")
                            .fontWeight(.bold)
                            .font(.system(size: 20))
                    }
                    .padding()
                    .frame(width: 400, height: 50)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                
                NavigationLink(destination: TimeConversionView()) {
                    HStack {
                        Image(systemName: "clock")
                            .imageScale(.large)
                            .padding(.trailing, 5)
                        Text("Time Conversions")
                            .fontWeight(.bold)
                            .font(.system(size: 20))
                    }
                    .padding()
                    .frame(width: 400, height: 50)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                
                NavigationLink(destination: VolumeConversionView()) {
                    HStack {
                        Image(systemName: "cube")
                            .imageScale(.large)
                            .padding(.trailing, 5)
                        Text("Volume Conversions")
                            .fontWeight(.bold)
                            .font(.system(size: 20))
                    }
                    .padding()
                    .frame(width: 400, height: 50)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                
                Spacer()
            }
            
        }
        .navigationBarTitle("Home")
        .navigationBarHidden(true)
    }
}

#Preview {
    ContentView()
}
