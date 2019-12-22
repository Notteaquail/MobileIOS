//
//  SceneElements.swift
//  GoldMiner
//
//  Created by apple on 2019/12/19.
//  Copyright © 2019 Notteaquail. All rights reserved.
//

import Foundation
import SpriteKit

class SceneElements {
    
    //MARK: Properties

    private var isCutScene = false
    private var isMenu = true
    private var isStore = false
    private var isBomb = false
    private var isGoing = false
    private var cutSceneState = 0

    
    let myHookBitMask: UInt32 = 0x0001
    let myOBJBitMask: UInt32 = 0x0002
    
    // Scene size
    var width: CGFloat
    var height: CGFloat
    
    // menu scene
    private var menu: SKSpriteNode?
    
    // main scene
    private var hook: SKSpriteNode?
    private var sPos: CGPoint?
    private var line: SKSpriteNode?
    private var miner: SKSpriteNode?
    
    private var coinCountNode: SKLabelNode?
    private var coinGoalNode: SKLabelNode?
    private var timeCountNode: SKLabelNode?
    private var treasures: Treasures?
    //private var bombTextures: [SKTexture]?
    //private var bombNode: SKSpriteNode?

    var shakeAction: SKAction?
    
    var level = 1
    var coinCount = 0
    var timeCount = 0
    var lastCoinCount = 0
    var goalCoin = 650
    var bombCount = 0
    
    // cut scene
    private var cutScene: SKSpriteNode?
    private var cutSceneBanner : SKSpriteNode?
    
    // store scene
    private var store: Store?
    
    // Music
    var musicManager: MusicManager
    
    //MARK: Initializer
    init(width: CGFloat, height: CGFloat) {
        // Set scene size
        self.width = width
        self.height = height
        
        
        
        // music init
        musicManager = MusicManager()
        musicManager.playMenu()
        
    }
    
    //MARK: menu scene
    func buildMyMenu(mineScene: SKScene) {
        // Menu
        let menuBackground = SKSpriteNode(imageNamed: "menu_bg")
        menuBackground.size = CGSize(width: width, height: height)
        menuBackground.zPosition = 20
        self.menu = menuBackground
        mineScene.addChild(menuBackground)
        print(menuBackground.size)
        
        let buttonBg = SKSpriteNode(imageNamed: "ButtonStartPrsbg")
        buttonBg.size = CGSize(width: 140, height: 140)
        buttonBg.position = CGPoint(x: -75, y: 15)
        menuBackground.addChild(buttonBg)
        
        let beginButton = SKSpriteNode(imageNamed: "ButtonStartCN")
        beginButton.size = CGSize(width: 80, height: 80)
        beginButton.position = CGPoint(x: 0, y: 0)
        buttonBg.addChild(beginButton)
        
        let worker = SKSpriteNode(imageNamed: "worker")
        worker.size = CGSize(width: 200, height: 200)
        worker.position = CGPoint(x: 75, y: -15)
        menuBackground.addChild(worker)
        
        let menu_logo = SKSpriteNode(imageNamed: "menu_logo")
        menu_logo.size = CGSize(width: menu_logo.size.width/2, height: menu_logo.size.height/2)
        menu_logo.position = CGPoint(x: 0, y: height/2-50)
        menuBackground.addChild(menu_logo)
    }
    
