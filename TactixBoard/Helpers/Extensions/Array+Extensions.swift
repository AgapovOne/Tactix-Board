//
//  Array+Extensions.swift
//  TactixBoard
//
//  Created by Alex Agapov on 15/12/2016.
//  Copyright © 2016 agapov.one.ru. All rights reserved.
//

import Foundation

extension Array {
    func toDictionary<Key: Hashable>(with selectKey: (Element) -> Key) -> [Key: Element] {
        var dict = [Key:Element]()
        for element in self {
            dict[selectKey(element)] = element
        }
        return dict
    }
}
