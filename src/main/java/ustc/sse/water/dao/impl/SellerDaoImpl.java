package ustc.sse.water.dao.impl;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Query;
import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Path;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.springframework.stereotype.Repository;

import ustc.sse.water.dao.SellerDao;
import ustc.sse.water.pojo.Buyer;
import ustc.sse.water.pojo.OrderItem;
import ustc.sse.water.pojo.Product;
import ustc.sse.water.pojo.Seller;
import ustc.sse.water.pojo.Shop;

/**
 * sellerDao实现类. <br>
 * 类详细说明.
 * <p>
 * Copyright: Copyright (c) 2014年1月29日 上午10:03:23
 * <p>
 * Company: 中国科学技术大学软件学院
 * <p>
 * @author wangytao@mail.ustc.edu.cn
 * @version 1.0.0
 */

@Repository("SellerDao")
public class SellerDaoImpl extends SuperDaoImpl implements SellerDao {

	
	@Override
	public void addSeller(Seller seller) {
		em.persist(seller);
	}

	@Override
	public Seller findSeller(String name, String password) {
		Query query = em.createQuery("from Seller seller where seller.username=?1 and seller.password=?2");
		query.setParameter(1, name);
		query.setParameter(2, password);
		@SuppressWarnings("unchecked")
		List<Seller> list = query.getResultList();
		if(!list.isEmpty()){
			return list.get(0);
		} else {
			return null;
		}
	}
	
	@Override
	public Seller findSeller(String sellerId) {
		Query query = em.createQuery("from Seller seller where seller.sellerID=?1");
		query.setParameter(1, sellerId);
		@SuppressWarnings("unchecked")
		List<Seller> list = query.getResultList();
		if(!list.isEmpty()){
			return list.get(0);
		} else {
			return null;
		}
	}
	
	public void addGoods(Product product){
		em.persist(product);
	}

	@Override
	public Seller findByuserName(String username) {
		Query query = em.createQuery("from Seller seller where seller.username=?1");
		query.setParameter(1, username);
		@SuppressWarnings("unchecked")
		List<Seller> sellers = query.getResultList();
		if(!sellers.isEmpty()){
			return sellers.get(0);
		} else {
			return null;
		}
	}

	@Override
	public List<Shop> findShopAdvice() {
		String hql = "from Shop s order by s.shopScore asc";
		@SuppressWarnings("unchecked")
		List<Shop> list = em.createQuery(hql).getResultList();
		List<Shop> shops = new ArrayList<Shop>();
		shops.addAll(list.size()-6, list);
		return null;
	}
	
	@Override
	public Shop findShop(String shopId) {
		String hql = "from Shop s where s.shopId=?1";
		Query query = em.createQuery(hql);
		query.setParameter(1, shopId);
		@SuppressWarnings("unchecked")
		List<Shop> list = query.getResultList();
		if(!list.isEmpty()){
			return list.get(0);
		}else{
			return null;
		}
	}

	@Override
	public List<Product> getPromotionGoods(long sellerId) {		
		String hql = "from Product p where p.seller.sellerID=?1 order by p.salesNum desc";
		Query query = em.createQuery(hql);
		query.setParameter(1,sellerId);
		query.setMaxResults(6);
		@SuppressWarnings("unchecked")
		List<Product> products = query.getResultList();
//		int size = list.size();
//		size = size<=3? size:3;
//		for (int i = 0; i < size; i++) {
//			products.add(list.get(i));
//		}	
		return products;

	}

	@Override
	public List<Product> getNewGoods(long sellerId) {
		String hql = "from Product p where p.seller.sellerID=?1 order by p.inTime desc";
		@SuppressWarnings("unchecked")
		List<Product> products = em.createQuery(hql).setParameter(1, sellerId).setMaxResults(6).getResultList();	
		return products;
	}

	@Override
	public List<Product> getRanking(long sellerId) {
		String hql = "from Product p where p.seller.sellerID=?1 order by p.salesNum desc";
		@SuppressWarnings("unchecked")
		List<Product> products = em.createQuery(hql).setParameter(1, sellerId).setMaxResults(15).getResultList();
			
		return products;
	}

