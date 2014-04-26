package ustc.sse.water.service;

import java.util.List;

import ustc.sse.water.pojo.OrderItem;
import ustc.sse.water.pojo.Product;
import ustc.sse.water.pojo.Seller;
import ustc.sse.water.pojo.Shop;

/**
 * 卖家service类. <br>
 * 类详细说明.
 * <p>
 * Copyright: Copyright (c) 2014年1月29日 上午9:22:03
 * <p>
 * Company: 中国科学技术大学软件学院
 * <p>
 * @author wangytao@mail.ustc.edu.cn
 * @version 1.0.0
 */
public interface SellerService {
	public void addSeller(Seller seller);
	
	public void addGoods(Product product);
	
	public Seller findseller(String name, String password);
	
	public Seller findseller(long sellerId);
	
	public Seller findseller(String username);
	
	public Shop findShop(String shopId);
	
	public List<Product> getPromotionGoods(long sellerId);
	
	public List<Product> getNewGoods(long sellerId);
	
	public List<Product> getRanking(long sellerId);
	
	public List<Shop> getHighScoreShop();
	
	public List<OrderItem> getAllOrders(long sellerId);
	
	public boolean delProduct(String productId);
	
	public boolean addInStock(Product product);
	
	public void createShop(Shop shop);
	
	public void updateSeller(Seller seller);
	
	public List<OrderItem> getOrderItems(String orderId);
	
	public List<OrderItem> getSellerOrders(long sellerId,int orderStatus,int maxResults);
	
	public void postGoods(List<OrderItem> orders);
	
	public boolean findByUserame(String username);
}
