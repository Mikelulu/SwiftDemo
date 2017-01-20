//
//  LKSubBaseViewController.swift
//  LKFFM
//
//  Created by Mike on 2017/1/17.
//  Copyright © 2017年 LK. All rights reserved.
//

import UIKit
import MJRefresh
import SDWebImage

class LKSubBaseViewController: UIViewController {

    let iconArr:[String] = ["http://img4.duitang.com/uploads/item/201506/18/20150618181443_Frv2V.jpeg","http://imgphoto.gmw.cn/attachement/jpg/site2/20120504/f04da22dd51e110d929e38.jpg","http://dynamic-image.yesky.com/740x-/uploadImages/2015/329/42/A040IVFHMXTV.jpg","http://i3.s2.dpfile.com/pc/wed/87a8c4289fa52bf74bc148a4c8da6990%28640c480%29/thumb.jpg","http://imga1.pic21.com/bizhi/140212/07423/s10.jpg","http://i1.s2.dpfile.com/pc/577ca5f02a2b820a1747bd55c3b49462%28740x2048%29/thumb.jpg","http://i1.s2.dpfile.com/pc/aa7154ccb9cc9e05d2a2428ce2ec417e(740x2048)/thumb.jpg","http://i2.s1.dpfile.com/pc/wed/7a1a44797c2ba347d38436773e8985f3(640c480)/thumb.jpg","http://qcloud.dpfile.com/wed/hzW0qjCDMTK11yO8vXPNjXDaXVk4UMN9nDvLX-tYQ2x-ejmT-iG_Go8fi3gIJIHgO3xc_zgr_wpcmvffXdGKhg.jpg","http://img4.duitang.com/uploads/item/201506/18/20150618181443_Frv2V.jpeg"
        ]
    
    let nameArr: [String] = ["王二麻子","放牛郎","面对季风","小炮娘","哈蛮王","瞎子忙森","打野爸爸","ADC","啊哈哈","666","大龙吧"]
    
    let contentArr: [String] = ["大家好,Frank_Frank,在这里我们一起学习新的知识,总结我们遇到的那些坑,共同的学习,共同的进步,共同的努力,只为美好的明天!!!有问题一起相互的探讨","乌龟受伤，让蜗牛去买药。过了两个小时，蜗牛还没回来。乌龟急了，骂道：“他妈的再不回来老子就死了!”这时门外传来了蜗牛的声音：“你他妈再说老子不去了!","一女奇丑，嫁不出去，希望被拐卖。终于梦想成真，却半月卖不出去。绑匪将其送回，她坚决不下车，绑匪咬牙一跺脚：“走，车不要了","强盗：“抢劫，都他妈给我趴下!”当他看到一女士的趴下姿势后吼道：“你他妈给我文明点，老子只劫财不劫色!","某男生宿舍卧谈会持续至凌晨三点，忽然想讨论一个问题“碰到一个漂亮姑娘，首先该说什么?”某君从梦中惊醒，曰：“甭说了，咱们睡吧!","悟空和唐僧一起上某卫视非诚勿扰,悟空上台,24盏灯全灭。理由:1.没房没车只有一根破棍. 2.保镖职业危险.3.动不动打妖精,对女生不温柔. 4.坐过牢,曾被压五指山下500年。唐僧上台，哗!灯全亮。 理由:1.公务员； 2.皇上兄弟，后台最硬 3.精通梵文等外语 4.长得帅 5.最关键一点：有宝马！","有一个人叫真咯嗦，娶了个老婆叫要你管，生了个儿子叫麻烦。有一天麻烦不见了！夫妻俩就去报案。警察问爸爸：请问这位男士你叫啥名字？爸爸说:真咯嗦。警察很生气，然后 他又问妈妈叫啥名字。妈妈说:要你管。警察非常生气的说:你们要干什么?夫妻俩说：找麻烦","人与人间的信任，就像是纸片，一旦破损，就不会再回到原来的样子。","白羊：记不清人；金牛：悔未上床；双子：他（她）是青蛙（恐龙）；巨蟹：善哉善哉；狮子：一脚蹬开；处女：倒大霉了；天秤：感觉很好；天蝎：你死我活；射手：有多少次；摩羯：气死我也；水瓶：奶奶个熊；双鱼：还是想他（她）{点开大图更精彩} @乌托邦办公室","有一种借口叫年轻，可以不珍惜时光，不珍惜爱，不珍惜一切来之不易的东西。有一种感情叫错过，错过爱，错过可以相守的人，错过一段刻骨铭心的情。有一种寂寞叫想念，想念一个人，一段往事，一场相遇。寂静的夜里，深深切切的想念，于是深深切切地寂寞！"]
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: CGRect.zero, style: .plain)
        table.delegate = self
        table.dataSource = self
        table.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
                self.tableView.mj_header.endRefreshing()
            })

        })
      
        return table
    }()
    
    var string: String = ""{
        
        didSet{
           tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(self.tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0))
        }
    }
    
}

extension LKSubBaseViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contentArr.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
        let height: CGFloat = (self.contentArr[indexPath.row].getStringHeight(string: self.contentArr[indexPath.row], fontSize: 15, width: kScreenW - 30))
        return height + 50 + 10 + 15 + 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "cellId"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = LKSubTableViewCell(style: .default, reuseIdentifier: cellId)
        }
        return cell!
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let cell = cell as! LKSubTableViewCell
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        
        cell.iconImage .sd_setImage(with: NSURL(string: self.iconArr[indexPath.row]) as URL!, placeholderImage: nil)
        
        cell.nameLb.text = self.nameArr[indexPath.row]
        
        cell.contentLb.text = self.contentArr[indexPath.row]
    }
}
