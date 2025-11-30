//
//  ContentView.swift
//  utrack
//
//  Created by emre on 29.11.2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            VStack {
                Text("UTrack").font(.system(size: 40, weight: .semibold))
            }.frame(height: 100)
            Spacer()
            VStack{
                TextField("Email", text: .constant("")).frame(height: 30)
                Spacer()
                TextField("Password", text: .constant("")).frame(height: 30)
            }.frame(maxHeight: 100 )
            Spacer()
            VStack {
            Button(action:{}, label:{
                Text("login")
            })
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            HStack {
                Text("Already Have an Account?")
                Button(action:{}, label:{
                    Text("Register")
                })
            }
        }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
