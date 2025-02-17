//
//  ContentView.swift
//  Moonshot
//
//  Created by Julia Martcenko on 03/02/2025.
//

import SwiftUI

struct ContentView: View {
	let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
	let missions: [Mission] = Bundle.main.decode("missions.json")

	@State var isList = false
	var selectedList: String {
		isList ? "list.bullet" : "circle.grid.3x3"
	}

    var body: some View {
		NavigationStack {
			Group {
				if isList {
					GridView(missions: missions, astronauts: astronauts)
				} else {
					ListView(missions: missions, astronauts: astronauts)
				}
			}
			.navigationTitle("Moonshot")
			.background(.darkBackground)
			.toolbar {
				Button {
					isList.toggle()
				} label: {
					Image(systemName: selectedList)
				}
				.padding(.trailing, 5)
				.foregroundStyle(.white)
			}
//			.background(.darkBackground)
			.preferredColorScheme(.dark)
			.navigationDestination(for: Mission.self, destination: { mission in
				MissionView(mission: mission, astronauts: astronauts)

			})
		}
    }

	struct MissionLabelGridView: View {
		let mission: Mission

		var body: some View {
			VStack {
				Image(mission.image)
					.resizable()
					.scaledToFit()
					.frame(width: 100, height: 100)
					.padding()
				VStack {
					Text(mission.displayName)
						.font(.headline)
						.foregroundStyle(.white)
					Text(mission.formattedLaunchDate)
						.font(.caption)
						.foregroundStyle(.gray)
				}
				.padding(.vertical)
				.frame(maxWidth: .infinity)
				.background(.lightBackground)
			}
			.clipShape(.rect(cornerRadius: 10))
			.overlay(
				RoundedRectangle(cornerRadius: 10)
					.stroke(.lightBackground)
			)
		}
	}

	struct GridView: View {
		let columns = [
			GridItem(.adaptive(minimum: 150))
		]

		let missions: [Mission]
		let astronauts: [String: Astronaut]

		var body: some View {
			ScrollView {
				LazyVGrid(columns: columns) {
					ForEach(missions) { mission in
						NavigationLink(value: mission, label: {
							MissionLabelGridView(mission: mission)
						})
					}
				}
				.padding([.horizontal, .bottom])
			}
		}
	}

	struct ListView: View {
		let missions: [Mission]
		let astronauts: [String: Astronaut]

		var body: some View {
			List {
				Group {
					ForEach(missions) { mission in
						NavigationLink(value: mission, label: {
							ListLabelView(mission: mission)
						})
					}
				}
				.listRowBackground(Color.lightBackground)
				.listRowSeparator(.hidden)
			}
			.scrollContentBackground(.hidden)
		}
	}
}

#Preview {
    ContentView()
}

struct ListLabelView: View {
	var mission: Mission

	var body: some View {
		VStack(alignment: .leading) {
			HStack {
				Image(mission.image)
					.resizable()
					.scaledToFit()
					.frame(width: 100, height: 70)
				VStack {
					Text(mission.displayName)
						.font(.headline)
						.foregroundStyle(.white)
					Text(mission.formattedLaunchDate)
						.font(.caption)
						.foregroundStyle(.gray)
				}
			}
			CustomDividerView()
		}
	}
}
