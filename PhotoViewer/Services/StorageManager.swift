//
//  StorageManager.swift
//  PhotoViewer
//
//  Created by Alex Kulish on 07.06.2022.
//

import UIKit

class StorageManager {
    
    static let shared = StorageManager()
    
    private init() {}
    
    func setSettingsButtons(photoString: Photo) {
        UserDefaults.standard.setValue(encodable: photoString, forKey: "photo")
    }
    
    func loadSettingsButtons() -> Photo? {
        guard let photo = UserDefaults.standard.loadValue(Photo.self, forKey: "photo") else { return nil}
        return photo
    }
    
    func reset() {
        UserDefaults.standard.removeObject(forKey: "photo")
    }
    
}
