//
//  CanvasViewModelTests.swift
//  GhostDrawingBoardTests
//
//  Created by Akhil Subramanyan on 04/10/23.
//

import XCTest
@testable import GhostDrawingBoard

final class CanvasViewModelTests: XCTestCase {

    var sut: GhostCanvasContainerViewModel!
    var canvasGhostViewModelStub: CanvasGhostViewModelStub!
    var drawSessionCompleteSpy: DrawSessionCompleteSpy!
    
    override func setUpWithError() throws {
        sut = GhostCanvasContainerViewModel()
        canvasGhostViewModelStub = CanvasGhostViewModelStub()
        drawSessionCompleteSpy = DrawSessionCompleteSpy()
        sut.ghostViewModel = canvasGhostViewModelStub
        drawSessionCompleteSpy.viewModel = sut
        drawSessionCompleteSpy.bindViewModel()
    }

    override func tearDownWithError() throws {
        sut = nil
        canvasGhostViewModelStub = nil
        drawSessionCompleteSpy = nil
    }

    func testUpdatePresentation() throws {
        let testColor = UIColor.white
        let testTime = 2.0
        let testWidth = 2.0

        sut.updateCanvasPresentation(lineColor: testColor,
                                     ghostTime: testTime,
                                     lineWidth: testWidth)
        XCTAssertEqual(canvasGhostViewModelStub.selectedColor, testColor)
        XCTAssertEqual(canvasGhostViewModelStub.selectedGhostTime, testTime)
        XCTAssertEqual(canvasGhostViewModelStub.selectedLineWidth, testWidth)
    }
    
    func testDrawSessionEndCallBack() throws {
        sut.resetDrawCanvas?(nil)
        XCTAssertTrue(drawSessionCompleteSpy.didCallDrawSessionComplete)
    }
}
