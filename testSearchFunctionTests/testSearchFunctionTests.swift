//
//  testSearchFunctionTests.swift
//  testSearchFunctionTests
//
//  Created by lamha on 10/1/19.
//  Copyright © 2019 zappasoft. All rights reserved.
//

import XCTest

struct SearchVideo {
    var name = ""
    var thumbnail = ""
    var description = ""
    var module = ""
    var url = ""
    var keywords = ""
}

class testSearchFunctionTests: XCTestCase {
    var videos = [SearchVideo]()
    let numberOfCharacters = 100
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        loadPlist()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    
    func loadPlist() {
        let fileName = "search_videos"
        let rulePath = Bundle.main.path(forResource: fileName, ofType: "plist")
        let contents = NSArray(contentsOfFile: rulePath!) ?? []
        for dict in contents {
            let dict = dict as! NSDictionary
            var video = SearchVideo(name: "", thumbnail: "", description: "", module: "", url: "", keywords: "")
            video.name = dict["name"] as? String ?? ""
            video.thumbnail = dict["thumbnail"] as? String ?? ""
            video.description = dict["description"] as? String ?? ""
            video.url = dict["url"] as? String ?? ""
            video.keywords = dict["keywords"] as? String ?? ""
            video.module = dict["module"] as? String ?? ""
            videos.append(video)
        }
    }
    
    func testNumberOfVideos() {
        //then
        XCTAssertEqual(videos.count, 146, "Total number of videos is wrong")
    }
    
    func testSearchVideosByName() {
        //given
        let searchText = "Hands"
        //when
        let videosByName = filterVideoListWithText(searchText: searchText)
        //then
        XCTAssertEqual(videosByName.count, 5, "Total number of videos by name is wrong")
    }
    
    func testSearchVideosByModule() {
        //given
        let searchText = "Fielding"
        //when
        let videosByName = filterVideoListWithText(searchText: searchText)
        //then
        XCTAssertEqual(videosByName.count, 31, "Total number of videos by module is wrong")
    }
    
    func testSearchVideosByDescription() {
        //given
        let searchText = "session"
        //when
        let videosByName = filterVideoListWithText(searchText: searchText)
        //then
        XCTAssertEqual(videosByName.count, 16, "Total number of videos by description is wrong")
    }
    
    public func filterVideoListWithText(searchText: String) -> [SearchVideo] {
        var videoCellArray = [SearchVideo]()
        for video in videos {
            let content = video.description
            let title = video.name
            let metadata = video.keywords
            let searchTextContent = findText(searchText, content)
            let searchTextTitle = findText(searchText, title)
            let searchTextMetadata = findText(searchText, metadata)
            if searchTextContent.count > 0 || searchTextTitle.count > 0 || searchTextMetadata.count > 0 {
                videoCellArray.append(video)
            }
        }
        return videoCellArray
    }
    
    func findText(_ searchText: String, _ content: String) -> String {
        if let range = content.range(of: searchText, options: .caseInsensitive) { //searching
            var startPos = content.distance(from: content.startIndex, to: range.lowerBound) //find index
            var endPos = content.distance(from: content.startIndex, to: range.upperBound) // find index
            if startPos - numberOfCharacters > 0 {
                startPos -= numberOfCharacters
            } else {
                startPos = 0
            }
            if endPos + numberOfCharacters < content.count {
                endPos += numberOfCharacters
            } else {
                endPos = content.count
            }
            let start = String.Index(encodedOffset: startPos)
            let end = String.Index(encodedOffset: endPos)
            var subContent = String(content[start..<end]) ?? ""
            if startPos != 0 {
                subContent = "... \(subContent)"
            }
            if endPos != content.count {
                subContent = "\(subContent) ..."
            }
            return subContent
        } else {
            return ""
        }
    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
