//
//  RootView.swift
//  TimeBite
//
//  Created by Erin Jerri on 3/27/26.
//
import SwiftUI

struct RootView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
           VStack {
               Button("Start Engineering") {
                   appState.engine.start(category: "engineering")
               }

               Button("Stop") {
                   appState.engine.stop()
               }

               ForEach(appState.engine.categories.keys.sorted(), id: \.self) { key in
                   Text("\(key): \(appState.engine.categories[key]!)")
               }
           }
       }
}
