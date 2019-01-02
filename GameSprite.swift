//
//  GameSprite.swift
//  Benjamin and Ninjamen
//
//  Created by Jonathan Andrew Hendrix on 1/19/18.
//  Copyright © 2018 Neon Night Riders. All rights reserved.
//

import SpriteKit

protocol GameSprite {
    var textureAtlas:SKTextureAtlas { get set }
    var initialSize: CGSize { get set }
    func onTap()
}
