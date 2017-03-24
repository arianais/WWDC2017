

let colors = ["red", "yellow", "green", "blue", "purple"]
let iColors = [4,1,0,3,2]
let cTextures: [SKTexture] = colors.map { SKTexture(imageNamed: "color-\($0)") }

func createColorNode(i: Int) -> SKSpriteNode {
    let color = SKSpriteNode(texture: cTextures[i])
    print("created", color)
    return color
}

