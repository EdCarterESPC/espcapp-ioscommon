//
//  CollectionViewControllerSpec.swift
//  App
//
//  Created by Timothy on 17/03/2017.
//  Copyright © 2017 xDesign. All rights reserved.
//

import Quick
import Nimble

@testable import XDUICommon

class CollectionViewControllerSpec: QuickSpec {
    
    override func spec() {
        
        context("view controller is not subclass of CollectionViewController") {
            
            var viewController: CollectionViewController!
    
            beforeEach {
                viewController = CollectionViewController()
            }
            
            describe("loadView") {
                it("should throw assertion") {
                    expect { _ = viewController.view } .to(throwAssertion())
                }
            }
            
            describe("setupCollectionView") {
                it("should throw assertion") {
                    expect { viewController.setupCollectionView() }.to(throwAssertion())
                }
            }
            
            describe("configuredCollectionViewCell(for:at:)") {
                it("should throw assertion") {
                    expect { _ = viewController.configuredCollectionViewCell(for: TestDisplayItem(),
                                                                        at: IndexPath(row: 0, section: 0)) }.to(throwAssertion())
                }
            }
            
        }
        
        context("view controller is a subclass of CollectionViewController") {
            
            var viewController: CollectionViewController!
            
            beforeEach {
                viewController = TestCollectionViewController()
                viewController.displayItems = [TestSectionDisplayItem(displayItems: [TestDisplayItem()])]
                _ = viewController.view
            }
            
            describe("loadView") {
                it("should not throw an assertion") {
                    expect { _ = viewController.view } .toNot(throwAssertion())
                }
            }
            
            describe("setupCollectionView") {
                it("should not throw assertion") {
                    expect { viewController.setupCollectionView() }.toNot(throwAssertion())
                }
            }
            
            describe("configuredCollectionViewCell(for:at:)") {
                it("should not throw assertion") {
                    expect { _ = viewController.configuredCollectionViewCell(for: TestDisplayItem(),
                                                                        at: IndexPath(row: 0, section: 0)) }.toNot(throwAssertion())
                }
            }

        }
        
        context("view controller has multiple sections of display items") {
            
            var viewController: CollectionViewController!
            
            beforeEach {
                viewController = TestCollectionViewController()

                viewController.displayItems = [TestSectionDisplayItem(displayItems: [TestDisplayItem(),
                                                                                     TestDisplayItem()]),
                                               TestSectionDisplayItem(displayItems: [TestDisplayItem(),
                                                                                     TestDisplayItem(),
                                                                                     TestDisplayItem()]),
                                               TestSectionDisplayItem(displayItems: [TestDisplayItem(),
                                                                                     TestDisplayItem(),
                                                                                     TestDisplayItem()])]

                _ = viewController.view // loads the view
            }
            
            describe("insertDisplayItem") {
                it("should insert display item at specified index") {
                    let newDisplayItem = TestDisplayItem()
                    let expectedCount = viewController.displayItems.count + 1

                    viewController.insertDisplayItem(newDisplayItem, atRow: 0, inSection: 1)

                    expect(viewController.displayItems[1].rowDisplayItems).to(haveCount(expectedCount))
                    expect((viewController.displayItems[1].rowDisplayItems.first as! TestDisplayItem).id).to(equal(newDisplayItem.id))
                }
            }
            
            describe("insertDisplayItems") {
                it("should insert multiple items at specified index") {
                    var newDisplayItems: [TestDisplayItem] = []
                    for _ in 0..<10 { newDisplayItems.append(TestDisplayItem()) }
                    let expectedCount = viewController.displayItems[0].rowDisplayItems.count + newDisplayItems.count

                    viewController.insertDisplayItems(newDisplayItems, atRow: 0, inSection: 0)

                    expect(viewController.displayItems[0].rowDisplayItems).to(haveCount(expectedCount))
                    expect((viewController.displayItems[0].rowDisplayItems[0] as! TestDisplayItem).id).to(equal(newDisplayItems[0].id))
                    expect((viewController.displayItems[0].rowDisplayItems[9] as! TestDisplayItem).id).to(equal(newDisplayItems[9].id))
                }
            }
            
            describe("appendDisplayItem") {
                it("should insert display item at end of display items") {
                    let newDisplayItem = TestDisplayItem()
                    viewController.appendDisplayItem(newDisplayItem, toSection: 0)
                    
                    expect(viewController.displayItems[0].rowDisplayItems).to(haveCount(3))
                    expect((viewController.displayItems[0].rowDisplayItems[2] as! TestDisplayItem).id).to(equal(newDisplayItem.id))
                }
            }
            
            describe("appendDisplayItems") {
                it("should insert multiple display item at end of display items") {
                    var newDisplayItems: [TestDisplayItem] = []
                    for _ in 0..<10 { newDisplayItems.append(TestDisplayItem()) }

                    let expectedCount = viewController.displayItems[0].rowDisplayItems.count + newDisplayItems.count
                    
                    viewController.appendDisplayItems(newDisplayItems, toSection: 0)
                    
                    expect(viewController.displayItems[0].rowDisplayItems).to(haveCount(expectedCount))
                    expect((viewController.displayItems[0].rowDisplayItems.last as! TestDisplayItem).id).to(equal(newDisplayItems[9].id))
                }
            }
            
            describe("removeDisplayItem") {
                it("should remove the display item at specified row and section") {
                    let expectedCount = viewController.displayItems[0].rowDisplayItems.count - 1
                    
                    viewController.removeDisplayItem(atRow: 0, inSection: 0)
                    
                    expect(viewController.displayItems[0].rowDisplayItems).to(haveCount(expectedCount))
                }
            }
            
            describe("insertSectionWithDisplayItems") {
                it("should insert the section at correct index") {
                    var newDisplayItems: [TestDisplayItem] = []
                    for _ in 0..<10 { newDisplayItems.append(TestDisplayItem()) }
                    
                    let expectedNumberOfSections = viewController.displayItems.count + 1
                    
                    viewController.insertSection(TestSectionDisplayItem(displayItems: newDisplayItems), atIndex: 0)
                    
                    expect(viewController.displayItems).to(haveCount(expectedNumberOfSections))
                    expect(viewController.displayItems[0].rowDisplayItems).to(haveCount(newDisplayItems.count))
                }
            }
            
            describe("removeSection") {
                it("should remove the section at correct index") {
                    let expectedSectionsCount = viewController.displayItems.count - 1
                    
                    viewController.removeSection(0)
                    
                    expect(viewController.displayItems).to(haveCount(expectedSectionsCount))
                }
            }
            
            describe("numberOfSections(inCollectionView)") {
                it("returns correct number of sections") {
                    let sections = viewController.numberOfSections(in: viewController.collectionView)
                    expect(sections).to(equal(sections))
                }
            }

            describe("collectionView numberOfRowsInSection") {
                it("returns correct number of sections") {
                    
                    expect(viewController.collectionView(viewController.collectionView, numberOfItemsInSection: 0))
                            .to(equal(viewController.displayItems[0].rowDisplayItems.count))
                }
            }

        }


    }
    
    class TestCollectionViewController: CollectionViewController {
        
        override func setupCollectionView() {
            collectionView.register(TestCollectionViewCell.self,
                                    forCellWithReuseIdentifier: TestCollectionViewCell.reuseIdentifier())
            
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width: view.frame.width / 2, height: view.frame.height / 4)
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
            collectionView.collectionViewLayout = layout
        }
        
        override func configuredCollectionViewCell(for displayItem: Any, at indexPath: IndexPath) -> UICollectionViewCell {
            return collectionView.dequeueReusableCell(withReuseIdentifier: TestCollectionViewCell.reuseIdentifier(),
                                                      for: indexPath)
        }
        
    }
    
    class TestCollectionViewCell: UICollectionViewCell { }

}
