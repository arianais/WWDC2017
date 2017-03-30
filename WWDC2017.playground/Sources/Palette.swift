
import UIKit
import SpriteKit
import SceneKit
import XCPlayground
import PlaygroundSupport

open class Palette {
    //fix setters & getters to be private vars
    public var actionSet:[SKAction] = []
    public var actions = [[SKAction]]()
    public var colors:[Int]
    private var rowCount = 0 {
        didSet{
            if(sort == 0){
                
            }
        }
        
    }
    public var sort: Int
    public var msArr:[Int] = []
    public var middle: Int = 0
    public var order:[Int]{
        
        didSet{
            if(order.count > 0){
                self.push(i: order.count - 1  + middle, e: order[order.count-1])
            }
            else{
              
            }
        }
        
    }
    private var minInt: Int
    private var scene:SKScene

 
    
    
  
    public init(colors: [Int], scene: SKScene, sort: Int) {
        self.sort = sort
        self.colors = colors
        self.scene = scene
        actionSet = []
        minInt = colors[0]
        order = []
       
        //UISetup.setRow(scene: scene, colors: colorsArr, row: 0, pal:self, sort: sort)
        let defAct: [SKAction] = []
        actions.append(defAct)
        actions.append(defAct)
        actions.append(defAct)
       
        actions[self.sort].append(SKAction.run { UISetup.initColorRow(row: 0, scene: scene, iColors: self.colors, sort: self.sort)})
      
    }
    public func addAction(action: SKAction){
        
        print(actions)
        actionSet.append(action)
      
    
    }
   
 
    public func compare(i1: Int, i2: Int)->Int{
        
        if(sort == 2){
            UISetup.select(scene: scene, row: rowCount+1, col1: i1, col2: i2, color1: colors[i1], color2: colors[i2], pal: self)
        }
        else{
            UISetup.select(scene: scene, row: rowCount, col1: i1, col2: i2, color1: colors[i1], color2: colors[i2], pal: self)
        }
        
      
       
        if (colors[i1] > colors[i2]){
            return 1
        }
        else if (colors[i1] < colors[i2]){
            return -1
        }
        else{
            return 0
        }
    }
  
    public func color(i:Int)->Int{
        return colors[i]
    }
    public func setMin(min: Int){
        rowCount += 1
        let rc = self.rowCount
         self.actions[self.sort].append(SKAction.run { UISetup.initColorRow(row: rc, scene: self.scene, iColors: self.colors, sort: self.sort)})
    
        self.minInt = min
    }
    public func changeMin(min: Int){
        
        self.minInt = min
    }
    public func min() ->Int{
        return minInt
    }
    public func swap(e1: Int, e2: Int){
        print("sw", self.sort, self.colors)
        UISetup.swap(scene: scene, row: rowCount, col1: e1, col2: e2, color1: colors[e1], color2: colors[e2],  pal: self)
            let temp = self.colors[e1]
            self.colors[e1] = self.colors[e2]
            self.colors[e2] = temp
    }
  
    public func group(start: Int, end: Int){
        let remainder = colors[order.count...colors.count-1]
        colors = order + remainder
        rowCount += 1
        UISetup.select50(scene: scene, row: rowCount, start: start, end: end, data: colors, pal: self)
        
        
    }
    public func push (i: Int, e: Int){
       print("sl", self.sort, self.colors)
        UISetup.select(scene: scene, row: rowCount+1, col: i, color: e, pal: self)
    }
 
    public func reset(colors: [Int], sort: Int){
 
        self.sort = sort
        rowCount = 0
        self.colors = colors
        
        actions[self.sort].append(SKAction.run { UISetup.initColorRow(row: 0, scene: self.scene, iColors: self.colors, sort: self.sort)})
       

    }
}
