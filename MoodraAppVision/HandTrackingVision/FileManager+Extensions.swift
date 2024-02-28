//
//  FileManager+Extensions.swift
//  MoodraAppVision
//
//  Created by Matteo Perotta on 28/02/24.
//

import Foundation

extension FileManager {
    func clearTmpDirectory() {
        do {
            let tmpDirURL = FileManager.default.temporaryDirectory
            let tmpDirectory = try contentsOfDirectory(atPath: tmpDirURL.path)
            try tmpDirectory.forEach { file in
                let fileUrl = tmpDirURL.appendingPathComponent(file)
                try removeItem(atPath: fileUrl.path)
            }
        } catch {
            //catch the error somehow
        }
    }
}
