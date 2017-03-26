import UIKit
import SpriteKit
import SceneKit
import XCPlayground
import PlaygroundSupport

public class UISetup {
    static let colors = ["red", "yellow", "green", "blue", "purple"]
    static let sorts = ["SSCanvas", "ISCanvas", "MSCanvas"]
    static let frames = [14, 20, 0]
    static let pics = ["cat", "hp", "fw"]
    
    private static func getcTextures() -> [SKTexture] {
        return UISetup.colors.map { SKTexture(imageNamed: "color-\($0)") }
    }
    private static func getsTextures() -> [SKTexture] {
        return UISetup.colors.map { SKTexture(imageNamed: "color-selected-\($0)") }
    }
  
    private static func getAnimations(sort:Int) -> [SKTexture] {
         print("framcount")
        var arr = [Int] ()
        
         print("framcount", arr)
        arr += 1...frames[sort]
        print("framcount", arr)
         arr += arr.reversed()
         print("framcount", arr)
   
        return arr.map { SKTexture(imageNamed: pics[sort] + "\($0)") }
    }

    private static func createColorNode(i: Int, cTextures: [SKTexture]) -> SKSpriteNode {
        let color = SKSpriteNode(texture: cTextures[i])
        return color
    }


   
      


    

 
    
    private static func initColorRow(palette: SKNode, row: Int, scene: SKScene, iColors: [Int], sort: Int){
        
        var col = 1
        let textures = UISetup.getcTextures()
        for color in iColors{
            if(sort == 2 && row == 0){
           
               UISetup.opacityChangeForward(color: color, index: iColors.index(of:color)!, scene: scene, sort: sort)
            }
            else{
                UISetup.opacityChange(color: color, index: iColors.index(of:color)!, scene: scene, sort: sort)
            }
            UISetup.displayColor(color: textures[color], row: row, col: iColors.index(of:color)!, scene: scene)
            col += 1
        }
    }

  
    public static func setRow(scene: SKScene, colors: [Int], row: Int, pal:Palette, sort: Int){
  
        if let palette = scene.childNode(withName:"palette"){
      
            let initPalette = SKAction.run { UISetup.initColorRow(palette: palette, row: row, scene: scene, iColors: colors, sort: sort) }
           
            
            pal.addAction(action: initPalette)
            
        }
        
    }

    


