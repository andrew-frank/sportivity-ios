//
//  UserManager.swift
//  Sportivity
//
//  Created by Andrzej Frankowski on 23/05/2017.
//  Copyright © 2017 Sportivity. All rights reserved.
//

import Foundation
import RxSwift
import Unbox
import Wrap

protocol UserManagerProtocol {
    var isLoggedIn: Bool { get }
    var rx_isLoggedIn: Observable<Bool> { get }
    var token : String? { get }
    var user : User? { get }
    var rx_user : Observable<User?> { get }
    var categorySelections: CategorySelections { get }
    init(authManager: AuthManagerProtocol)
    func login(user: User) throws
    func update(user: User)
    func logout()
}

enum UserManagerError : SportivityError {
    case missingToken
    case failedSavingCredentials
    case userDictionaryMissing
    case userMapping(Error)
    case userWrapping(Error)
    
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
    
    let categorySelections = CategorySelections(selected: nil)

    // MARK: - Private

    fileprivate let _user = Variable<User?>(nil)
    fileprivate let authManager : AuthManagerProtocol
    fileprivate let _isLoggedIn = Variable<Bool>(false)
    fileprivate let disposeBag = DisposeBag()
    
    // MARK: - Public methods
    
    required init(authManager: AuthManagerProtocol = AuthManager.instance) {
        self.authManager = authManager
        do {
           try read()
        } catch UserManagerError.userDictionaryMissing {
            Logger.shared.log(.error, className: "UserManager", message: "There's no persisted user dictionary for the logged in user. Logging out.")
            logout()
        } catch let error {
            Logger.shared.log(.severe, className: "UserManager", message: error.localizedDescription)
            assert(false, error.localizedDescription)
        }
        
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
        
        Observable
            .combineLatest(_user.asObservable(), categorySelections.rx_selectedCategories.asObservable() ) {
                [unowned self] (_, categories) -> Void in
                self._user.value?.sportCategories.value = categories
                return
            }
            .subscribeNext { () in
                Logger.shared.log(.debug, className: "UserManager", message: "Setting new User's categories")
            }
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
        
        do {
            try save(user: user)
        } catch {
            throw UserManagerError.userWrapping(error)
        }
        
        _user.value = user
    }
    
    func update(user: User) {
        if let current = self._user.value {
            guard current.id == user.id else {
                assert(false, "New user has different id from current user")
                return
            }
        }
        self._user.value = user
        self.categorySelections.set(categories: user.sportCategories.value)
        try? save(user: user)
    }
    
    func logout() {
        _user.value = nil
        categorySelections.set(categories: [Category]())
        clear()
        authManager.clear()
    }
}

private extension UserManager {
    
    func save(user: User) throws {
        let dict : WrappedDictionary = try wrap(user)
        UserDefaults.standard.setValue(dict, forKey: "user")
    }
    
    func clear() {
        UserDefaults.standard.removeObject(forKey: "user")
    }
    
    func read() throws {
        let dict = UserDefaults.standard.dictionary(forKey: "user")
        guard let dictionary = dict else {
            throw UserManagerError.userDictionaryMissing
        }
        do {
            let user: User = try unbox(dictionary: dictionary)
            _user.value = user
        } catch let error {
            throw UserManagerError.userMapping(error)
        }
    }
}