    //MARK: main scene
    func buildMainScene(mineScene: SKScene) {
        // Create background
        let backgroundImage = SKSpriteNode(imageNamed: "level-background-0")
        backgroundImage.position = CGPoint(x: 0, y: -40)
        backgroundImage.size = CGSize(width: width, height: height-80)
        mineScene.addChild(backgroundImage)
        
        let backgroundHead = SKSpriteNode(imageNamed: "level-background-header")
        backgroundHead.position = CGPoint(x:0, y:height/2)
        backgroundHead.size = CGSize(width: width, height: 80)
        backgroundImage.addChild(backgroundHead)
        
        
        //Create sprites
        
        // Miner
        let miner = SKSpriteNode(imageNamed: "workup4")
        miner.position = CGPoint(x: 0, y: 0)
        miner.size = CGSize(width: 70, height: 70)
        backgroundHead.addChild(miner)
        self.miner = miner
        
        
        // Treasures
        /*let gold3 = SKSpriteNode(imageNamed: "ObjGlod3_1")
        gold3.position = CGPoint(x: 0, y: 0)
        gold3.size = CGSize(width: 50, height: 50)
        gold3.anchorPoint = CGPoint(x: 0.5, y: 1)
        
        gold3.physicsBody = SKPhysicsBody(rectangleOf: gold3.size)
        gold3.physicsBody?.isDynamic = false
        gold3.physicsBody?.contactTestBitMask = self.myOBJBitMask
        mineScene.addChild(gold3)
        self.gold3 = gold3*/
        self.treasures = Treasures()
        
        // Hook line
        /*let path = UIBezierPath()
        path.move(to: CGPoint(x: miner.position.x, y: miner.position.y-20))
        //path.move(to: CGPoint(x: 0, y: 0))
        //path.addLine(to: CGPoint(x: 0, y: -15))
        path.addLine(to: CGPoint(x: miner.position.x, y: miner.position.y-40))
        path.close()
        let line = SKSpriteNode(imageNamed: "line")
        line.anchorPoint = CGPoint(x: 0.5, y: 1)
        line.position = CGPoint(x: miner.position.x, y: miner.position.y-20)
        line.size = CGSize(width: 20, height: 20)*/
        
        
        // Hook
        let hook1 = SKSpriteNode(imageNamed: "hook1")
        let hook2 = SKSpriteNode(imageNamed: "hook2")
        hook1.size = CGSize(width: 30, height: 30)
        hook2.size = CGSize(width: 30, height: 30)
        hook1.position = CGPoint(x: 0, y: height/2 - 60)
        hook2.position = CGPoint(x: 0, y: 0)
        //hook1.position = CGPoint(x: 0, y: -30)
        hook1.anchorPoint = CGPoint(x: 0.5, y: 1)
        hook2.anchorPoint = CGPoint(x: 0.5, y: 1)
        hook1.zPosition = 0
        hook2.zPosition = 2
        
        hook1.physicsBody = SKPhysicsBody(rectangleOf: hook1.size)
        hook1.physicsBody?.affectedByGravity = false
        hook1.physicsBody?.contactTestBitMask = self.myHookBitMask
        
        mineScene.addChild(hook1)
        hook1.addChild(hook2)
        //mineScene.addChild(line)
        self.hook = hook1
        self.sPos = (hook?.position)!
        //self.line = line
        
        // shake Action
        shakeAction = SKAction.sequence([SKAction.run({
            self.isGoing = false
        }), SKAction.repeatForever(SKAction.sequence([SKAction.rotate(toAngle: CGFloat(2*Double.pi-2.5/2), duration: 1, shortestUnitArc: true),SKAction.rotate(toAngle: CGFloat(2.5/2), duration: 2, shortestUnitArc: true),SKAction.rotate(toAngle: CGFloat(0), duration: 1, shortestUnitArc: true)]))])
        
        // HookAction
        self.hook?.run(shakeAction!)
        
        // coin
        let coinIcon = SKSpriteNode(imageNamed: "coin")
        coinIcon.size = CGSize(width: 30, height: 30)
        coinIcon.position = CGPoint(x: -width/2+15, y: 20)
        backgroundHead.addChild(coinIcon)
        
        let coinCount = SKLabelNode(text: String(self.coinCount))
        coinCount.fontName = "Zapfino"
        coinCount.fontColor = UIColor.green
        coinCount.fontSize = 17
        coinCount.position = CGPoint(x: -width/2+70, y: 8)
        self.coinCountNode = coinCount
        backgroundHead.addChild(coinCount)
        
        // goal
        let goalIcon = SKSpriteNode(imageNamed: "goal")
        goalIcon.size = CGSize(width: 30, height: 30)
        goalIcon.position = CGPoint(x: -width/2+15, y: -15)
        backgroundHead.addChild(goalIcon)
        
        let goalCount = SKLabelNode(text: String(self.goalCoin))
        goalCount.fontName = "Zapfino"
        goalCount.fontColor = UIColor.black
        goalCount.fontSize = 17
        goalCount.position = CGPoint(x: -width/2+70, y: -27)
        self.coinGoalNode = goalCount
        backgroundHead.addChild(goalCount)
        
        
        // time
        let timeIcon = SKSpriteNode(imageNamed: "object5")
        timeIcon.size = CGSize(width: 30, height: 30)
        timeIcon.position = CGPoint(x: width/2-100, y: -15)
        backgroundHead.addChild(timeIcon)
        
        let timeCount = SKLabelNode(text: "60")
        timeCount.fontName = "Zapfino"
        timeCount.fontColor = UIColor.black
        timeCount.fontSize = 17
        timeCount.position = CGPoint(x: width/2-70, y: -27)
        self.timeCountNode = timeCount
        backgroundHead.addChild(timeCount)
        
        /*// bomb
        let atlas = SKTextureAtlas(named: "BombAnimation")
        
        // sort
        let textureNames = (atlas.textureNames ).sorted {
            (first, second) -> Bool in return first < second
        }
        
        bombTextures = textureNames.map { (textureName) -> SKTexture in
            return atlas.textureNamed(textureName)
        }
        
        bombNode = SKSpriteNode(texture: bombTextures?[0])
        bombNode?.position = CGPoint(x: 0, y: 0)
        hook?.addChild(bombNode!)*/
    }
    
    
    //MARK: Count time down
    
