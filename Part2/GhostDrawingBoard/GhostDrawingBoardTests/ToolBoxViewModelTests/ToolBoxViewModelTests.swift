//
//  ToolBoxViewModelTests.swift
//  GhostDrawingBoardTests
//
//  Created by Akhil Subramanyan on 04/10/23.
//

import XCTest
@testable import GhostDrawingBoard

final class ToolBoxViewModelTests: XCTestCase {

    var sut: ToolBoxViewModel!
    var callBackSpy: ToolBoxCallBacksSpy!

    override func setUpWithError() throws {
        sut = ToolBoxViewModel()
        callBackSpy = ToolBoxCallBacksSpy()
        callBackSpy.viewModel = sut
        callBackSpy.bindViewModel()
    }

    override func tearDownWithError() throws {
        sut = nil
        callBackSpy = nil
    }

    func testToolBoxCallBacks() throws {
        let selectedIndex = 5
        callBackSpy.selectedIndex = nil
        sut.didClickTool(at: selectedIndex)
        XCTAssertEqual(callBackSpy.selectedIndex, selectedIndex)
        
        callBackSpy.didCallToolBarSetUp = false
        sut.tools = [GhostDrawToolViewModel(color: .white,
                                            ghostTime: 2.0,
                                            linewidth: 1.0,
                                            toolDisplayType: .text(""),
                                            displayName: "",
                                            displayColor: .white)]
        XCTAssertTrue(callBackSpy.didCallToolBarSetUp)
    }

}
