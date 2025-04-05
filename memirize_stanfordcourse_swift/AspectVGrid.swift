//
//  AspectVGrid.swift
//  memirize_stanfordcourse_swift
//
//  Created by 簡紹益 on 2025/4/2.
//

import SwiftUI

struct AspectVGrid<Item: Identifiable, ItemView: View>: View{
    var items: [Item] //不管你的型別 don't care type
    var aspectRatio: CGFloat = 3/2 //自定長寬比
    @ViewBuilder var content: (Item) -> ItemView
    init(items: [Item], aspectRatio: CGFloat, @ViewBuilder content: @escaping (Item) -> ItemView) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
    }
    //1.@escaping使傳進去的值“Item”之後還能繼續使用，不會留在func內被刪除
    //2.使用@escaping存取物件自己的屬性、方法需搭配self，提醒swift增加self的reference_count，不致於closure執行self已死掉
    
    var body: some View{
        GeometryReader { geometry in
            let gridItemSize = gridItemWidthThatFits(
                count: items.count,
                size: geometry.size, //傳入螢幕的尺寸，隨不同載體螢幕的尺寸而改變
                atAspectRatio: aspectRatio
            )
            //MARK: -Intent
            //這裡卡片尺寸的問題還沒解決，要找時間回來弄
            let columns = [GridItem(.adaptive(minimum: gridItemSize),spacing:0)]
            //調整columns決定LazyVGrid每格的寬度
            LazyVGrid(columns: columns) {
                ForEach(items){ item in
                    content(item)
                        .aspectRatio(aspectRatio, contentMode: .fit)
                    // .aspectRatio的content mode 可選.fit(縮小以配合大小）或.fill（放大以配合大小）
                }
            }
        }
    }
    private func gridItemWidthThatFits(
        //求得再卡片寬為何下，所有卡片能全覽而不需滑動
        count: Int, //卡片總數
        size: CGSize,
        atAspectRatio aspectRatio: CGFloat //（即長/寬）
    ) -> CGFloat {
        let count = CGFloat(count) //轉化成CGFLoat型態，使其在後面可參與運算（同類型才可）
        var columnCount = 1.0
        //儲存卡片一橫列放幾個，若與count一樣（一行放全部）就不用討論了 不可能更多
        repeat{
            let width = size.width / columnCount
            //螢幕寬除以一列數量，得每張卡片寬
            let height = width / aspectRatio
            //卡片寬乘以預設的長寬比，求得卡片長
            let rowCount = (count / columnCount).rounded(.up)
            //由總卡片數除以每列數量，小數無條件進位(rounded up)，得所需每行數量
            if rowCount * height < size.height{
                return((size.width / columnCount).rounded(.down))
            }
            //每行數量乘以卡片長，總長若小於螢幕長（不需滑動即可全覽）就回傳現行的卡片寬（小數後值捨掉）
            columnCount += 1
            //目前仍過長，嘗試每橫列多放一個
        } while columnCount < count //若需要在一列內放全部卡片，就不需再繼續了（不能放更多了）
        return (size.width / count)
        //確定需要再一行內放所有卡片，取總寬除以卡片數及卡片高乘以長寬比兩者較小回傳（以避免橫向超出螢幕）
    }
}
