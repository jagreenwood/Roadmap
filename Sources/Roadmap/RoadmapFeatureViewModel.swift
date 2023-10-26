//
//  RoadmapFeatureViewModel.swift
//  Roadmap
//
//  Created by Antoine van der Lee on 19/02/2023.
//

import Foundation
import SwiftUI

@Observable
final class RoadmapFeatureViewModel {
    var feature: RoadmapFeature
    let configuration: RoadmapConfiguration
    let canVote: Bool

    init(feature: RoadmapFeature, configuration: RoadmapConfiguration) {
        self.feature = feature
        self.configuration = configuration

        self.canVote = configuration.allowVotes
    }

    @MainActor
    func vote() async {
        let newCount = await configuration.voter.vote(for: feature)
        feature.voteCount = newCount ?? (feature.voteCount + 1)
        feature.hasVoted = true
    }

    @MainActor
    func unvote() async {
        let newCount = await configuration.voter.unvote(for: feature)
        feature.voteCount = newCount ?? (feature.voteCount - 1)
        feature.hasVoted = false
    }
}
