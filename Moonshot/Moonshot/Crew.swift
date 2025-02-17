//
//  Crew.swift
//  Moonshot
//
//  Created by Julia Martcenko on 04/02/2025.
//

import Foundation

struct Mission: Codable, Identifiable, Hashable {
	static func == (lhs: Mission, rhs: Mission) -> Bool {
		lhs.id == rhs.id
	}

	struct CrewRole: Codable {
		let name: String
		let role: String
	}

	let id: Int
	let launchDate: Date?
	let crew: [CrewRole]
	let description: String

	var displayName: String {
		"Apollo \(id)"
	}

	var image: String {
		"apollo\(id)"
	}

	var formattedLaunchDate: String {
		launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
	}

	func hash(into hasher: inout Hasher) {
		hasher.combine(id)
	}
}
