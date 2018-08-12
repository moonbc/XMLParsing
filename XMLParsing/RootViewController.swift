//
//  RootViewController.swift
//  XMLParsing
//
//  Created by 402-07 on 2018. 8. 12..
//  Copyright © 2018년 moonbc. All rights reserved.
//

import UIKit
import Alamofire

class RootViewController: UITableViewController , XMLParserDelegate{

    //태그 안의 문자열을 저장할 변수
    var currentElementValue:String?
    
    //하나의 Book을 저장할 변수
    var book:Book?
    
    //Book 전체를 저장할 변수
    var books = [Book]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        //문자열을 비동기적으로 다운로드 받기
        sleep(5)
        let request = Alamofire.request("https://www.daum.net", method:.get , parameters:nil)
        
        request.responseString{
            response in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            print(response.result.value)
        }
        
        print("Hello")

        //title은 네비게이션 바 중앙의 문자열이 되고 탭바의 경우에는
        //탭바 아이템의 문자열이 됩니다.
        
        self.title = "Book"
        
        //데이터를 다운로드 받을 URL 만들기
        let url = URL(string: "http://sites.google.com/site/iphonesdktutorials/xml/Books.xml")
        
        //XMLParser 객체 생성
        let xmlParser = XMLParser(contentsOf: url!)
        //파싱을 시작하고 delegate 메소드 호출
        xmlParser?.delegate = self
        xmlParser?.parse()
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return books.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = books[indexPath.row].title

        return cell
    }
 
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        detailViewController.book = books[indexPath.row]
        
        self.navigationController?.pushViewController(detailViewController, animated: true)
        
        
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //태그의 시작을 만났을 때 호출되는 메소드
    //elementName : 태그 이름
    //attributeDict: 속성과 값을 저장하고 있는 딕셔너리
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        //Book태그를 만나면 새로운 데이터를 저장할 수 있는 인스턴스를 생성하고
        //태그 안에 있는 Id의 값을 저장
        
        if(elementName == "Book") {
            book = Book()
            let dic = attributeDict as Dictionary
            book?.bookId = dic["Id"]
        }
    }

    
    //태그 안의 내용을 만날때 호출되는 메소드
    //string:태그 안의 문자열
    //태그 안의 문자열은 글자수에 제한이 없습니다.
    //한번에 전체를 다 못 가져올 수 있습니다.
    //처음일때는 문자열을 바로 저장하고 그렇지 않을 때는 이전 문자열과
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if currentElementValue == nil {
            currentElementValue = string
            
        }else {
            currentElementValue = "\(currentElementValue!)\(string)"
        }
    }
    //태그를 닫을 때 호출되는 메소드
    //elementName가 태그 이름
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "Books" {
            return
        }else if elementName == "Book" {
            books.append(book!)
        }else if elementName == "title" {
            book?.title = currentElementValue
        }else if elementName == "author" {
            book?.author = currentElementValue
        }else if elementName == "summary" {
            book?.summary = currentElementValue
        }
        currentElementValue = nil
    }
}
