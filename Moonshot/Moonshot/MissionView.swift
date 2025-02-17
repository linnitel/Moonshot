//
//  MissionView.swift
//  Moonshot
//
//  Created by Julia Martcenko on 04/02/2025.
//

import SwiftUI

struct MissionView: View {
	struct CrewMember: Hashable {
		let role: String
		let astronaut: Astronaut
	}

	let mission: Mission
	let crew: [CrewMember]

	var body: some View {
		ScrollView {
			VStack {
				Image(mission.image)
					.resizable()
					.scaledToFit()
					.containerRelativeFrame(.horizontal) { width, axis in
						width * 0.6
					}


				VStack(alignment: .leading) {
					HStack {

						Text(mission.formattedLaunchDate)
							.font(.title2)
							.padding(.top, 15)
						Spacer()
					}

					CustomDividerView()

					Text("Mission Highlights")
						.font(.title.bold())
						.padding(.bottom, 5)
					Text(mission.description)

					CustomDividerView()

					Text("Crew")
						.font(.title.bold())
						.padding(.bottom, 5)
				}
				.padding(.horizontal)
				CrewView(crew: crew)
			}
			.padding(.bottom)
		}
		.navigationTitle(mission.displayName)
		.navigationBarTitleDisplayMode(.inline)
		.background(.darkBackground)
		.navigationDestination(for: CrewMember.self, destination: { crewMember in
			AstronautView(astronaut: crewMember.astronaut)
		})
	}

	init(mission: Mission, astronauts: [String: Astronaut]) {
		self.mission = mission

		self.crew = mission.crew.map { member in
			if let astronaut = astronauts[member.name] {
				return CrewMember(role: member.role, astronaut: astronaut)
			} else {
				fatalError("Missing \(member.name)")
			}
		}
	}

	struct CrewView: View {
		let crew: [CrewMember]

		var body: some View {
			ScrollView(.horizontal, showsIndicators: false) {
				HStack {
					ForEach(crew, id: \.role) { crewMember in
						NavigationLink(value: crewMember, label: {
							AstronautLabelView(crewMember: crewMember)
						})
					}
				}
			}
		}
	}

	struct AstronautLabelView: View {
		var crewMember: CrewMember

		var body: some View {
			HStack {
				Image(crewMember.astronaut.id)
					.resizable()
					.frame(width: 104, height: 72)
					.clipShape(.capsule)
					.overlay(
						Capsule()
							.strokeBorder(.white, lineWidth: 1)
					)
				VStack(alignment: .leading) {
					Text(crewMember.astronaut.name)
						.foregroundStyle(.white)
					Text(crewMember.role)
						.foregroundStyle(.white.opacity(0.5))
				}
			}
			.padding(.horizontal)
		}

	}
}

#Preview {
	let missions: [Mission] = Bundle.main.decode("missions.json")
	let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")

	MissionView(mission: missions[0], astronauts: astronauts)
		.colorScheme(.dark)
}
