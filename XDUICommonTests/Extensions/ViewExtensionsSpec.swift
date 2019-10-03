//
//  ViewExtensionsSpec.swift
//  XDUICommonTests
//
//  Created by Simmons, Joshua(AWF) on 29/11/2017.
//  Copyright © 2017 xDesign. All rights reserved.
//

import Quick
import Nimble

@testable import XDUICommon

class ViewExtensionsSpec: QuickSpec {
    
    override func spec() {
        
        describe("viewFromDerivedNibName") {
            it("should instantiate a typed view from a nib") {
                let cell = TestTableViewCell.viewWithDerivedNibName()
                expect(cell.testLabel.text).to(equal("TestTitle"))
            }
        }
    }
}
