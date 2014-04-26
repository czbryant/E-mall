package ustc.sse.water.dao;

import java.util.List;

import ustc.sse.water.pojo.Buyer;
import ustc.sse.water.pojo.Favorites;
import ustc.sse.water.pojo.OrderItem;

/**
 * 用户DAO接口. <br>
 * 接口.
 * <p>
 * Copyright: Copyright (c) 2013年12月23日 下午5:59:00
 * <p>
 * Company: 中国科学技术大学软件学院
 * <p>
 * @author wangytao@mail.ustc.edu.cn
 * @version 1.0.0
 */
public interface BuyerDao extends SuperDao{
	public void addBuyer(Buyer buyer);
	
	public void update_Info(Buyer buyer);
	
	public Buyer findBuyer(String buyerName, String password);

	public int countComplaint(Buyer buyer);

	public int countEval(Buyer buyer);

	public List<OrderItem> findRecentBuy(Buyer nbuyer);

	List<Favorites> getFavorites(Buyer buyer);

	public List<OrderItem> findExactOrder(Buyer buyer, String proName, String timeBegin,
			String timeEnd, String orderNum, String orderStatus);

	public int countArrive(Buyer buyer);
	
	public boolean findByUserame(String username);
}
