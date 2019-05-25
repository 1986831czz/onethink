import UIKit
import SpriteKit

class EndScene: SKScene {
    var bg:SKSpriteNode?
    
    var labelMode:SKLabelNode?
    
    var buttonMenu:SKSpriteNode?
    var buttonRestart:SKSpriteNode?
    
    override func didMove(to view: SKView) {
        bg = SKSpriteNode(imageNamed: "bg.png")
        bg?.position = CGPoint(x: self.size.width / 2, y: self.size.height/2)
        bg?.zPosition = 0
        self.addChild(bg!)
        
        if (PlayMode.mode.type == 0) {
            labelMode = SKLabelNode(fontNamed:"Junegull")
            labelMode?.fontSize = 32
            labelMode?.fontColor = SKColor.white
            labelMode?.text = "Difficult"
            labelMode?.position = CGPoint(x: self.size.width/2, y: self.size.height/2 + 80)
            labelMode?.zPosition = 6
            self.addChild(labelMode!)
        }
        else if (PlayMode.mode.type == 1) {
            labelMode = SKLabelNode(fontNamed:"Junegull")
            labelMode?.fontSize = 32
            labelMode?.fontColor = SKColor.white
            labelMode?.text = "Easy"
            labelMode?.position = CGPoint(x: self.size.width/2, y: self.size.height/2 + 80)
            labelMode?.zPosition = 6
            self.addChild(labelMode!)
        }
        
        let labelCurrentScore:SKLabelNode = SKLabelNode(fontNamed:"Junegull")
        labelCurrentScore.fontSize = 32
        labelCurrentScore.fontColor = SKColor.white
        labelCurrentScore.position = CGPoint(x: self.size.width/2, y: self.size.height/2 + 32)
        labelCurrentScore.zPosition = 1
        self.addChild(labelCurrentScore)
        
        let labelScore:SKLabelNode = SKLabelNode(fontNamed:"Junegull")
        labelScore.fontSize = 32
        labelScore.fontColor = SKColor.white
        labelScore.position = CGPoint(x: self.size.width/2, y: self.size.height/2 - 16)
        labelScore.zPosition = 2
        self.addChild(labelScore)
        
        if (PlayMode.mode.type == 0) {
            let myScore: Int = UserDefaults.standard.integer(forKey: "currentScore")
            let highScore: Int = UserDefaults.standard.integer(forKey: "highscore")
            
            labelCurrentScore.text = "Score: " + String(myScore)
            labelScore.text = "Best: " + String(highScore)
        }
        else if (PlayMode.mode.type == 1) {
            let myScore: Int = UserDefaults.standard.integer(forKey: "currentScoreNormal")
            let highScore: Int = UserDefaults.standard.integer(forKey: "highscoreNormal")
            
            labelCurrentScore.text = "Score: " + String(myScore)
            labelScore.text = "Best: " + String(highScore)
        }
        
        buttonMenu = SKSpriteNode(imageNamed: "buttonMenu.png")
        buttonMenu?.position = CGPoint(x: self.size.width/2, y: self.size.height/2 - 32 - buttonMenu!.size.height/2)
        buttonMenu?.name = "buttonMenu"
        buttonMenu?.zPosition = 3
        self.addChild(buttonMenu!)
        
        buttonRestart = SKSpriteNode(imageNamed: "buttonRestart.png")
        buttonRestart?.position = CGPoint(x: self.size.width/2, y: buttonMenu!.position.y - buttonMenu!.size.height - 10)
        buttonRestart?.name = "buttonRestart"
        buttonRestart?.zPosition = 4
        self.addChild(buttonRestart!)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in (touches ) {
            let location = touch.location(in: self)
            let node:SKNode = self.atPoint(location)
            
            if(node.name == "buttonMenu") {
                let actionButton:SKAction = SKAction.scale(to: 0.9, duration: 0.1)
                buttonMenu?.run(actionButton, completion: {
                    let menuScene = MenuScene(size: self.size)
                    self.view?.presentScene(menuScene)
                })
            }
            else if(node.name == "buttonRestart") {
                let actionButton:SKAction = SKAction.scale(to: 0.9, duration: 0.1)
                buttonRestart?.run(actionButton, completion: {
                    if(PlayMode.mode.type == 0) {
                        let gameScene = GameScene(size: self.size)
                        self.view?.presentScene(gameScene)
                    }
                    else if(PlayMode.mode.type == 1) {
                        let normalScene = EasyScene(size: self.size)
                        self.view?.presentScene(normalScene)
                    }
                })
            }
        }
    }
    
    //        func touchUp(atPoint pos : CGPoint) {
    //            let node:SKNode = self.atPoint(pos)
    //
    //            if(node.name == "buttonPlay") {
    //                let actionButtonPlay:SKAction = SKAction.scale(to: 0.9, duration: 0.1)
    //                buttonPlay?.run(actionButtonPlay, completion: {
    //                    print("vao day nha________")
    //
    //                    let gameScene = GameScene(size: self.size)
    //                    // Configure the view.
    //
    //                    self.view?.showsFPS = false
    //                    self.view?.showsNodeCount = false
    //
    //                    /* Sprite Kit applies additional optimizations to improve rendering performance */
    //                    self.view?.ignoresSiblingOrder = true
    //
    //                    //        /* Set the scale mode to scale to fit the window */
    //                    //        scene.scaleMode = .AspectFill
    //                    self.view?.presentScene(gameScene)
    //                })
    //            }
    //        }
}