	@Override
	public List<OrderItem> getAllOrders(long sellerId) {
		CriteriaBuilder criteriaBuilder = em.getCriteriaBuilder();
		List<OrderItem> orders = new ArrayList<OrderItem>();
		try {
			CriteriaQuery<OrderItem> criteriaQuery = criteriaBuilder.createQuery(OrderItem.class);
			Root<OrderItem> order = criteriaQuery.from(OrderItem.class);
			Path<String> order_sellerid = order.get("sellerId");
			Predicate condition = criteriaBuilder.equal(order_sellerid, sellerId);
			criteriaQuery.where(condition);
			TypedQuery<OrderItem> typedQuery = em.createQuery(criteriaQuery);
			orders = typedQuery.getResultList();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return orders;
	}

	@Override
	public boolean delProduct(String productId) {
		String hql = "from Product p where p.productId=?1";
		@SuppressWarnings("unchecked")
		List<Product> products = em.createQuery(hql).setParameter(1, productId).getResultList();
		System.out.println(products.size());
		Product product;
		if(!products.isEmpty()){
			product = products.get(0);
			em.remove(product);
			return true;
		}else{
			product = null;
			return false;
		}
	}
	@Override
	public boolean addInStock(Product product){
		em.merge(product);
		return true;
	}

	@Override
	public List<OrderItem> getOrderItems(String orderId) {
		String hql = "from OrderItem o where o.orderID=?1";
		@SuppressWarnings("unchecked")
		List<OrderItem> orders = em.createQuery(hql).setParameter(1, orderId).getResultList();
		return orders;
	}

	@Override
	public void postGoods(OrderItem order) {
		em.merge(order);
	}


	@Override
	public List<OrderItem> getSellerOrders(long sellerId, int orderStatus, int maxResults) {
		CriteriaBuilder criteriaBuilder = em.getCriteriaBuilder();
		List<OrderItem> orders = new ArrayList<OrderItem>();
		try {
			CriteriaQuery<OrderItem> criteriaQuery = criteriaBuilder.createQuery(OrderItem.class);
			Root<OrderItem> order = criteriaQuery.from(OrderItem.class);
			Path<String> order_sellerid = order.get("sellerId");
			Path<String> status  = order.get("orderStatus");
			Predicate condition_1 = criteriaBuilder.equal(order_sellerid, sellerId);
			Predicate condition_2;
			if(orderStatus==10){
				Predicate condition_3 = criteriaBuilder.equal(status, 0);
				Predicate condition_4 = criteriaBuilder.equal(status, 1);
				condition_2 = criteriaBuilder.or(condition_3,condition_4);
			}else if(orderStatus==34){
				Predicate condition_3 = criteriaBuilder.equal(status, 3);
				Predicate condition_4 = criteriaBuilder.equal(status, 4);
				condition_2 = criteriaBuilder.or(condition_3,condition_4);
			}else if(orderStatus==67){
				Predicate condition_3 = criteriaBuilder.equal(status, 6);
				Predicate condition_4 = criteriaBuilder.equal(status, 7);
				condition_2 = criteriaBuilder.or(condition_3,condition_4);
			}else{
				condition_2 = criteriaBuilder.equal(status, orderStatus);
			}
			criteriaQuery.where(criteriaBuilder.and(condition_1,condition_2));
			TypedQuery<OrderItem> typedQuery = em.createQuery(criteriaQuery);
			if(maxResults>0){
				typedQuery.setMaxResults(maxResults);
			}
			orders = typedQuery.getResultList();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return orders;
	}

	@Override
	public Seller findseller(long sellerId) {
		Query query = em.createQuery("from Seller seller where seller.sellerID=?1");
		query.setParameter(1, sellerId);
		@SuppressWarnings("unchecked")
		List<Seller> list = query.getResultList();
		if(!list.isEmpty()){
			return list.get(0);
		} else {
			return null;
		}
	}
	
	@Override
	public boolean findByUserame(String username) {
		// TODO Auto-generated method stub
		Query query = em.createQuery("from Seller seller where seller.username=?1");
		query.setParameter(1, username);
		@SuppressWarnings("unchecked")
		List<Buyer> list = query.getResultList();
		if (!list.isEmpty()) {
			return true;
		} else {
			return false;
		}
	}

}
