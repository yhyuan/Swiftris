//
//  Swiftris.swift
//  Swiftris
//
//  Created by Yinhuan Yuan on 2014-09-03.
//  Copyright (c) 2014 Yinhuan Yuan. All rights reserved.
//

import Foundation

let NumColumns = 10
let NumRows = 20

let StartingColumn = 4
let StartingRow = 0

let PreviewColumn = 12
let PreviewRow = 1

class Swiftris {
	var blockArray: Array2D<Block>
	var nextShape: Shape?
	var fallingShape: Shape?

	init() {
		fallingShape = nil
		nextShape = nil
		blockArray = Array2D<Block>(columns: NumColumns, rows: NumRows)
	}

	func beginGame() {
		if (nextShape == nil) {
			nextShape = Shape.random(PreviewColumn, StartingRow: PreviewRow)
		}
	}

	func newShape() -> (fallingShape:Shape?, nextShape:Shape?) {
		fallingShape = nextShape
		nextShape = Shape.random(PreviewColumn, StartingRow: PreviewRow)
		fallingShape?.moveTo(StartingColumn, row: StartingRow)
		return (fallingShape, nextShape)
	}
} 