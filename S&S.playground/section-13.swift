if let pallette = scene!.childNode(withName:"//palette"){
    print("noded", pallette as Any)
    initColorRow(palette: pallette, row: 0)
    let initPalette = SKAction.run { initColorRow(palette: pallette, row: 0) }
    pallette.run(SKAction.repeat(initPalette, count: 1))
}



