//
//  View+Extensions.swift
//  ARM
//
//  Created by Дана Муртазина on 24.05.2021.
//

import SwiftUI

extension View {
    @ViewBuilder func hidden(_ shouldHide: Bool) -> some View {
        switch shouldHide {
        case true: self.hidden()
        case false: self
        }
    }
}
