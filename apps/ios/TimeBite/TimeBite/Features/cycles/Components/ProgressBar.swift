//
//  ProgressBar.swift
//  TimeBite
//
//  Created by Erin Jerri on 3/27/26.
//

import SwiftUI

struct ProgressBar: View {
    let progress: Double
    let tint: Color

    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 999, style: .continuous)
                    .fill(Color(.systemGray5))

                RoundedRectangle(cornerRadius: 999, style: .continuous)
                    .fill(tint)
                    .frame(width: max(proxy.size.width * progress, 8))
            }
        }
        .frame(height: 10)
    }
}
