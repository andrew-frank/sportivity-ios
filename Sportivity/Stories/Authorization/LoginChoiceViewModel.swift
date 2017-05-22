//
//  LoginChoiceViewModel.swift
//  Sportivity
//
//  Created by Andrzej Frankowski on 21/05/2017.
//  Copyright © 2017 Sportivity. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Result

enum LoginResult {
    case success
    case error(String)
    
    init(result: Result<User, APIError>) {
        switch result {
        case .success(_):
            self = .success
        case .failure(let error):
            self = .error(error.description)
        }
    }
}

class LoginChoiceViewModel {
    
    let email = Variable<String?>("")
    let password = Variable<String?>("")
    
    func login() -> Observable<LoginResult> {
        guard let mail = self.email.value, let pass = password.value, !mail.isEmpty, !pass.isEmpty else {
            return Observable<LoginResult>.just(LoginResult.error("Email and password cannot be empty!"))
        }
        return AuthenticateAPI.rx_login(email: mail, password: pass).map { return LoginResult(result: $0) }
    }
}
