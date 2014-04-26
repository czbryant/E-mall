package ustc.sse.water.service;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.TreeSet;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ustc.sse.water.dao.BuyerDao;
import ustc.sse.water.dao.ProductDao;
import ustc.sse.water.pojo.BasketItem;
import ustc.sse.water.pojo.Buyer;
import ustc.sse.water.pojo.Image;
import ustc.sse.water.pojo.OrderItem;
import ustc.sse.water.pojo.Product;
import ustc.sse.water.pojo.ProductType;
import ustc.sse.water.pojo.QueryResult;
import ustc.sse.water.utils.HistoryCookieUtil;

@Service("ProductService")
@Transactional
public class ProductService {
	@Resource(name="BuyerDao")
	protected BuyerDao buyerDao;
	
	private ProductDao dao;
	
	public ProductDao getDao() {
		return dao;
	}

	@Resource(name="ProductDao")
	public void setDao(ProductDao dao) {
		this.dao = dao;
	}

	public void saveProductType(ProductType productType){
		dao.save(productType);
	}
	
	public void saveImg(Image images) {
		dao.save(images);
	}
	
	public Image getImgById(long id){
		return dao.find(Image.class, id);
	}
	
	public void saveProduct(Product product){
		dao.save(product);
	}
	
	public Product getProductById(String id){
		return dao.find(Product.class, id);
	}
	
	/**
	 * @param item
	 * 判断新加入的item是否已经存在，如果已经存在，就更新该物件的数量，否则添加进购物车
	 */
	public void saveItemsIntoCart(Buyer buyer, Set<BasketItem> items){
		Set<BasketItem> newItems = new HashSet<BasketItem>();
		Set<BasketItem> dbitems =  buyer.getBasket();
		boolean flag = true;
		if (dbitems != null) {
			for (BasketItem item : items) {
				for (BasketItem dbItem : dbitems) {
					if (dbItem.equals(item)) {
						dbItem.setAddCount(dbItem.getAddCount() + item.getAddCount());
						newItems.add(dbItem);
						flag = false;
						break;
					}
				}
				if (flag) {
					newItems.add(item);
				}
			}
		}
		buyer.setBasket(newItems);
		dao.update(buyer);
	}
	
	
	public void saveItemIntoCart(Buyer buyer, BasketItem item){
		boolean flag = true;
		for (BasketItem dbItem : buyer.getBasket()) {
			if (dbItem.equals(item)) {
				dbItem.setAddCount(dbItem.getAddCount() + item.getAddCount());
				flag = false;
				break;
			}
		}
		if (flag) {
			dao.save(item);
		}
		dao.update(buyer);
	}
	
	
	public void saveOrder(OrderItem order){
		dao.save(order);
	}
	
	public Set<BasketItem> getBasketByUid(Buyer buyer){
		buyer = dao.find(Buyer.class, buyer.getBuyerID());
		return buyer.getBasket();
	}
	
	/**
	 * @return 查询今日畅销前几
	 */
	public List<Product> getTop3(){
		return dao.top3ProSet();
	}
	
	public QueryResult<Product> productQuery(int firstIndex, String equalsPro) {
		return  dao.getScrollData(Product.class, firstIndex, 6, "productName", equalsPro, "salesNum");
	}
	
	public Set<OrderItem> getRecentlyOrders(Buyer buyer) {
		Set<OrderItem> selectedOrderItems = new TreeSet<OrderItem>();
		for (OrderItem orderItem : buyer.getOrders()) {
			//TODO 根据日期排序，得到最近六个订单，成功的订单，flag，还是要查数据库
		}
		return selectedOrderItems;
	}

	public Set<OrderItem> getNoPayOrders(Buyer buyer) {
		Set<OrderItem> orderItems = buyer.getOrders();
		Set<OrderItem> newItems = new HashSet<OrderItem>();
		for (OrderItem orderItem : orderItems) {
			if(orderItem.getOrderStatus() == 0){
				newItems.add(orderItem);
			}
		}
		return newItems;
	}

	public OrderItem getOrderByID(String orderId) {
		OrderItem item = dao.find(OrderItem.class, orderId);
		return item;
	}

	public void updateOrder(OrderItem order) {
		dao.update(order);
	}

	public void updateProduct(Product product) {
		dao.update(product);
	}

	public OrderItem getOrderByLongID(long parseLong) {
		OrderItem item = dao.find(OrderItem.class, parseLong);
		return item;
	}

	public List<Product> getRecentViewProducts(HttpServletRequest request) {
		List<String> idList = HistoryCookieUtil.getHistoryList(request);
		List<Product> recentViewProducts = new ArrayList<Product>();
		if (idList != null && idList.size()>0) {
			for (String id : idList) {
				Product product = dao.find(Product.class, id);
				recentViewProducts.add(product);
			}
			return recentViewProducts;
		} else {
			return null;
		}
	}

	public List<Product> getNewProducts() {
		List<Product> products = dao.findNewPro6();
		if(products.size() > 8) {
			return products.subList(0, 8);
		} else {
			return products;
		}
	}
}
