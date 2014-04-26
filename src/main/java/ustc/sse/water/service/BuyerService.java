package ustc.sse.water.service;

import java.util.List;
import java.util.Set;

import ustc.sse.water.pojo.Addr;
import ustc.sse.water.pojo.BasketItem;
import ustc.sse.water.pojo.Buyer;
import ustc.sse.water.pojo.Favorites;
import ustc.sse.water.pojo.OrderItem;

/**
 * 买家业务层接口. <br>
 * 业务处理.
 * <p>
 * Copyright: Copyright (c) 2013年12月23日 下午10:16:32
 * <p>
 * Company: 中国科学技术大学软件学院
 * <p>
 * @author wangytao@mail.ustc.edu.cn
 * @version 1.0.0
 */
public interface BuyerService {
	public void addBuyer(Buyer buyer);
	
	public Buyer findBuyer(String name, String password);

	public void update(Buyer buyer);
	
	public void update_Info(Buyer buyer);

	public void saveAddr(Addr addr);

	public Buyer findBuyerById(long uid);

	public Addr getThePAById(String addr_select);

	public void saveOrders(Buyer buyer, Set<OrderItem> tempOrders);

	public void emptyMyCart(Set<OrderItem> tempOrders, Buyer buyer);

	public void removeItem(BasketItem item);

	public List<OrderItem> getNoPayOrders(Buyer buyer);

	public List<OrderItem> getAssessOrders(Buyer buyer);

	public int countComplaint(Buyer buyer);

	public int countEval(Buyer buyer);

	public List<OrderItem> getRecentBuy(Buyer nbuyer);
	
	public List<Favorites> getFavorites(Buyer buyer);
	
	public void deleteFavorite(long id);
	
	public void addFavorite(Favorites item, String fid, String ftype);

	public List<OrderItem> searchOrders(Buyer buyer, String proName,
			String timeBegin, String timeEnd, String orderNum,
			String orderStatus);

	public List<OrderItem> getConfirmArriveOrders(Buyer buyer);

	public int countArrive(Buyer buyer);
	
	public boolean findByUserame(String username);
	
}
