//
//  HomeHashTagCellReactor.swift
//  Home
//
//  Created mincheol on 2023/05/27.
//  Copyright © 2023 team.io. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import ReactorKit


final class HomeHashTagCellReactor: Reactor, IdentityHashable {
	
	// MARK: Constants
	private enum Constants { }

	// MARK: Properties
	let initialState: State 

	// MARK: Action 
	enum Action {}

	// MARK: Mutation
	enum Mutation {}

	// MARK: State
	struct State {
        var hashTag: String
        var image: UIImage
    }

	// MARK: Initializing
    init(
        hashTag: String,
        image: UIImage
    ) {
		defer { _ = self.state }
		self.initialState = State(
            hashTag: hashTag,
            image: image
        )
	}
}
