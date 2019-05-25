import UIKit
import SpriteKit
import GameKit

class MenuScene: SKScene, GKGameCenterControllerDelegate {

    var bg:SKSpriteNode?
    var buttonPlay:SKSpriteNode?
    var buttonNormal:SKSpriteNode?
    var buttonHard:SKSpriteNode?
    var buttonGC:SKSpriteNode?
    
    var heighButton:CGFloat = 96
    var khoangCach:CGFloat = 5
    var soLuongButton:CGFloat = 3
    
    var labelMode0:SKLabelNode?
    var labelMode1:SKLabelNode?
    
    override func didMove(to view: SKView) {
        bg = SKSpriteNode(imageNamed: "bg.png")
        bg?.position = CGPoint(x: self.size.width / 2, y: self.size.height/2)
        bg?.zPosition = 0
        self.addChild(bg!)
        
        buttonPlay = SKSpriteNode(imageNamed: "buttonPlay.png")
        let h:CGFloat = soLuongButton * heighButton
        let h1:CGFloat = khoangCach * (soLuongButton - 1)
        let h3:CGFloat = h + h1
        let h4:CGFloat = (self.size.height - h3) / 2 + h3 - heighButton/2
        buttonPlay?.position = CGPoint(x: self.size.width / 2, y:h4 + 100)
        buttonPlay?.name = "buttonPlay"
        buttonPlay?.zPosition = 1
        self.addChild(buttonPlay!)
        
        buttonNormal = SKSpriteNode(imageNamed: "buttonNormal.png")
        buttonNormal?.position = CGPoint(x: self.size.width / 2, y:(buttonPlay?.position.y)! - heighButton - khoangCach)
        buttonNormal?.name = "buttonNormal"
        buttonNormal?.zPosition = 2
        self.addChild(buttonNormal!)
        
        buttonGC = SKSpriteNode(imageNamed: "gc.png")
        buttonGC?.position = CGPoint(x: self.size.width / 2, y:(buttonNormal?.position.y)! - heighButton - khoangCach - 65)
        buttonGC?.name = "buttonGC"
        buttonGC?.zPosition = 10
        self.addChild(buttonGC!)
        
        let highScore: Int = UserDefaults.standard.integer(forKey: "highscore")
        let highscoreNormal: Int = UserDefaults.standard.integer(forKey: "highscoreNormal")
        
        labelMode1 = SKLabelNode(fontNamed:"Junegull")
        labelMode1?.fontSize = 32
        labelMode1?.fontColor = SKColor.white
        labelMode1?.text = "Easy - Best Score: " + String(highscoreNormal)
        labelMode1?.position = CGPoint(x: self.size.width/2, y: self.size.height/2 - 250)
        labelMode1?.zPosition = 3
        self.addChild(labelMode1!)
        
        labelMode0 = SKLabelNode(fontNamed:"Junegull")
        labelMode0?.fontSize = 32
        labelMode0?.fontColor = SKColor.white
        labelMode0?.text = "Difficult - Best Score: " + String(highScore)
        labelMode0?.position = CGPoint(x: self.size.width/2, y: self.size.height/2 - 300)
        labelMode0?.zPosition = 4
        self.addChild(labelMode0!)
        
        authenticateLocalPlayer()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in (touches ) {
            let location = touch.location(in: self)
            let node:SKNode = self.atPoint(location)

            if(node.name == "buttonPlay") {
                let actionButtonPlay:SKAction = SKAction.scale(to: 0.9, duration: 0.1)
                buttonPlay?.run(actionButtonPlay, completion: {
                    PlayMode.mode.type = 1
                    let normalScene = EasyScene(size: self.size)
                    // Configure the view.
                    
                    self.view?.showsFPS = false
                    self.view?.showsNodeCount = false
                    
                    /* Sprite Kit applies additional optimizations to improve rendering performance */
                    self.view?.ignoresSiblingOrder = true
                    
                    //        /* Set the scale mode to scale to fit the window */
                    //        scene.scaleMode = .AspectFill
                    self.view?.presentScene(normalScene)
                })
            }
            
            if(node.name == "buttonNormal") {
                let actionButtonPlay:SKAction = SKAction.scale(to: 0.9, duration: 0.1)
                buttonNormal?.run(actionButtonPlay, completion: {
                    PlayMode.mode.type = 0
                    let gameScene = GameScene(size: self.size)
                    // Configure the view.
                    
                    self.view?.showsFPS = false
                    self.view?.showsNodeCount = false
                    
                    /* Sprite Kit applies additional optimizations to improve rendering performance */
                    self.view?.ignoresSiblingOrder = true
                    
                    //        /* Set the scale mode to scale to fit the window */
                    //        scene.scaleMode = .AspectFill
                    self.view?.presentScene(gameScene)
                })
            }
            
            if(node.name == "buttonGC") {
                let actionButtonPlay:SKAction = SKAction.scale(to: 0.9, duration: 0.1)
                buttonGC?.run(actionButtonPlay, completion: {
                    self.showLeaderboard()
                })
            }
        }
    }
    
    func authenticateLocalPlayer() {
        let localPlayer: GKLocalPlayer = GKLocalPlayer.local
        localPlayer.authenticateHandler = {(ViewController, error) -> Void in
            if((ViewController) != nil) {
                // 1. Show login if player is not logged in
                self.view?.window?.rootViewController!.present(ViewController!, animated: true, completion: nil)
            }
        }
    }
    
    func showLeaderboard() {
        let gcVC: GKGameCenterViewController = GKGameCenterViewController()
        gcVC.gameCenterDelegate = self
        gcVC.viewState = GKGameCenterViewControllerState.leaderboards
//        gcVC.leaderboardIdentifier = ""
        self.view?.window?.rootViewController!.present(gcVC, animated: true, completion: nil)
    }
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
}