    public static func select(scene: SKScene, row: Int, col1: Int, col2: Int, color1: Int,  color2: Int, pal: Palette) ->Void{
        //let pic = SKAction.run {UISetup.op}
    
        let run = SKAction.run{UISetup.displaySelect(scene: scene, row: row, col1: col1, col2: col2, color1: color1, color2: color2, pal: pal)}
      
        pal.addAction(action: run)
        let wait = SKAction.wait(forDuration: 1.0, withRange: 0.5)
        pal.addAction(action: wait)
        let remove = SKAction.run{UISetup.removeSelect(scene: scene, row: row, col1: col1, col2: col2,color1: color1, color2: color2, pal: pal)}
        pal.addAction(action: remove)
    }
    public static func select(scene: SKScene, row: Int, col: Int, color: Int,   pal: Palette) ->Void{
        //let pic = SKAction.run {UISetup.op}
        
        let run = SKAction.run{UISetup.displaySelect(scene: scene, row: row, col: col, color1: color, pal: pal)}
        
        pal.addAction(action: run)
        let wait = SKAction.wait(forDuration: 1.0, withRange: 0.5)
        pal.addAction(action: wait)
        let remove = SKAction.run{UISetup.removeSelect(scene: scene, row: row, col: col, color: color, pal: pal)}
        pal.addAction(action: remove)
        let opacityChange = SKAction.run {UISetup.opacityChangeForward(color: color, index: col, scene: scene, sort: 2)}
        pal.addAction(action: opacityChange)
    }
    public static func select50(scene: SKScene, row: Int, start: Int, end: Int, data: [Int], pal: Palette) ->Void{
        //let pic = SKAction.run {UISetup.op}
         UISetup.setRow(scene: scene, colors: data, row: row, pal: pal, sort: 2)
        let run = SKAction.run{UISetup.displaySelect50(scene: scene, row: row, start: start, end: end, data: data, pal: pal)}
       
        pal.addAction(action: run)
        let wait = SKAction.wait(forDuration: 1.0, withRange: 0.5)
        pal.addAction(action: wait)
        let remove = SKAction.run{UISetup.removeSelect(scene: scene, row: row, start: start, end: end, data: data, pal: pal)}
        pal.addAction(action: remove)
    }
    public static func swap(scene: SKScene, row: Int, col1: Int, col2: Int,  color1: Int, color2: Int, pal: Palette){
        let run = SKAction.run{UISetup.displaySwap(scene: scene, row: row, col1: col1, col2: col2, color1: color1, color2: color2, pal: pal)}
        pal.addAction(action: run)
        let wait = SKAction.wait(forDuration: 1.0, withRange: 0.5)
        pal.addAction(action: wait)
        let remove = SKAction.run{UISetup.removeSwap(scene: scene, row: row, col1: col1, col2: col2, color1: color1, color2: color2,  pal: pal)}
        pal.addAction(action: remove)
     
    }
    public static func displaySwap(scene: SKScene, row: Int, col1: Int, col2:Int, color1:Int, color2:Int,  pal: Palette){
        let textures = UISetup.getcTextures()
        let rS = String(row)
        let cS = String(col1+1)
        let cS1 = String(col2+1)
        
        if  let node: SKSpriteNode = scene.childNode(withName:"palette")?.childNode(withName: rS)?.childNode(withName: cS) as? SKSpriteNode{
            
            let tex =  SKTexture(imageNamed: "color-selected-\(colors[color2])")
            
         
            node.texture = tex
            node.size.height = 75.0
            node.size.width = 75.0
            node.alpha = 1.0
        }
        if  let node1: SKSpriteNode = scene.childNode(withName:"palette")?.childNode(withName: rS)?.childNode(withName: cS1) as? SKSpriteNode{
            
            let tex =  SKTexture(imageNamed: "color-selected-\(colors[color1])")
            
            node1.texture = tex
            node1.size.height = 75.0
            node1.size.width = 75.0
        }
        
    }
    public static func displaySelect(scene: SKScene, row: Int, col1: Int, col2:Int, color1: Int, color2: Int,  pal: Palette){
        let textures = UISetup.getcTextures()
        let rS = String(row)
        let cS = String(col1+1)
        let cS1 = String(col2+1)
     
        if  let node: SKSpriteNode = scene.childNode(withName:"palette")?.childNode(withName: rS)?.childNode(withName: cS) as? SKSpriteNode{
          
           let tex =  SKTexture(imageNamed: "color-selected-\(colors[color1])")
            
         
            node.texture = tex
            node.size.height = 75.0
            node.size.width = 75.0
            node.alpha = 1.0
        }
        if  let node1: SKSpriteNode = scene.childNode(withName:"palette")?.childNode(withName: rS)?.childNode(withName: cS1) as? SKSpriteNode{
    
            let tex =  SKTexture(imageNamed: "color-selected-\(colors[color2])")
      
            node1.texture = tex
            node1.size.height = 75.0
            node1.size.width = 75.0
        }
        
    }
    public static func displaySelect(scene: SKScene, row: Int, col: Int, color1: Int,  pal: Palette){
        let textures = UISetup.getcTextures()
        let rS = String(row)
        let cS = String(col+1)
   
        
        if  let node: SKSpriteNode = scene.childNode(withName:"palette")?.childNode(withName: rS)?.childNode(withName: cS) as? SKSpriteNode{
            
            let tex =  SKTexture(imageNamed: "color-selected-\(colors[color1])")
            
            
            node.texture = tex
            node.size.height = 75.0
            node.size.width = 75.0
            node.alpha = 1.0
        }
      
        
    }
    public static func displaySelect50(scene: SKScene, row: Int, start: Int, end:Int, data: [Int],  pal: Palette){
        let textures = UISetup.getcTextures()
        let rS = String(row)

        
        for i in start..<end+1{
                 let cS = String(i+1)
             
            if  let node: SKSpriteNode = scene.childNode(withName:"palette")?.childNode(withName: rS)?.childNode(withName: cS) as? SKSpriteNode{
                
                let tex =  SKTexture(imageNamed: "color-selected-\(colors[data[i]])")
             
                
                node.texture = tex
                node.size.height = 75.0
                node.size.width = 75.0
                node.alpha = 0.5
            }
        }
       
   
        
    }
    public static func removeSelect(scene: SKScene, row: Int, col1: Int, col2:Int, color1: Int, color2: Int, pal: Palette){
        let rS = String(row)
        let cS = String(col1+1)
        let cS1 = String(col2+1)

        if  let node: SKSpriteNode = scene.childNode(withName:"palette")?.childNode(withName: rS)?.childNode(withName: cS) as? SKSpriteNode{
      
            let tex =  SKTexture(imageNamed: "color-\(colors[color1])")
           
            node.texture = tex
            node.size.height = 50.0
            node.size.width = 50.0
            node.alpha = 1.0
        }
        if  let node1: SKSpriteNode = scene.childNode(withName:"palette")?.childNode(withName: rS)?.childNode(withName: cS1) as? SKSpriteNode{
      
            let tex =  SKTexture(imageNamed: "color-\(colors[color2])")
   
            node1.texture = tex
            node1.size.height = 50.0
            node1.size.width = 50.0
        }
        
    }
    public static func removeSelect(scene: SKScene, row: Int, col: Int, color: Int, pal: Palette){
        let rS = String(row)
        let cS = String(col+1)
     
        
        if  let node: SKSpriteNode = scene.childNode(withName:"palette")?.childNode(withName: rS)?.childNode(withName: cS) as? SKSpriteNode{
            
            let tex =  SKTexture(imageNamed: "color-\(colors[color])")
            
            node.texture = tex
            node.size.height = 50.0
            node.size.width = 50.0
            node.alpha = 1.0
        }
  
        
    }
    public static func removeSelect(scene: SKScene, row: Int, start: Int, end:Int, data: [Int],  pal: Palette){
        let textures = UISetup.getcTextures()
        let rS = String(row)
        
        
        for i in start..<end+1{
            let cS = String(1 + i)
            if  let node: SKSpriteNode = scene.childNode(withName:"palette")?.childNode(withName: rS)?.childNode(withName: cS) as? SKSpriteNode{
                
                let tex =  SKTexture(imageNamed: "color-\(colors[data[i]])")
                node.alpha = 1.0
                node.texture = tex
                node.size.height = 50.0
                node.size.width = 50.0
            }
        }
        
        
        
    }
    public static func removeSwap(scene: SKScene, row: Int, col1: Int, col2:Int, color1: Int, color2: Int, pal: Palette){
        let rS = String(row)
        let cS = String(col1+1)
        let cS1 = String(col2+1)
        
        if  let node: SKSpriteNode = scene.childNode(withName:"palette")?.childNode(withName: rS)?.childNode(withName: cS) as? SKSpriteNode{
            
            let tex =  SKTexture(imageNamed: "color-\(colors[color2])")
            
            node.texture = tex
            node.size.height = 50.0
            node.size.width = 50.0
            node.alpha = 1.0
        }
        if  let node1: SKSpriteNode = scene.childNode(withName:"palette")?.childNode(withName: rS)?.childNode(withName: cS1) as? SKSpriteNode{
            
            let tex =  SKTexture(imageNamed: "color-\(colors[color1])")
            
            node1.texture = tex
            node1.size.height = 50.0
            node1.size.width = 50.0
        }
        
    }
    
