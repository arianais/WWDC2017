
import UIKit
import SpriteKit
import SceneKit
import XCPlayground
import PlaygroundSupport

open class Palette {
    //fix setters & getters to be private vars
    public var doodle: Doodle
    private var actionSet:[SKAction] = []
    private var colorsArr:[Int] = []
    private var rowCount = 0
    public var sorted = false{
        didSet{
            if(sorted == true){
                print("hey")
             
             UISetup.animate(sort: self.sort, scene: self.scene, pal: self, doodle: self.doodle)
                
                
                if(sort == 0){
                       UISetup.play(scene: scene, pal: self)
                }
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
                // UISetup.setRow(scene: scene, colors: colorsArr, row: rowCount, pal: self, sort: 2)
            }
        }
        
    }
    private var minInt: Int
    private var scene:SKScene
    
    
    
    
    
    public init(colors: [Int], scene: SKScene, sort: Int, doodle: Doodle) {
        self.sort = sort
        colorsArr = colors
        self.scene = scene
        actionSet = []
        self.doodle = doodle
        minInt = colorsArr[0]
        order = []
        UISetup.setRow(scene: scene, colors: colorsArr, row: 0, pal: self, sort: sort)
  
        if(sort != 0){
           // UISetup.addButton(scene: scene, sort: sort, doodle: doodle)
            UISetup.reset(sort: sort, scene: scene, pal: self)
    
        }
        
        // UISetup.removeRow(scene: scene, colors: colorsArr, row: 0, pal:self)
    }
    public func addAction(action: SKAction){
        actionSet.append(action)
        
    }
    public func getActions()->[SKAction]{
        return actionSet
        
    }
    public func colors()->[Int]{
        //rowCount += 1
        
        
        return colorsArr
    }
    public func compare(i1: Int, i2: Int)->Int{
        
        if(sort == 2){
            UISetup.select(scene: scene, row: rowCount+1, col1: i1, col2: i2, color1: colorsArr[i1], color2: colorsArr[i2], pal: self)
        }
        else{
            UISetup.select(scene: scene, row: rowCount, col1: i1, col2: i2, color1: colorsArr[i1], color2: colorsArr[i2], pal: self)
        }
        
        
        
        if (colorsArr[i1] > colorsArr[i2]){
            return 1
        }
        else if (colorsArr[i1] < colorsArr[i2]){
            return -1
        }
        else{
            return 0
        }
    }
    
    public func color(i:Int)->Int{
        return colorsArr[i]
    }
    public func setMin(min: Int){
        rowCount += 1
        
        UISetup.setRow(scene: scene, colors: colorsArr, row: rowCount, pal:self, sort: sort)
         
        self.minInt = min
         //endCheck()
    }
    public func changeMin(min: Int){
        
        self.minInt = min
    }
    public func min() ->Int{
        return minInt
    }
    public func swap(e1: Int, e2: Int){
   
        UISetup.swap(scene: scene, row: rowCount, col1: e1, col2: e2, color1: colorsArr[e1], color2: colorsArr[e2],  pal: self)
        let temp = self.colorsArr[e1]
        self.colorsArr[e1] = self.colorsArr[e2]
        self.colorsArr[e2] = temp
        if (rowCount == 4) {
   
            let palette = scene.childNode(withName: "palette")
                let initPalette = SKAction.run { UISetup.initColorRow(palette: palette!, row: 5, scene: self.scene, iColors: self.colorsArr, sort: self.sort) }
                
                
                self.addAction(action: initPalette)
                
            
        }
    
    }
    
    public func endCheck(){
        print("EC")
        if(colorsArr == [0, 1, 2, 3, 4]){
            UISetup.setRow(scene: scene, colors: colorsArr, row: 5, pal: self, sort: sort)
            UISetup.animate(sort: sort, scene: scene, pal: self, doodle: doodle)
            
        }
    }
    public func group(start: Int, end: Int){
        let remainder = colorsArr[order.count...colorsArr.count-1]
        colorsArr = order + remainder
        rowCount += 1
        UISetup.select50(scene: scene, row: rowCount, start: start, end: end, data: colorsArr, pal: self)
        
        
    }
    public func push (i: Int, e: Int){
        
        UISetup.select(scene: scene, row: rowCount+1, col: i, color: e, pal: self)
    }
    
    public func reset(colors: [Int], sort: Int){
        
        self.sort = sort
        rowCount = 0
        colorsArr = colors
        
        UISetup.setRow(scene: scene, colors: colorsArr, row: 1, pal:self, sort: sort)
        
        
    }
}
