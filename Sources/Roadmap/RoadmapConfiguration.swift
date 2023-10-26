//
//  RoadmapConfiguration.swift
//  Roadmap
//
//  Created by Antoine van der Lee on 19/02/2023.
//

import Foundation
import SwiftUI

public struct RoadmapConfiguration {    
    /// The interface for retrieving and saving votes.
    public let voter: FeatureVoter
    
    /// Pick a `RoadmapStyle` that fits your app best. By default the `.standard` option is used.
    public let style: RoadmapStyle
    
    /// Set this to true to have a different order of features everytime the view is presented
    public let shuffledOrder: Bool
    
    /// Set this to true to if you want to let users vote. Set it to false for read-only mode. This can be used to only let paying users vote for example.
    public let allowVotes: Bool
    
    /// Set this to true to if you want to add a search bar so users can filter which features are shown.
    public let allowSearching: Bool

    /// If set, will be used for sorting features.
    public let sorting: ((RoadmapFeature, RoadmapFeature) -> Bool)?

    /// Creates a new Roadmap configuration instance.
    /// - Parameters:
    ///   - roadmapJSONURL: The URL pointing to the JSON in the `RoadmapFeature` format.
    ///   - roadmapRequest: The Request pointing to the JSON in the `RoadmapFeature` format.
    ///   - voter: The interface to use for retrieving and persisting votes. To use https://countapi.xyz/, provide instance of `FeatureVoterCountAPI`.
    ///   - namespace: A unique namespace to use matching your app.
    ///   See `https://countapi.xyz/` for more information.
    ///   Defaults to your main bundle identifier.
    ///   - style: Pick a `RoadmapStyle` that fits your app best. By default the `.standard` option is used.
    ///   - shuffledOrder: Set this to true to have a different order of features everytime the view is presented
    ///   - sorting: /// If set, will be used for sorting features.
    ///   - allowVotes: Set this to true to if you want to let users vote. Set it to false for read-only mode. This can be used to only let paying users vote for example.
    ///   - allowSearching: Set this to true to if you want to add a search bar so users can filter which features are shown.
    public init(voter: FeatureVoter,
                style: RoadmapStyle = RoadmapTemplate.standard.style,
                shuffledOrder: Bool = false,
                sorting: ((RoadmapFeature, RoadmapFeature) -> Bool)? = nil,
                allowVotes: Bool = true,
                allowSearching: Bool = false) {
        self.voter = voter
        self.style = style
        self.shuffledOrder = shuffledOrder
        self.sorting = sorting
        self.allowVotes = allowVotes
        self.allowSearching = allowSearching
    }
}
