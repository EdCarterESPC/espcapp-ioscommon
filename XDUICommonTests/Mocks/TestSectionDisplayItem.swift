//
//  TestSectionDisplayItem.swift
//  XDUICommonTests
//
//  Created by Timothy Brand-Spencer on 01/12/2017.
//  Copyright © 2017 xDesign. All rights reserved.
//

import XDUICommon

class TestSectionDisplayItem: SectionDisplayItem {
    
    var rowDisplayItems: [Any]
    
    init(displayItems: [Any]) {
        self.rowDisplayItems = displayItems
    }
    
}

struct TestDisplayItem { let id = UUID().uuidString }
