//
//  LoadingView.swift
//  SupermarketSpecialsApp
//
//  Created by ialbuquerque on 22/05/23.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        LottieView(lottieFile: .loading)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
