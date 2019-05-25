import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = MenuScene(size: CGSize(width: 768, height: 1024))
        
        // Configure the view.
        let skView = self.view as! SKView
        skView.showsFPS = false
        skView.showsNodeCount = false
        
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true
        
        //        /* Set the scale mode to scale to fit the window */
        //        scene.scaleMode = .AspectFill
        
        skView.presentScene(scene)
    }

    override var shouldAutorotate: Bool {
        return true
    }

//    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
//        if UIDevice.current.userInterfaceIdiom == .phone {
//            return .allButUpsideDown
//        } else {
//            return .all
//        }
//    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
