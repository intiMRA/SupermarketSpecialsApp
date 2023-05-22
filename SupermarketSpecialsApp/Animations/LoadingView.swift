//
//  LoadingView.swift
//  SupermarketSpecialsApp
//
//  Created by ialbuquerque on 22/05/23.
//

import SwiftUI
import Design_Library

struct LoadingView: View {
    var body: some View {
        LottieView(lottieFile: .jumpLoading)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
