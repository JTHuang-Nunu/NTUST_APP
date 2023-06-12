//
//  Utils.swift
//  NTUST_APP
//
//  Created by Cheng Pong Huang on 2023/6/11.
//

import Foundation


protocol RequireLogin{
    var requireMoodle: Bool { get }
    var requireNTUST: Bool { get }
}
