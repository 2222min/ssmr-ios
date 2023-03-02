//
//  Networking.swift
//  Core
//
//  Created by mincheol on 2023/03/01.
//  Copyright © 2023 team.io. All rights reserved.
//
import SystemConfiguration

import RxSwift
import RxCocoa
import Moya
import Foundation
import UIKit
import RxMoya

var defaultErrorMessage: String = "현재 일시적인 문제가 생겨 빠르게 개선중입니다.\n이용에 불편을 드려 죄송합니다.\n잠시 후 다시 접속해주세요."

public protocol NetworkingProtocol {
    func request(_ target: TargetType, file: StaticString, function: StaticString, line: UInt) -> Single<Moya.Response>
}

extension NetworkingProtocol {
    public func request(_ target: TargetType, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) -> Single<Moya.Response> {
        return self.request(target, file: file, function: function, line: line)
    }
}

public final class Networking: MoyaProvider<MultiTarget>, NetworkingProtocol {
    
    private var disposeBag: DisposeBag = DisposeBag()
    private let intercepter: ConnectChecker
    
    public init() {
        let intercepter = ConnectChecker()
        let logger: [PluginType] = [NetworkLoggerPlugin.default]
        self.intercepter = intercepter
        let session = MoyaProvider<MultiTarget>.defaultAlamofireSession()
        session.sessionConfiguration.timeoutIntervalForRequest = 60
        super.init(requestClosure: { endpoint, completion in
            do {
                let urlRequest = try endpoint.urlRequest()
                intercepter.adapt(urlRequest, for: session, completion: completion)
            } catch MoyaError.requestMapping(let url) {
                completion(.failure(MoyaError.requestMapping(url)))
            } catch MoyaError.parameterEncoding(let error) {
                completion(.failure(MoyaError.parameterEncoding(error)))
            } catch {
                completion(.failure(MoyaError.underlying(error, nil)))
            }
        }, session: session, plugins: logger)
    }
    
    public func request(_ target: TargetType, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) -> Single<Moya.Response> {
        return self.rx.request(.target(target))
            .filterSuccessfulStatusCodes()
            .catch {
                guard let error = $0 as? MoyaError else {
                    return .error(BaseApiError())
                }
                
                if case let .statusCode(status) = error {
                    
                    guard let errorMessageResponse = try? JSONDecoder().decode(BaseApiError.self, from: status.data) else {
                        return .error(BaseApiError())
                    }
                    
                    if status.statusCode == 500 {
                        return .error(errorMessageResponse)
                    } else if status.statusCode == 401 {
                        if (errorMessageResponse.errorCode == 1201 &&
                            errorMessageResponse.errorReason == "UnAuthorized") ||
                            (errorMessageResponse.errorCode == 1205 &&
                             errorMessageResponse.errorReason == "Expired") ||
                            (errorMessageResponse.rspCode == "40101") {
                            return .error(errorMessageResponse)
                        }
                    } else if status.statusCode == 406 {
                        if errorMessageResponse.errorCode == 1206 ||
                            errorMessageResponse.errorCode == 1208 ||
                            errorMessageResponse.errorCode == 1209 ||
                            errorMessageResponse.errorCode == 1501 {
                            return .error(BaseApiError())
                        }
                    }
                    // 공통 에러 처리
                    return .error(errorMessageResponse)
                }
                
                return .error(BaseApiError())
            }
    }
    
    private class ConnectChecker {
        
        init() { }
        
        func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, MoyaError>) -> Void) {
            
            var zeroAddress = sockaddr_in()
            zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
            zeroAddress.sin_family = sa_family_t(AF_INET)
            
            guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
                $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                    SCNetworkReachabilityCreateWithAddress(nil, $0)
                }
            }) else {
                completion(.success(urlRequest))
                return
            }
            
            var flags: SCNetworkReachabilityFlags = []
            
            if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
                completion(.failure(MoyaError.requestMapping(defaultErrorMessage)))
                return
            }
            
            let isReachable = flags.contains(.reachable)
            let needsConnection = flags.contains(.connectionRequired)
            
            if isReachable && !needsConnection {
                completion(.success(urlRequest))
            } else {
                completion(.failure(MoyaError.requestMapping(defaultErrorMessage)))
                return
            }
        }
    }
}

