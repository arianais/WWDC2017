
// Requires Xcode 8
import SpriteKit
import XCPlayground
import PlaygroundSupport

//Setup View
let scene = UISetup.start()
var colors = [4,1,0,3,2] //change numbers to colors
var palette = Palette(colors: colors, scene: scene, sort: 0)



if(palette.colors().count > 1){
   
   for element in 0 ..< palette.colors().count - 1 {
    
 
        palette.setMin(min: element)

        for search in element + 1 ..< palette.colors().count {
            if(palette.compare(i1: search, i2: palette.min()) == -1){
                palette.changeMin(min: search)
            }
            
        }
        if element != palette.min() {
       
                      
            palette.swap(e1: element, e2: palette.min())
        }

    
   }
    
}

UISetup.setRow(scene: scene, colors: palette.colors(), row: 5, pal:palette, sort: 0)


UISetup.reset(sort:0,  scene: scene, pal: palette)
palette.reset(colors: colors, sort: 1)




if( palette.colors().count > 1 ) {
    
    
    for i in 1..<palette.colors().count {
    
        palette.setMin(min: i)
 
        while palette.min() > 0 && palette.compare(i1: palette.min(), i2: palette.min()-1) < 0{
            palette.swap(e1: palette.min(), e2:  palette.min()-1)
            palette.changeMin(min: palette.min()-1)
     
        }
    }
}
UISetup.setRow(scene: scene, colors: palette.colors(), row: 5, pal:palette, sort: 1)
UISetup.reset(sort: 1, scene: scene, pal: palette)
palette.reset(colors: colors, sort: 2)

UISetup.play(scene: scene, pal: palette)





      

