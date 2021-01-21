//
//  GameViewController.swift
//  MyGames
//
//  Created by Joao Queiroz on 21/01/21.
//  Copyright © 2021 Joao Queiroz. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbConsole: UILabel!
    @IBOutlet weak var lbRelease: UILabel!
    
    @IBOutlet weak var ivCover: UIImageView!
    
    
    var game: Game!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        lbTitle.text = game.title
        lbConsole.text = game.console?.name
        if let release = game.releaseDate{
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            formatter.locale = Locale(identifier: "pt-BR")
            lbRelease.text = "Lançamento: " + formatter.string(from: release)
        }
        if let image = game.cover as? UIImage{
            ivCover.image = image
        } else{
            ivCover.image = UIImage(named: "noCoverFull")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! AddEditViewController
        vc.game = game
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
