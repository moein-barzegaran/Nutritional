//
//  GeneralResponse.swift
//  Nutritional
//
//  Created by Moein Barzegaran on 11/9/22.
//

import Foundation

struct GeneralResponseDTO<T: Decodable>: Decodable {
    let meta: MetaDTO
    let response: T?
}

struct MetaDTO: Decodable {
    let code: Int
}
