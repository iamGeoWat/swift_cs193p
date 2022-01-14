//
//  EmojiArtModel.Background.swift
//  EmojiArt
//
//  Created by GeoWat on 2022/1/14.
//

import Foundation

extension EmojiArtModel {
    
    enum Background {
        case blank
        case url(URL) // utilizing associated data
        case imageData(Data) // URL and Data are specific types
        
        // for convenience, a syntax sugar - getter, thing
        // so user don't need to switch and find URL or Data
        var url: URL? {
            switch self {
            case .url(let url):
                return url
            default:
                return nil
            }
        }
        
        var imageData: Data? {
            switch self {
            case .imageData(let data):
                return data
            default:
                return nil
            }
        }
    }

}
