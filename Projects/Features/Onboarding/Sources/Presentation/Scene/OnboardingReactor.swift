//
//  OnboardingReactor.swift
//  Onboarding
//
//  Created mincheol on 2022/09/11.
//  Copyright © 2022 team.io. All rights reserved.
//
import CommonUI

import ReactorKit
import RxCocoa
import RxSwift
import UIKit

final public class OnboardingReactor: Reactor {

	// MARK: Constants
	private enum Constants { }

	// MARK: Properties
    public let initialState: State = State()

	// MARK: Initializing
	
	init() {}

	// MARK: Action
    public enum Action {
        case moveCurrentPage(Int)
        case didTapCTAButton(Int)
    }

	// MARK: State
    public struct State {
        let dataSoruce: [OnboardingModel] = [
            .init(title: "반가워요", description: "여기는 땡리단길이에요!", image: CommonUIAsset.onboarding1.image),
            .init(title: "빠르고 간편하게", description: "지도를 보고 지금 갈 곳을 선택해요.", image: CommonUIAsset.onboarding2.image),
            .init(title: "스티커로 저장", description: "마음에 드는 곳에 스티커 도장을 찍어 저장해요.", image: CommonUIAsset.onboarding3.image)
        ]
        var currentPage: Int = 0
        var moveToLoginPage: Bool = false
    }

	// MARK: Mutation
    public enum Mutation {
        case updateCurrenPage(Int)
        case setMoveToLoginPage(Bool)
    }

	// MARK: Mutate
    public func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case let .moveCurrentPage(value):
        return self.updateCurrentPageMutation(value)
    case let .didTapCTAButton(value):
        return self.checkCTAButtonType(value)
    }
  	}

	// MARK: Reduce
    public func reduce(state: State, mutation: Mutation) -> State {
    var newState = state
    switch mutation {
    case let .updateCurrenPage(value):
        newState.currentPage = value
    case let.setMoveToLoginPage(value):
        newState.moveToLoginPage = value
    }
    return newState
  }
}

extension OnboardingReactor {
    private func updateCurrentPageMutation(_ currentPage: Int) -> Observable<Mutation> {
        return .just(.updateCurrenPage(currentPage))
    }
    private func checkCTAButtonType(_ currentPage: Int) -> Observable<Mutation> {
        if currentPage == 2 {
            return .just(.setMoveToLoginPage(true))
        } else {
            return .just(.updateCurrenPage(currentPage + 1))
        }
    }
}
