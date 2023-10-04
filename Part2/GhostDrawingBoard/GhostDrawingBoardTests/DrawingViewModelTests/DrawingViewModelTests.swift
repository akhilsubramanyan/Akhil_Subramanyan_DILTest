//
//  DrawingViewModelTests.swift
//  GhostDrawingBoardTests
//
//  Created by Akhil Subramanyan on 04/10/23.
//

import XCTest
@testable import GhostDrawingBoard

final class DrawingViewModelTests: XCTestCase {
    var sut: GhostDrawingBoardViewModel!
    var canvasViewModelSpy: CanvasViewModelStub!
    var toolBoxViewModelSpy: ToolBoxViewModelStub!

    override func setUpWithError() throws {
        sut = GhostDrawingBoardViewModel()
        canvasViewModelSpy = CanvasViewModelStub()
        toolBoxViewModelSpy = ToolBoxViewModelStub()
        sut.canvasViewModel = canvasViewModelSpy
        sut.toolBoxViewModel = toolBoxViewModelSpy
    }

    override func tearDownWithError() throws {
        sut = nil
        canvasViewModelSpy = nil
        toolBoxViewModelSpy = nil
    }

    func testBind() throws {
        sut.bind()
        let defaultDrawTool = sut.defaultDrawTool!
        XCTAssertEqual(canvasViewModelSpy.selectedColor, defaultDrawTool.color)
        XCTAssertEqual(canvasViewModelSpy.selectedGhostTime, defaultDrawTool.ghostTime)
        XCTAssertEqual(canvasViewModelSpy.selectedLineWidth, defaultDrawTool.linewidth)
    }
    
    func testToolBoxSelect() throws {
        sut.bind()
        for i in 0..<sut.drawTools.count {
            let selectedDrawTool = sut.drawTools[i]
            toolBoxViewModelSpy.didClickTool(at: i)
            XCTAssertEqual(canvasViewModelSpy.selectedColor, selectedDrawTool.color)
            XCTAssertEqual(canvasViewModelSpy.selectedGhostTime, selectedDrawTool.ghostTime)
            XCTAssertEqual(canvasViewModelSpy.selectedLineWidth, selectedDrawTool.linewidth)
        }
    }
    
    func testViewBind() throws {
        sut.bind()
        let drawViewMock = DrawViewModelBindMock()
        drawViewMock.viewModel = sut
        drawViewMock.bind()
        for i in 0..<sut.drawTools.count {
            let selectedDrawTool = sut.drawTools[i]
            toolBoxViewModelSpy.didClickTool(at: i)
            XCTAssertEqual(drawViewMock.selectedToolDisplayName, selectedDrawTool.displayName)
            XCTAssertEqual(drawViewMock.selectedToolColor, selectedDrawTool.displayColor)
        }
    }
}
