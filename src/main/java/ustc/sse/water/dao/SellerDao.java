package ustc.sse.water.dao;

import java.util.List;

import ustc.sse.water.pojo.OrderItem;
import ustc.sse.water.pojo.Product;
import ustc.sse.water.pojo.Seller;
import ustc.sse.water.pojo.Shop;

/**
 * 卖家dao接口. <br>
 * 类详细说明.
 * <p>
 * Copyright: Copyright (c) 2014年1月29日 上午10:00:55
 * <p>
 * Company: 中国科学技术大学软件学院
 * <p>
 * @author wangytao@mail.ustc.edu.cn
 * @version 1.0.0
 */
public interface SellerDao {
	public void addSeller(Seller seller);
	
	public void addGoods(Product product);
	
	public Seller findSeller(String name, String password);
	
	public Seller findseller(long sellerId);
	
	public Seller findSeller(String sellerId);
	
	public Seller findByuserName(String username);
	
	public Shop findShop(String shopId);
	
	public List<Product> getPromotionGoods(long sellerId);
	
	public List<Product> getNewGoods(long sellerId);
	
	public List<Product> getRanking(long sellerId);
	
	public List<Shop> findShopAdvice();
	
	public List<OrderItem> getAllOrders(long sellerId);
	
	public boolean delProduct(String productId);
	
	public boolean addInStock(Product product);
	
	public List<OrderItem> getOrderItems(String orderId);
	
	public List<OrderItem> getSellerOrders(long sellerId,int orderStatus,int maxResults);

	public void postGoods(OrderItem order);
	
	public boolean findByUserame(String username);
}
