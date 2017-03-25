
import UIKit
import SpriteKit
import SceneKit
import XCPlayground
import PlaygroundSupport

open class Palette {
    //fix setters & getters to be private vars
    private var actionSet:[SKAction] = []
    private var colorsArr:[Int] = []
    private var rowCount = 0
    private var sort: Int
    public var msArr:[Int] = []
    public var middle: Int = 0
    public var order:[Int]{
        didSet{
          // rowCount += 1
        //UISetup.setRow(scene: scene, colors: colors(), row: rowCount, pal: self, sort: 2)
           
        }
    }
    private var minInt: Int
    private var scene:SKScene

 
    
    
  
    public init(colors: [Int], scene: SKScene, sort: Int) {
        self.sort = sort
        colorsArr = colors
        self.scene = scene
        actionSet = []
        minInt = colorsArr[0]
        order = []
        UISetup.setRow(scene: scene, colors: colorsArr, row: 0, pal:self, sort: sort)
        rowCount = 1
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
        
  //change the rc + 1 for non ms
        UISetup.select(scene: scene, row: rowCount+1, col1: i1, col2: i2, color1: colorsArr[i1], color2: colorsArr[i2], pal: self)
      
       
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
    }
    public func changeMin(min: Int){
        
        self.minInt = min
    }
    public func min() ->Int{
        return minInt
    }
    public func swap(e1: Int, e2: Int){
  
        UISetup.swap(scene: scene, row: rowCount+1, col1: e1, col2: e2, color1: colorsArr[e1], color2: colorsArr[e2],  pal: self)
            let temp = self.colorsArr[e1]
            self.colorsArr[e1] = self.colorsArr[e2]
            self.colorsArr[e2] = temp
    }
  
    public func group(start: Int, end: Int){
        UISetup.select50(scene: scene, row: rowCount+1, start: start, end: end, data: colorsArr, pal: self)
        
    }
 
    public func reset(colors: [Int], sort: Int){
 
        self.sort = sort
        rowCount = 0
        colorsArr = colors
        
        UISetup.setRow(scene: scene, colors: colorsArr, row: 1, pal:self, sort: sort)
     

    }
}
