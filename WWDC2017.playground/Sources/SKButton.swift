//This is just the button class I used. Not much to see here.
import Foundation
import SpriteKit
import UIKit

public class SKButton : SKShapeNode {
  
    private let initialSize: CGSize
    private let labelNode: SKLabelNode
    private let sort: Int
    private let doodle: Doodle
    
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
    init(sort: Int, doodle: Doodle, rectOf: CGSize, labelText: String, fillColor: UIColor, strokeColor: UIColor, glowWidth: CGFloat = 2, action: (() -> Void)? = nil) {
        self.sort = sort
        self.doodle = doodle
        self.initialSize = rectOf
        self.action = action
        self.labelNode = SKLabelNode(text: labelText)
        super.init()
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
     
        let skAction = SKAction.scale(to: 1.0, duration: 0.25)
        self.run(skAction)
    }
    
    func touchMoved(toPoint pos : CGPoint) {
     
    }
    
    func touchUp(atPoint pos : CGPoint) {
    
        let skAction = SKAction.scale(to: 1.0, duration: 0.25)
        self.run(skAction)
        if let parent = self.parent {
            let posInParent = self.convert(pos, to: parent)
            if self.contains(posInParent) {
                action?()
            }
        }
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
          
            self.touchDown(atPoint: t.location(in: self))
        }
    }
    
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            self.touchMoved(toPoint: t.location(in: self))
    
        }
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            UISetup.play(scene: scene!, pal: doodle.palettes[sort])
            self.touchUp(atPoint: t.location(in: self))
            self.removeFromParent()
        }
    }
    
    override public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            self.touchUp(atPoint: t.location(in: self))
        }
    }
}