    func countDown(count: Int) {
        var remainingCount: Int = count
        let codeTimer = DispatchSource.makeTimerSource(queue:DispatchQueue.global())


        // 设定这个时间源是每秒循环一次，立即开始

        codeTimer.schedule(deadline: .now(), repeating: .seconds(1))

        // 设定时间源的触发事件

        codeTimer.setEventHandler(handler: {

            // 返回主线程处理一些事件，更新UI等等

            DispatchQueue.main.async {

                // 每秒计时一次

                remainingCount -= 1

                // 时间到了取消时间源
                
                if remainingCount < 0 {
                    codeTimer.cancel()
                    self.isCutScene = true
                    self.hook?.run(SKAction.move(to: self.sPos!, duration: 0.00001))
                    self.musicManager.stopBGM()
                    self.musicManager.playPass()
                    if self.coinCount < self.goalCoin {
                        self.cutSceneState = 3
                    } else {
                        self.cutSceneState = 2
                    }
                    self.getCutScene(state: self.cutSceneState)
                } else {
                    self.timeCountNode?.text = String(remainingCount)
                }

            }

        })
        // 启动时间源

        codeTimer.resume()
    }
    
    //MARK: Cut Scene
    // State defines which cut scene should be seen, 0 is hide, 1 is begin, 2 is success, 3 is fail
    func buildCutScene(mineScene: SKScene){
        // cut scene
        let cutSceneBackground = SKSpriteNode(imageNamed: "cut-scene-background")
        cutSceneBackground.size = CGSize(width: width, height: height)
        cutSceneBackground.position = CGPoint(x: 0, y: 0)
        cutSceneBackground.zPosition = 10
        mineScene.addChild(cutSceneBackground)
        
        
        let cutSceneTitle = SKSpriteNode(imageNamed: "menu_logo")
        cutSceneTitle.size = CGSize(width: cutSceneTitle.size.width/2, height: cutSceneTitle.size.height/2)
        cutSceneTitle.position = CGPoint(x: 0, y: height/2-40)
        cutSceneBackground.addChild(cutSceneTitle)
        
        let cutSceneBanner = SKSpriteNode(imageNamed: "cut-scene-banner")
        cutSceneBanner.size = CGSize(width: (width/3)*2, height: height/2)
        cutSceneBanner.position = CGPoint(x: 0, y: height/2+100)
        cutSceneBackground.addChild(cutSceneBanner)
        self.cutSceneBanner = cutSceneBanner
        
        
        self.cutScene = cutSceneBackground
        cutScene?.isHidden = true
    }
    
    func getCutScene(state: Int){
        cutSceneBanner?.position = CGPoint(x: 0, y: height/2+100)
        switch state {
        case 0:
            hideCutScene()
        case 1:
            beginCutScene()
        case 2:
            successCutScene()
        case 3:
            failCutScene()
        default:
            cutScene?.isHidden = true
        }
    }
    
    // hide Cut Scene
    func hideCutScene() {
        self.cutSceneBanner?.removeAllChildren()
        cutScene?.isHidden = true
    }
    
    // begin Cut Scene
    func beginCutScene() {
        cutScene?.isHidden = false
        // begin
        let nextLable = SKLabelNode(text: "你本关的目标是")
        //nextLable.fontName = "Zapfino"
        nextLable.position = CGPoint(x: 0, y: height/4-50)
        cutSceneBanner?.addChild(nextLable)
        
        let coinGoal = self.coinGoalNode?.copy() as! SKLabelNode
        coinGoal.position = CGPoint(x: 0, y: -20)
        cutSceneBanner?.addChild(coinGoal)
        
        cutSceneBanner?.run(SKAction.sequence([SKAction.moveTo(y: 0, duration: 1), SKAction.wait(forDuration: 1), SKAction.run({
            self.hideCutScene()
        })]))
    }
    
