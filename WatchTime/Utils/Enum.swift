//
//  Enum.swift
//  WatchTime
//
//  Created by Buse Şahinbaş on 10.05.2023.
//

import Foundation

enum MessageTitle: String {
    case error = "Error"
    case warning = "Warning"
    case resetPass = "Reset Password"
}

enum MessageDescription: String {
    case fields = "Fields are required"
    case mail = "Email field is required"
    case mailPass = "Email/Password fields are required"
    case resetPass = "Password reset instructions have been sent to your email"
    case confirmPass =  "Password and Confirm Password do not match"
}

