//
//  UserManager.swift
//  Sportivity
//
//  Created by Andrzej Frankowski on 23/05/2017.
//  Copyright © 2017 Sportivity. All rights reserved.
//

import Foundation
import RxSwift

protocol UserManagerProtocol {
    var isLoggedIn: Bool { get }
    var rx_isLoggedIn: Observable<Bool> { get }
    var token : String? { get }
    var user : User? { get }
    var rx_user : Observable<User?> { get }
    init(authManager: AuthManagerProtocol)
    func login(user: User) throws
    func update(user: User)
    func logout()
}

enum UserManagerError : SportivityError {
    case missingToken
    case failedSavingCredentials
    
    var description: String {
        return self.defaultMessage
    }
    
    var localizedDescription: String {
        return description
    }
}

class UserManager : UserManagerProtocol {
    
    // MARK: - Public properties
    
    static let shared = UserManager()
    
    var isLoggedIn: Bool {
        return _isLoggedIn.value
    }
    
    var rx_isLoggedIn: Observable<Bool> {
        return _isLoggedIn.asObservable().distinctUntilChanged()
    }
    
    var token : String? {
        return authManager.credentials?.token
    }
    
    var user : User? {
        return _user.value
    }
    
    var rx_user : Observable<User?> {
        return _user.asObservable()
    }
    
    // MARK: - Private

    fileprivate let _user = Variable<User?>(nil)
    fileprivate let authManager : AuthManagerProtocol
    fileprivate let _isLoggedIn = Variable<Bool>(false)
    fileprivate let disposeBag = DisposeBag()
    
    // MARK: - Public methods
    
    required init(authManager: AuthManagerProtocol = AuthManager.instance) {
        self.authManager = authManager
        Observable
            .combineLatest(_user.asObservable(), authManager.rx_credentials, resultSelector: { (user, credentials) -> Bool in
                guard let credentials = credentials else {
                    return false
                }
                guard !credentials.token.isEmpty else {
                    return false
                }
                if let user = user, user.id != credentials.id {
                    assert(false, "Something went wrong with Auth/User Managers - the id does not match with user's id")
                    return false
                }
                return true
            })
            .bind(to: _isLoggedIn)
            .addDisposableTo(disposeBag)
    }
    
    func login(user: User) throws {
        assert(self._user.value == nil)
        guard let token = user.token else {
            assert(false, "Missing token")
            throw UserManagerError.missingToken
        }
        do {
            try authManager.save(id: user.id, token: token)
        } catch {
            throw UserManagerError.failedSavingCredentials
        }
    }
    
    func update(user: User) {
        if let current = self._user.value {
            guard current.id == user.id else {
                assert(false, "New user has different id from current user")
                return
            }
        }
        self._user.value = user
    }
    
    func logout() {
        _user.value = nil
        authManager.clear()
    }
}