    // success Cut Scene
    func successCutScene() {
        cutScene?.isHidden = false
        // success
        
        let nextLable = SKLabelNode(text: "恭喜过关，进入下一关")
        nextLable.position = CGPoint(x: 0, y: height/4-50)
        cutSceneBanner?.addChild(nextLable)
        
        let gotCoin = self.coinCountNode?.copy() as! SKLabelNode
        gotCoin.position = CGPoint(x: 0, y: 0)
        cutSceneBanner?.addChild(gotCoin)
        
        let nextButton = SKSpriteNode(imageNamed: "nextlevelCN")
        nextButton.position = CGPoint(x: -60, y: -height/4+40)
        nextButton.size = CGSize(width: 80, height: 30)
        cutSceneBanner?.addChild(nextButton)
        
        let quitButton = SKSpriteNode(imageNamed: "btn_menu")
        quitButton.position = CGPoint(x: 60, y: -height/4+40)
        quitButton.size = CGSize(width: 80, height: 30)
        cutSceneBanner?.addChild(quitButton)
        
        cutSceneBanner?.run(SKAction.moveTo(y: 0, duration: 1))
    }
    
    // fail Cut Scene
    func failCutScene() {
        cutScene?.isHidden = false
        
        // fail
        
        let failLable = SKLabelNode(text: "很遗憾，你没能过关")
        failLable.position = CGPoint(x: 0, y: height/4-50)
        cutSceneBanner?.addChild(failLable)
        
        let coinIcon = SKSpriteNode(imageNamed: "coin")
        coinIcon.size = CGSize(width: 30, height: 30)
        coinIcon.position = CGPoint(x: -15, y: 15)
        cutSceneBanner?.addChild(coinIcon)
        
        let gotCoin = self.coinCountNode?.copy() as! SKLabelNode
        gotCoin.position = CGPoint(x: 30, y: 5)
        cutSceneBanner?.addChild(gotCoin)
        
        let goalIcon = SKSpriteNode(imageNamed: "goal")
        goalIcon.size = CGSize(width: 30, height: 30)
        goalIcon.position = CGPoint(x: -15, y: -15)
        cutSceneBanner?.addChild(goalIcon)
        
        let coinGoal = self.coinGoalNode?.copy() as! SKLabelNode
        coinGoal.position = CGPoint(x: 30, y: -25)
        cutSceneBanner?.addChild(coinGoal)
        
        // button
        let retryButton = SKSpriteNode(imageNamed: "btn_retry")
        retryButton.position = CGPoint(x: -60, y: -height/4+40)
        retryButton.size = CGSize(width: 80, height: 30)
        cutSceneBanner?.addChild(retryButton)
        
        let quitButton = SKSpriteNode(imageNamed: "btn_menu")
        quitButton.position = CGPoint(x: 60, y: -height/4+40)
        quitButton.size = CGSize(width: 80, height: 30)
        cutSceneBanner?.addChild(quitButton)
        
        cutSceneBanner?.run(SKAction.moveTo(y: 0, duration: 1))
    }
    
    //MARK: store
    func buildStore(mineScene: SKScene) {
        store = Store(width: width, height: height)
        mineScene.addChild((store?.storeNode)!)
        store?.storeNode?.isHidden = true
    }
    
    //MARK: bomb
    func updateBomb(mineScene: SKScene) {
        var k = bombCount
        var x = (hook?.position.x)! + CGFloat(40)
        let bomb = SKSpriteNode(imageNamed: "object1")
        bomb.size = CGSize(width: 20, height: 20)
        bomb.position = CGPoint(x: x, y: (hook?.position.y)!)
        while k > 0 {
            let bombT = bomb.copy() as! SKSpriteNode
            bombT.position = CGPoint(x: x, y: (hook?.position.y)!)
            mineScene.addChild(bombT)
            k = k - 1
            x = x + 10
        }
    }
    
    func useBomb(mineScene: SKScene) {
        if bombCount > 0 {
            bombCount = bombCount - 1
            updateBomb(mineScene: mineScene)
            
            // animation
            
            //let animationAction = SKAction.animate(with: bombTextures!, timePerFrame: (1.0/30.0))
            
            //bombNode?.run(animationAction)
            
            hook?.children[1].removeFromParent()
            isBomb = true
            hook?.removeAllActions()
            hook?.run(SKAction.move(to: self.sPos!, duration: 0.5))
        }
    }
    
    
    
