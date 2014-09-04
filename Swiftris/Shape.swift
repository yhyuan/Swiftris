//
//  Shape.swift
//  Swiftris
//
//  Created by Yinhuan Yuan on 2014-09-03.
//  Copyright (c) 2014 Yinhuan Yuan. All rights reserved.
//
import Foundation
import SpriteKit

let NumOrientations: UInt32 = 4

enum Orientation: Int, Printable {
	case Zero = 0, Ninety, OneEighty, TwoSeventy

	var description: String {
		switch self {
			case .Zero:
				return "0"
			case .Ninety:
				return "90"
			case .OneEighty:
				return "180"
			case .TwoSeventy:
				return "270"

		}
	}

	static func random() -> Orientation {
		return Orientation.fromRaw(Int(arc4random_uniform(NumOrientations)))
	}

	static func rotate(orientation:Orientation, clockwise: Bool) -> Orientation {
		var rotated = orientation.toRaw() + (clockwise ? 1 : -1)
		if rotated > Orientation.TwoSeventy.toRaw() {
			rotated = Orientation.Zero.toRaw()
		} else if rotated < 0 {
			rotated = Orientation.TwoSeventy.toRaw()
		}
		return Orientation.fromRaw(rotated)!
	}
}

// The number of total shape varieties
let NumShapeTypes: UInt32 = 7

// Shape indexes
let FirstBlockIdx: Int = 0
let SecondBlockIdx: Int = 1
let ThirdBlockIdx: Int = 2
let FourthBlockIdx: Int = 3

class Shape: Hashable, Printable {
	// The color of the shape
	let color:BlockColor

	// The blocks comprising the shape
	var blocks = Array<Block>()
	//The current orientation of the shape
	var orientation: Orientation
	// The column and row representing the shape's anchor point
	var column, row: Int

	//Required Overrides

	var blockRowColumnPositions: [Orientation: Array<(columnDiff: Int, rowDiff: Int)>] {
		return [:]
	}
	var bottomBlocksForOrientations: [Orientation: Array<Block>] {
		return [:]
	}

	var bottomBlocks: Array<Block> {
		if let bottomBlocks = bottomBlocksForOrientations[orientation] {
			return bottomBlocks
		}
		return []
	}

	var hashValue: Int {
		return reduce(blocks, 0) {$0.hashValue ^ $1.hashValue}
	}

	var description:String {
		return "\(color) block facing \(orientation): \(blocks[FirstBlockIdx]), \(blocks[SecondBlockIdx]), \(blocks[ThirdBlockIdx]), \(blocks[FourthBlockIdx])"
	}

	init(column:Int, row:Int, color: BlockColor, orientation: Orientation) {
		self.color = color
		self.column =column
		self.row = row
		self.orientation = orientation
		initializeBlocks()
	}

	convenience init(column: Int, row: Int) {
		self.init(column:column, row: row, color: BlockColor.random(), orientation: Orientation.random())
	}
}

func ==(lhs: Shape, rhs: Shape) -> Bool {
	return lhs.row == rhs.row && lhs.column == rhs.column
}