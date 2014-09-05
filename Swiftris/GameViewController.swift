//
//  GameViewController.swift
//  Swiftris
//
//  Created by Yinhuan Yuan on 2014-09-03.
//  Copyright (c) 2014 Yinhuan Yuan. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    var scene: GameScene!
    var swiftris: Swiftris!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Configure the view.
        let skView = view as SKView
        skView.multipleTouchEnabled = false
        
        scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = .AspectFill
        
        scene.tick = didTick

        swiftris = Swiftris()
        swiftris.beginGame()

        skView.presentScene(scene)

        scene.addPreviewShapeToScene(swiftris.nextShape!) {
            self.swiftris.nextShape?.moveTo(StartingColumn, row: StartingRow)
            self.scene.movePreviewShape(self.swiftris.nextShape!) {
                let nextShapes = self.swiftris.newShape()
                self.scene.startTicking()
                self.scene.addPreviewShapeToScene(nextShapes.nextShape!) {}
            }
        }
     }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    func didTick() {
        swiftris.fallingShape?.lowerShapeByOneRow()
        scene.redrawShape(swiftris.fallingShape!, completion: {})
    }
}