    //MARK: new game
    func newGame(mineScene: SKScene) {
        level = 1
        coinCount = 0
        coinCountNode?.text = String(coinCount)
        musicManager.stopMenu()
        
        bombCount = 0
        updateBomb(mineScene: mineScene)
        
        newLevel(level: level, mineScene: mineScene)
    }
    
    
    //MARK: new level
    func newLevel(level: Int, mineScene: SKScene) {
        lastCoinCount = coinCount
        
        // remove the nodes of last level,if there is one.
        self.treasures?.removeAll()
        
        hook?.removeAllActions()
        self.hook?.run(SKAction.move(to: self.sPos!, duration: 0.01))
        hook?.run(shakeAction!)
        
        musicManager.playCut()
        
        let quene = DispatchQueue.global()
        quene.async {
            //var count = 0
            while self.musicManager.cutPlayer.isPlaying {
                sleep(1)
                //print(count)
                //count = count + 1
            }
            self.musicManager.stopCut()
            self.musicManager.playBGM()
        }
        
        switch level {
        case 1:
            // goal
            self.goalCoin = 650
            self.coinGoalNode?.text = String(self.goalCoin)
            
            // Cut Scene
            getCutScene(state: 1)
            
            // level1
            treasures?.level1()
            
            // time
            timeCount = 63

        case 2:
            // goal
            self.goalCoin = 1650
            self.coinGoalNode?.text = String(self.goalCoin)
            
            // Cut Scene
            getCutScene(state: 1)
            
            // level2
            treasures?.level2()
            
            // time
            timeCount = 73
            
        default:
            
            // goal
            self.goalCoin = 10000
            self.coinGoalNode?.text = String(self.goalCoin)
            
            // Cut Scene
            getCutScene(state: 1)
            
            // level1
            treasures?.level1()
            
            // time
            timeCount = 103

        }
        
        treasures?.addAllToScene(mineScene: mineScene)
        
        var k = store!.ownObject.count - 1
        for obj in store!.ownObject {
            switch obj.type {
            case "leaf":
                treasures?.leaf()
            case "diamond":
                treasures?.diamond()
            case "power":
                treasures?.power()
            case "stone":
                treasures?.stone()
            case "time":
                timeCount  = timeCount + 30
            case "bomb":
                bombCount = bombCount + 1
                updateBomb(mineScene: mineScene)
            default:
                print("error product type")
            }
            coinCount = coinCount - obj.price
            coinCountNode?.text = String(coinCount)
            store?.ownObject.remove(at: k)
            k = k - 1
        }
        
        countDown(count: timeCount)
    }
    
    //MARK: touch event
    func touchEvent(location: CGPoint, mineScene: SKScene) {
        if isMenu {
            menuSceneTouch(location: location, mineScene: mineScene)
        } else {
            if isStore {
                store?.touched(x: location.x, y: location.y)
                if store!.isNext {
                    isStore = false
                    store!.isNext = false
                    store?.storeNode?.isHidden = true
                    level = level + 1
                    newLevel(level: level, mineScene: mineScene)
                }
            }
            else if isCutScene {
                cutSceneTouch(state: cutSceneState,location: location, mineScene: mineScene)
            } else {
                gameSceneTouch(location: location, mineScene: mineScene)
            }
        }
    }
    
    func menuSceneTouch(location: CGPoint, mineScene: SKScene) {
        let x = location.x
        let y = location.y
        if y < 55 && y > -25 {
            if x > -115 && x < -35 {
                // newGame
                menu?.isHidden = true
                isMenu = false
                newGame(mineScene: mineScene)
            }
        }
    }
    
    
    func gameSceneTouch(location: CGPoint, mineScene: SKScene){
        if !isGoing {
            //self.line?.run(SKAction.scale(by: 10, duration: 1))
            //suspension = false
            let r = (hook?.zRotation)!
            let goAction = SKAction.repeatForever(SKAction.sequence([SKAction.move(by: CGVector(dx: 50*sin(r), dy: -50*cos(r)), duration: 0.5), SKAction.run {
                if let x = self.hook?.position.x, let y = self.hook?.position.y, let w = self.hook?.size.width, let h = self.hook?.size.height {
                    let bw = self.width
                    let bh = self.height
                    if x < (-bw/2+w) || x > (bw/2-w) || y < (-bh/2+h) {
                        self.hook?.removeAllActions()
                        let returnAction = SKAction.move(to: (self.sPos)!, duration: 2)
                        self.hook?.run(SKAction.sequence([returnAction, self.shakeAction!]))
                        //, SKAction.wait(forDuration: returnAction.duration)
                    }
                }
                }]))
            hook?.removeAllActions()
            self.hook?.run(goAction)
            isGoing = true
        } //else {
            //useBomb(mineScene: mineScene)
        //}
    }
    
