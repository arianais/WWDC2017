//
//  ButtonNode.swift
//
//  Created by Adi Unnithan on 1/19/17.
//  Copyright © 2017 Adi Unnithan. All rights reserved.
//
import Foundation
import SpriteKit

public class SKButton : SKShapeNode {
  
    private let initialSize: CGSize
    private let labelNode: SKLabelNode
    private let sort: Int
    private let palette: Palette
    
    var action: (() -> Void)?
    
    public var fontSize: CGFloat {
        get {
            return self.labelNode.fontSize
        }
        set {
            self.labelNode.fontSize = newValue
        }
    }
    
    public var fontName: String? {
        get {
            return self.labelNode.fontName
        }
        set {
            self.labelNode.fontName = newValue
        }
    }
    
    public var fontColor: UIColor? {
        get {
            return self.labelNode.fontColor
        }
        set {
            self.labelNode.fontColor = newValue
        }
    }
    
    public var horizontalAlignmentMode: SKLabelHorizontalAlignmentMode {
        get {
            return self.labelNode.horizontalAlignmentMode
        }
        set {
            self.labelNode.horizontalAlignmentMode = newValue
        }
    }
    
    public var verticalAlignmentMode: SKLabelVerticalAlignmentMode {
        get {
            return self.labelNode.verticalAlignmentMode
        }
        set {
            self.labelNode.verticalAlignmentMode = newValue
        }
    }
    
    public
    init(sort: Int, palette: Palette, rectOf: CGSize, labelText: String, fillColor: UIColor, strokeColor: UIColor, glowWidth: CGFloat = 2, action: (() -> Void)? = nil) {
        self.sort = sort
        self.palette = palette
        self.initialSize = rectOf
        self.action = action
        self.labelNode = SKLabelNode(text: labelText)
        super.init()
        print("atouch")
        let rect = CGRect(x: -rectOf.width / 2, y: -rectOf.height / 2, width: rectOf.width, height: rectOf.height)
        self.path = CGPath(rect: rect, transform: nil)
        self.fillColor = fillColor
        self.strokeColor = strokeColor
        self.glowWidth = glowWidth
        self.addChild(self.labelNode)
        self.isUserInteractionEnabled = true
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func touchDown(atPoint pos : CGPoint) {
        print("touch")
        let skAction = SKAction.scale(to: 1.0, duration: 0.25)
        self.run(skAction)
    }
    
    func touchMoved(toPoint pos : CGPoint) {
          print("touch")
    }
    
    func touchUp(atPoint pos : CGPoint) {
          print("touch")
        let skAction = SKAction.scale(to: 1.0, duration: 0.25)
        self.run(skAction)
        
        // Determine if the button node contains this point.
        // In order to do this we first have to convert to the parent's coordinates
        if let parent = self.parent {
            let posInParent = self.convert(pos, to: parent)
            if self.contains(posInParent) {
                action?()
            }
        }
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
          //  UISetup.reset(sort:sort,  scene: scene!, pal: palette)
            
           
            self.touchDown(atPoint: t.location(in: self))
        }
    }
    
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            
            self.touchMoved(toPoint: t.location(in: self))
            print("touch")
        }
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            self.palette.actions[sort + 1].append(SKAction.run{UISetup.reset(sort:0,  scene: self.scene!, pal: self.palette)})
            self.palette.reset(colors:[4,1,0,3,2], sort: 1)
            UISetup.play(scene: scene!, pal: palette, sort:sort + 1)
            self.touchUp(atPoint: t.location(in: self))
            print("touch")
        }
    }
    
    override public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            print("touch")
            self.touchUp(atPoint: t.location(in: self))
        }
    }
}
