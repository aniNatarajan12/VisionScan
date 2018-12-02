//
//  ViewController.swift
//  VisionScan
//
//  Created by Anirudh Natarajan on 12/1/18.
//  Copyright © 2018 Anirudh Natarajan. All rights reserved.
//

import UIKit
import SpriteKit
import ARKit

var keys = [String]()
class ViewController: UIViewController, ARSKViewDelegate {
    
    @IBOutlet var sceneView: ARSKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and node count
        sceneView.showsFPS = true
        sceneView.showsNodeCount = true
        
        let scene = Scene(size: self.view.frame.size)
        sceneView.presentScene(scene)
        
        if let x = UserDefaults.standard.value(forKey: "keys") {
            keys = x as! [String]
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    // MARK: - ARSKViewDelegate
    
    func view(_ view: ARSKView, nodeFor anchor: ARAnchor) -> SKNode? {
        // Create and configure a node for the anchor added to the view's session.
        guard let i = ARBridge.shared.anchorsToIdentifiers[anchor] else {
            return nil
        }
        
        let identifier = i.split(separator: ",")
        let labelNode = SKLabelNode(text: String(identifier.first!))
        labelNode.horizontalAlignmentMode = .center
        labelNode.verticalAlignmentMode = .center
        labelNode.fontName = UIFont.boldSystemFont(ofSize: 16).fontName
        
        if let x = UserDefaults.standard.value(forKey: String(identifier.first!)) {
            let alert = UIAlertController(title: String(identifier.first!), message: x as! String, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            //1. Create the alert controller.
            let alert = UIAlertController(title: "Significance", message: "Please enter the significance of the object: \(String(identifier.first!))", preferredStyle: .alert)
            
            //2. Add the text field. You can configure it however you need.
            alert.addTextField { (textField) in
                textField.text = ""
            }
            
            // 3. Grab the value from the text field, and print it when the user clicks OK.
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
                let textField = alert!.textFields![0] // Force unwrapping because we know it exists.
                if textField.text == ""{
                    
                } else {
                    UserDefaults.standard.set(textField.text, forKey: String(identifier.first!))
                    keys.append(String(identifier.first!))
                    UserDefaults.standard.set(keys, forKey: "keys")
                }
            }))
            
            // 4. Present the alert.
            self.present(alert, animated: true, completion: nil)
        }
        
        return labelNode
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
    }
}
