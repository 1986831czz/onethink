//
//  GameScene.swift
//  Magic Round
//
//  Created by Wade C on 4/25/19.
//  Copyright © 2019 Wade C. All rights reserved.
//

import SpriteKit
import GameplayKit
import GameKit

class GameScene: SKScene {
    
    var isUpdate:Bool = true
    
    var bg:SKSpriteNode?
    var square:SKSpriteNode?
    var countClick:Double = 0
    var buttonMenu:SKSpriteNode?
    var labelScore:SKLabelNode?
    
    var arrCircle:ArrayList<SKSpriteNode> = ArrayList()
    var countScore:Int = 0
    
    var gameTimer: Timer!
    
    let actionSoundScore:SKAction = SKAction.playSoundFileNamed("scored.mp3", waitForCompletion: false)
    let actionSoundFail:SKAction = SKAction.playSoundFileNamed("fail.mp3", waitForCompletion: false)
    
    override func didMove(to view: SKView) {
        bg = SKSpriteNode(imageNamed: "bg.png")
        bg?.position = CGPoint(x: self.size.width / 2, y: self.size.height/2)
        bg?.zPosition = 0
        self.addChild(bg!)
        
        buttonMenu = SKSpriteNode(imageNamed: "buttonMenu.png")
        buttonMenu?.position = CGPoint(x: buttonMenu!.size.width/2 + 5, y: self.size.height - buttonMenu!.size.height/2 - 50)
        buttonMenu?.name = "buttonMenu"
        buttonMenu?.zPosition = 1
        self.addChild(buttonMenu!)
        
        square = SKSpriteNode(imageNamed: "square.png")
        square?.position = CGPoint(x: self.size.width/2, y: (square?.size.height)!/2)
        square?.zPosition = 2
        self.addChild(square!)
        
        labelScore = SKLabelNode(fontNamed:"Junegull")
        labelScore?.text = "Score: 0";
        labelScore?.fontSize = 32
        labelScore?.fontColor = SKColor.white
        labelScore?.position = CGPoint(x: self.size.width - 300, y: buttonMenu!.position.y)
        labelScore?.zPosition = 3
        self.addChild(labelScore!)
        
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(createCircle), userInfo: nil, repeats: true)
    }
    
    func collisionWith(sprite0: SKSpriteNode, sprite1: SKSpriteNode) -> Bool {
        if(sprite0.position.x - sprite0.size.width/2 < sprite1.position.x - sprite1.size.width/2 + sprite1.size.width && sprite0.position.x - sprite0.size.width/2 + sprite0.size.width > sprite1.position.x - sprite1.size.width/2 && sprite0.position.y - sprite0.size.height/2 < sprite1.position.y - sprite1.size.height/2 + sprite1.size.height && sprite0.position.y - sprite0.size.height/2 + sprite0.size.height > sprite1.position.y - sprite1.size.height/2) {
            return true
        }
        else {
            return false
        }
    }
    
    @objc func createCircle() {
        let index:Int = Int(arc4random_uniform(4))
        
        let circle:SKSpriteNode = SKSpriteNode(imageNamed: ""+String(index)+".png")
        circle.position = CGPoint(x: self.frame.width/2, y: self.frame.height + circle.size.height/2)
        circle.name = ""+String(index)
        self.addChild(circle)
        circle.zPosition = 4
        arrCircle.add(item_: circle)
        
        let actionMove:SKAction = SKAction.moveTo(y: square!.position.y, duration: TimeInterval(1.5))
        circle.run(actionMove)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in (touches ) {
            let location = touch.location(in: self)
            
            let node:SKNode = self.atPoint(location)
            if(node.name == "buttonMenu") {
                let actionButtonMenu:SKAction = SKAction.scale(to: 0.9, duration: 0.1)
                buttonMenu?.run(actionButtonMenu, completion: {
                    let menuScene = MenuScene(size: self.size)
                    self.view?.presentScene(menuScene)
                })
            }
            else {
                countClick += 1
                let actionRotation:SKAction = SKAction.rotate(toAngle: CGFloat(Double.pi / 2.0 * countClick), duration: 0.075)
                square?.run(actionRotation)
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        if(isUpdate == true) {
            for i in 0..<arrCircle.size() {
                let image:SKSpriteNode = arrCircle.get(index: i)
                if(self.collisionWith(sprite0: square!, sprite1: image)) {
                    if(countClick.truncatingRemainder(dividingBy: 4) == 0 && image.name == "0") {
                        
                        run(actionSoundScore)
                        
                        countScore += 1
                        labelScore?.text = "Score: "+String(countScore)
                        arrCircle.removeAtIndex(index: i)
                        image.removeAllActions()
                        image.removeFromParent()
                        break;
                    }
                    else if(countClick.truncatingRemainder(dividingBy: 4) == 1 && image.name == "1") {
                        //                        let actionSoundScore:SKAction = SKAction.playSoundFileNamed("scored.mp3", waitForCompletion: false)
                        run(actionSoundScore)
                        
                        countScore += 1
                        labelScore?.text = "Score: "+String(countScore)
                        arrCircle.removeAtIndex(index: i)
                        image.removeAllActions()
                        image.removeFromParent()
                        break;
                    }
                    else if(countClick.truncatingRemainder(dividingBy: 4) == 2 && image.name == "2") {
                        //                        let actionSoundScore:SKAction = SKAction.playSoundFileNamed("scored.mp3", waitForCompletion: false)
                        run(actionSoundScore)
                        
                        countScore += 1
                        labelScore?.text = "Score: "+String(countScore)
                        arrCircle.removeAtIndex(index: i)
                        image.removeAllActions()
                        image.removeFromParent()
                        break;
                    }
                    else if(countClick.truncatingRemainder(dividingBy: 4) == 3 && image.name == "3") {
                        //                        let actionSoundScore:SKAction = SKAction.playSoundFileNamed("scored.mp3", waitForCompletion: false)
                        run(actionSoundScore)
                        
                        countScore += 1
                        labelScore?.text = "Score: "+String(countScore)
                        arrCircle.removeAtIndex(index: i)
                        image.removeAllActions()
                        image.removeFromParent()
                        break;
                    }
                    else {
                        isUpdate = false
                        //                        let actionSoundFail:SKAction = SKAction.playSoundFileNamed("fail.mp3", waitForCompletion: false)
                        run(actionSoundFail)
                        
                        UserDefaults.standard.set(countScore, forKey: "currentScore")
                        let object: Int = UserDefaults.standard.integer(forKey: "highscore")
                        
                        if(object > 0) {
                            if(object < countScore) {
                                UserDefaults.standard.set(countScore, forKey: "highscore")
                                UserDefaults.standard.synchronize()
                                
                                submitScore()
                            }
                        }
                        else {
                            UserDefaults.standard.set(countScore, forKey: "highscore")
                            UserDefaults.standard.synchronize()
                            
                            submitScore()
                        }
                        
                        gameTimer.invalidate()
                        let endScene = EndScene(size: self.size)
                        self.view?.presentScene(endScene)
                    }
                }
            }
        }
    }
    
    func submitScore() {
        let score = GKScore(leaderboardIdentifier: "net.kingcorp.rotationendless1")
        score.value = Int64(UserDefaults.standard.integer(forKey: "highscore"))
        
        GKScore.report([score], withCompletionHandler: { (error: Error?) -> Void in
            if error != nil { print(error!.localizedDescription)}
            else { print("GameCenter: Score submited")}
        })
    }
}

