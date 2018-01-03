//
//  ViewController.swift
//  FolioTest
//
//  Created by Adriano Rezena on 02/01/2018.
//  Copyright © 2018 Adriano Rezena. All rights reserved.
//

import UIKit
import FolioReaderKit

class ViewController: UIViewController {
        
    @IBOutlet var bookButton: UIButton!
    let folioReader = FolioReader()
    var bookPath: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getBookCover(sender: self)
    }

    func getBookCover(sender: AnyObject) {
        bookPath = Bundle.main.path(forResource: "FolioReader", ofType: "epub")
        
        do {
            if let image = try FolioReader.getCoverImage(bookPath!) {
                bookButton.setBackgroundImage(image, for: .normal)
                bookButton.imageView?.contentMode = .scaleAspectFit
            }
        } catch let e as FolioReaderError {
            print(e.localizedDescription)
        } catch {
            print("Unkown error")
        }
    }
    
    @IBAction func bookButtonTapped(_ sender: UIButton) {
        let config = FolioReaderConfig(withIdentifier: "READER")
        config.shouldHideNavigationOnTap = false
        config.scrollDirection = .horizontal
        config.quoteCustomBackgrounds = []
        
        /*if let image = UIImage(named: "demo-bg") {
            let customImageQuote = QuoteImage(withImage: image, alpha: 0.6, backgroundColor: UIColor.black)
            config.quoteCustomBackgrounds.append(customImageQuote)
        }*/
        
        let textColor = UIColor(red:0.86, green:0.73, blue:0.70, alpha:1.0)
        let customColor = UIColor(red:0.30, green:0.26, blue:0.20, alpha:1.0)
        let customQuote = QuoteImage(withColor: customColor, alpha: 1.0, textColor: textColor)
        config.quoteCustomBackgrounds.append(customQuote)

        config.localizedReaderOnePageLeft = "última página"
        config.localizedReaderManyPagesLeft = "páginas restando"
        config.localizedReaderLessThanOneMinute = "Menos de 1 minuto"
        config.localizedReaderOneMinute = "1 minuto"
        config.localizedReaderManyMinutes = "minutos"
        config.localizedContentsTitle = "Índice"
        config.localizedHighlightsTitle = "Destaques"
        config.localizedFontMenuDay = "Dia"
        config.localizedFontMenuNight = "Noite"
        config.localizedHighlightMenu = "Destacar"
        config.localizedDefineMenu = "Dicionário"
        config.localizedPlayMenu = "Ouvir"

        folioReader.presentReader(parentViewController: self, withEpubPath: bookPath!, andConfig: config, shouldRemoveEpub: false, animated: true)
    }
}