    func cutSceneTouch(state: Int, location: CGPoint, mineScene: SKScene) {
        switch state {
        case 2:
            successCutSceneTouch(location: location)
        case 3:
            failCutSceneTouch(location: location, mineScene: mineScene)
        default:
            print("No touch state")
        }
    }
    
    func successCutSceneTouch(location: CGPoint) {
        let x = location.x
        let y = location.y
        let cy = -height/4+40
        if y < cy+15 && y > cy-15 {
            if x > -100 && x < -20 {
                // nextLevel
                cutSceneState = 0
                getCutScene(state: cutSceneState)
                isCutScene = false
                
                isStore = true
                store?.creatProducts()
                store?.storeNode?.isHidden = false
            } else if x > 20 && x < 100 {
                // quit
                cutSceneState = 0
                getCutScene(state: cutSceneState)
                isCutScene = false
                self.menu?.isHidden = false
                self.isMenu = true
                self.musicManager.playMenu()
            }
        }
    }

    func failCutSceneTouch(location: CGPoint, mineScene: SKScene) {
        let x = location.x
        let y = location.y
        let cy = -height/4+40
        if y < cy+15 && y > cy-15 {
            if x > -100 && x < -20 {
                // retry
                cutSceneState = 0
                getCutScene(state: cutSceneState)
                isCutScene = false
                
                //print(lastCoinCount)
                coinCount = lastCoinCount
                self.coinCountNode?.text = String(self.coinCount)
                //print(lastCoinCount)
                newLevel(level: level, mineScene: mineScene)
            } else if x > 20 && x < 100 {
                // quit
                cutSceneState = 0
                getCutScene(state: cutSceneState)
                self.menu?.isHidden = false
                self.isMenu = true
                isCutScene = false
                musicManager.playMenu()
            }
        }
    }
    
    
    
    //MARK: Contact
    var isReturn = false
    func contactHandeler(contact: SKPhysicsContact) {
        hook?.removeAllActions()
        
        isReturn = true
        let obj = contact.bodyB.node as! TreasureNode
        obj.removeFromParent()
        obj.position = CGPoint(x: 0, y: -15)
        obj.physicsBody = nil
        hook?.addChild(obj)
        obj.zPosition = 1
        
        let r = (hook?.zRotation)!
        let goBack = SKAction.move(by: CGVector(dx: -sin(r), dy: cos(r)), duration: 0.01)
        goBack.speed = CGFloat(1/obj.weight!)
        let returnAction = SKAction.repeatForever(SKAction.sequence([goBack, SKAction.run {
            if (self.hook?.position.y)! + cos(r) >= (self.sPos?.y)! {
                self.hook?.removeAllActions()
                self.hook?.run(SKAction.move(to: self.sPos!, duration: 0.01))
            }
            }]))

        
        
        //self.hook?.run(returnAction)
        
        let addScores = SKAction.run {
            //if !self.isBomb {
                obj.removeFromParent()
                
                self.coinCount += obj.coin!
                self.coinCountNode?.text = String(self.coinCount)
                //print(self.coinCount)
                self.isReturn = false
            /*}  else {
                self.isBomb = false
            }*/
        }
        self.hook?.run(returnAction)
        
        let quene = DispatchQueue.global()
        quene.async {
            while self.hook?.position.x != self.sPos?.x || self.hook?.position.y != self.sPos?.y {}
            if !self.isCutScene {
                self.hook?.run(SKAction.sequence([addScores, self.shakeAction!]))
            }
        }
    }
    
    //MARK: Music manager
    func playMusic() {
        if isMenu {
            musicManager.playMenu()
        } else {
            if isCutScene {
                musicManager.stopMenu()
                musicManager.stopBGM()
                if cutSceneState == 1 {
                    musicManager.playCut()
                } else {
                    musicManager.playPass()
                }
            } else {
                musicManager.stopPass()
                musicManager.playBGM()
            }
        }
    }
}
