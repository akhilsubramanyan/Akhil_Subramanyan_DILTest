//
//  CanvasGhostDrawerTest.swift
//  GhostDrawingBoardTests
//
//  Created by Akhil Subramanyan on 04/10/23.
//

import XCTest
@testable import GhostDrawingBoard

final class CanvasGhostDrawerTest: XCTestCase {

    var sut: GhostCanvasViewModel!
    var canvasGhostViewModelSpy: CanvasGhostViewModelSpy!
    var mockDrawer: MockDrawer!
    
    override func setUpWithError() throws {
        sut = GhostCanvasViewModel()
        canvasGhostViewModelSpy = CanvasGhostViewModelSpy()
        mockDrawer = MockDrawer()
        canvasGhostViewModelSpy.viewModel = sut
        mockDrawer.viewModel = sut
        canvasGhostViewModelSpy.bindViewModel()
    }

    override func tearDownWithError() throws {
        sut = nil
        canvasGhostViewModelSpy = nil
        mockDrawer = nil
    }
    
    func testGhostDraw() throws {
        var executionTime: TimeInterval = 0.0
        let testLineColor = UIColor.red
        let testGhostTime = 5.0
        let testLineWidth = 11.0
        
        self.measure {

            let expectation = XCTestExpectation(description: "ghost draw should be completed after \(testGhostTime) seconds")
            
            mockDrawer.updateToolParams(lineColor: testLineColor,
                                        ghostTime: testGhostTime,
                                        lineWidth: testLineWidth)
            let startTime = CFAbsoluteTimeGetCurrent()
            mockDrawer.mockDrawing()
            canvasGhostViewModelSpy.didCalledCanvasImageCallBack = false
            canvasGhostViewModelSpy.completeDrawCallBack = { image in
                XCTAssertEqual(image, self.canvasGhostViewModelSpy.testImage)
                XCTAssertTrue(self.canvasGhostViewModelSpy.didCalledCanvasImageCallBack)
                
                XCTAssertEqual(self.canvasGhostViewModelSpy.lineWidth, testLineWidth)
                XCTAssertEqual(self.canvasGhostViewModelSpy.lineStartPoint, self.mockDrawer.startpoint)
                XCTAssertEqual(self.canvasGhostViewModelSpy.linePoints, self.mockDrawer.intermediatePoints)
                XCTAssertEqual(self.canvasGhostViewModelSpy.lineColor, testLineColor)
                
                expectation.fulfill()
                let endTime = CFAbsoluteTimeGetCurrent() 
                executionTime = endTime - startTime
            }
            wait(for: [expectation], timeout: testGhostTime + 1)
        }
        XCTAssertGreaterThan(executionTime, testGhostTime)
    }
}
