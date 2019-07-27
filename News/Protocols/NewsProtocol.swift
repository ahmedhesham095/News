//
//  NewsProtocol.swift
//  News
//
//  Created by Ahmed Hesham on 7/26/19.
//  Copyright © 2019 Ahmed Hesham. All rights reserved.
//

import Foundation

protocol NewsProtocol {
    func showLoader()
    func hideLoader()
    func configureUI(with articles : [Article], and message: String?)
}
