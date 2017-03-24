
//let fireBalloon: (SKSpriteNode, SKNode) -> Void = { balloon, cannon in
//    let impulseMagnitude: CGFloat = 70.0
//    
//    let xComponent = cos(cannon.zRotation) * impulseMagnitude
//    let yComponent = sin(cannon.zRotation) * impulseMagnitude
//    let impulseVector = CGVector(dx: xComponent, dy: yComponent)
//    
//    balloon.physicsBody!.applyImpulse(impulseVector)
//}
//
//func fireCannon(cannon: SKNode) {
//    let balloon = createRandomBalloon()
//    
//    displayBalloon(balloon, cannon)
//    fireBalloon(balloon, cannon)
//}


func initColorRow(palette: SKNode, row: Int){
    var col = 1

    for color in iColors{
        let node = createColorNode(i: color)
    
        displayColor(node, palette , row, col)
        col += 1
    }
}

