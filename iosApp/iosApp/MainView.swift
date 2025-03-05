//
//  TabBar.swift
//  iosApp
//
//  Created by Patryk Drozd on 04/03/2025.
//  Copyright © 2025 orgName. All rights reserved.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            NoteView()
                .tabItem {
                    Label("Notes", systemImage: "music.note")
                }

            IntervalView()
                .tabItem {
                    Label("Intervals", systemImage: "music.quarternote.3")
                }
            MetronomeView()
                .tabItem {
                    Label("Metronome", systemImage: "metronome")
                }
        }
    }
}
