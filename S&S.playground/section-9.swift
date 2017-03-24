let displayColor: (SKSpriteNode, SKNode, Int, Int) -> Void = { color, palette, row, col in
  
    let place = String(row) + "-" + String(col)
      print("nodedip", place)
    color.position = palette.childNode(withName: place)!.convert(CGPoint.zero, to: scene!)
    print("displayed", color.position)
    scene?.addChild(color)
}
