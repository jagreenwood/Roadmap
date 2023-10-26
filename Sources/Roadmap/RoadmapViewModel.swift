//
//  RoadmapViewModel.swift
//  Roadmap
//
//  Created by Antoine van der Lee on 19/02/2023.
//

import Foundation

final class RoadmapViewModel: ObservableObject {
    @Published private var features: [RoadmapFeature] = []
    @Published var searchText = ""

    var filteredFeatures: [RoadmapFeature] {
        guard !searchText.isEmpty else {
            return features
        }
        return features.filter { feature in
            feature
                .localizedFeatureTitle // check title field...
                .lowercased() // Roadmap localizes strings in Roadmap.json, so avoid .localizedCaseInsensitiveContains()
                .contains(searchText.lowercased()) ||
            feature
                .localizedFeatureDescription // ...and check description field
                .lowercased()
                .contains(searchText.lowercased())
        }
    }
    let allowSearching: Bool
    private let configuration: RoadmapConfiguration

    init(configuration: RoadmapConfiguration) {
        self.configuration = configuration
        self.allowSearching = configuration.allowSearching
    }

    @MainActor
    func loadFeatures() async {
        if configuration.shuffledOrder {
            self.features = await configuration.voter.fetch().shuffled()
        } else if let sorting = configuration.sorting {
            self.features = await configuration.voter.fetch().sorted(by: sorting)
        } else {
            self.features = await configuration.voter.fetch()
        }
    }

    func featureViewModel(for feature: RoadmapFeature) -> RoadmapFeatureViewModel {
        .init(feature: feature, configuration: configuration)
    }
}