    private static func displayColor(color: SKTexture, row: Int, col: Int, scene: SKScene) -> Void {
        let rS = String(row)
        let cS = String(col+1)
   
        if  let node: SKSpriteNode = scene.childNode(withName:"palette")?.childNode(withName: rS)?.childNode(withName: cS) as? SKSpriteNode{
            node.alpha = 1.0
            node.texture = color
            
        }
      
    }
    

    public static func play(scene:SKScene, pal: Palette)-> Void{
        let palette = scene.childNode(withName:"palette")
        palette!.run(SKAction.sequence(pal.getActions()))
        
    }
    

    
   
    public static func start() -> SKScene{
        let cfURL = Bundle.main.url(forResource: "SFMono-Regular", withExtension: "otf") as! CFURL
        CTFontManagerRegisterFontsForURL(cfURL , CTFontManagerScope.process, nil)
        let sceneView = SKView(frame: CGRect(x: 0, y: 0, width: 512, height: 384))
        let scene = SKScene(fileNamed: "GameScene")
        scene?.scaleMode = .aspectFill
        sceneView.presentScene(scene)
        PlaygroundPage.current.liveView = sceneView
        return scene!
    }
    private static func opacityChange(color: Int, index: Int, scene: SKScene, sort: Int ){
     
      
        if let node = scene.childNode(withName: "canvas")?.childNode(withName: sorts[sort])?.childNode(withName: pics[sort])?.childNode(withName: pics[sort]+"-"+colors[color]){
        
            node.alpha = CGFloat(5-abs(color-index))/5.0
        }
        
    }
    private static func opacityChangeForward(color: Int, index: Int, scene: SKScene, sort: Int ){
        
        print("change")
        if let node = scene.childNode(withName: "canvas")?.childNode(withName: sorts[sort])?.childNode(withName: pics[sort])?.childNode(withName: pics[sort]+"-"+colors[color]){
           
            node.alpha = CGFloat(5-abs(color-index))/5.0
             print(color, index)
        }
        
    }
    private static func moveCanvasOut(sort: Int, scene:SKScene){
        if let node = scene.childNode(withName: "canvas")?.childNode(withName: sorts[sort]){
            let act = SKAction.moveTo(y: 1100, duration: 3.0)
            node.run(act)
        }
    }
    private static func fadeOutColorRow(rows: Int, scene: SKScene, iColors: [Int]){
        var col = 1
        let textures = UISetup.getcTextures()
        for row in 1...rows{
            for color in iColors{
            UISetup.removeColor(color: textures[color], row: row, col: iColors.index(of:color)!, scene: scene)
            col += 1
        }
        }
    }
    private static func removeColor(color: SKTexture, row: Int, col: Int, scene: SKScene) -> Void {
        let rS = String(row)
        let cS = String(col+1)
        
        if  let node: SKSpriteNode = scene.childNode(withName:"palette")?.childNode(withName: rS)?.childNode(withName: cS) as? SKSpriteNode{
            let act = SKAction.fadeOut(withDuration: 0.5)
            node.run(act)
          //node.texture =
        }
        
    }
    private static func changeTite(scene:SKScene, sort:Int){
        if  let node: SKSpriteNode = scene.childNode(withName:"palette")?.childNode(withName: "palette-title") as? SKSpriteNode{
            let texture = SKTexture(imageNamed: sorts[sort+1]+"-title")
            node.texture = texture
            node.alpha = 1.0
            
        }
    }
    public static func reset(sort: Int, scene: SKScene, pal: Palette){
        let fadeOut = SKAction.run{UISetup.fadeOutColorRow( rows: pal.colors().count, scene: scene, iColors: pal.colors())}
        pal.addAction(action: fadeOut)
        let act = SKAction.run{UISetup.moveCanvasOut(sort: sort, scene: scene)}
        pal.addAction(action: act)
        let changeTitle = SKAction.run {UISetup.changeTite(scene: scene, sort: sort)}
        pal.addAction(action: changeTitle)
        let wait = SKAction.wait(forDuration: 1.0, withRange: 0.5)
        pal.addAction(action: wait)

    }
    public static func removePic (sort: Int, scene: SKScene, pal: Palette){
        for color in colors{
            if let node = scene.childNode(withName: "canvas")?.childNode(withName: sorts[sort])?.childNode(withName: pics[sort])?.childNode(withName: pics[sort] + "-" + color) as? SKSpriteNode{
            node.alpha = 0.0
            
        }
        }
    }
    public static func setTextures (sort: Int, scene: SKScene, pal: Palette){
        if let node = scene.childNode(withName: "canvas")?.childNode(withName: sorts[sort])?.childNode(withName: pics[sort]) as? SKSpriteNode{
            print(getAnimations(sort: sort))
            let action = SKAction.animate(with: getAnimations(sort: sort), timePerFrame: 0.2)
            node.run(action)
            node.texture = getAnimations(sort: sort)[10]
           
        }
    }
    public static func animate (sort: Int, scene: SKScene, pal: Palette){
        print("animating")
        let remove = SKAction.run{UISetup.removePic(sort:sort, scene: scene, pal: pal)}
        pal.addAction(action: remove)
        let animate = SKAction.run {UISetup.setTextures(sort: sort, scene: scene, pal: pal)}
        
        pal.addAction(action: animate)
        let wait = SKAction.wait(forDuration: 10.0, withRange: 0.5)
        pal.addAction(action: wait)
    }
}
