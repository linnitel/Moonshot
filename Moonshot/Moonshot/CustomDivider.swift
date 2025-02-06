//
//  CustomDivider.swift
//  Moonshot
//
//  Created by Julia Martcenko on 06/02/2025.
//

import SwiftUI

struct CustomDividerView: View {
	var body: some View {
		Rectangle()
			.frame(height: 2)
			.foregroundStyle(.white.opacity(0.5))
			.padding(.vertical)
	}
}
