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

import ustc.sse.water.dao.BuyerDao;
import ustc.sse.water.pojo.Buyer;
import ustc.sse.water.pojo.OrderItem;
import ustc.sse.water.pojo.Favorites;
import ustc.sse.water.pojo.Product;

/**
 * 买家用户的dao层实现. <br>
 * 具体的数据库操作<br>
 * 注意dao的注解同意同Repository
 * <p>
 * Copyright: Copyright (c) 2013年12月23日 下午10:15:33
 * <p>
 * Company: 中国科学技术大学软件学院
 * <p>
 * @author wangytao@mail.ustc.edu.cn
 * @version 1.0.0
 */
@Repository("BuyerDao")
public class BuyerDaoImpl extends SuperDaoImpl implements BuyerDao {

	@Override
	public void addBuyer(Buyer buyer) {
		em.persist(buyer);
	}

	@Override
	public void update_Info(Buyer buyer){
		em.persist(buyer);//编辑买家个人信息
	}
	
	@Override
	public Buyer findBuyer(String buyerName, String password) {
		Query query = em.createQuery("from Buyer buyer where buyer.username=?1 and buyer.password=?2");
		query.setParameter(1, buyerName);
		query.setParameter(2, password);
		@SuppressWarnings("unchecked")
		List<Buyer> list = query.getResultList();
		if (!list.isEmpty()) {
			return list.get(0);
		} else {
			return null;
		}
	}

	@Override
	public int countComplaint(Buyer buyer) {
		
		return 0;
	}

	@Override
	public int countEval(Buyer buyer) {
		CriteriaBuilder qb = em.getCriteriaBuilder();
		List<OrderItem> orders = new ArrayList<OrderItem>();
		CriteriaQuery<OrderItem> criteriaQuery = qb.createQuery(OrderItem.class);
		Root<OrderItem> orderRoot = criteriaQuery.from(OrderItem.class);
		Path<String> buyerId = orderRoot.get("buyer");
		Path<String> status  = orderRoot.get("orderStatus");
		Predicate condition_1 = qb.equal(buyerId, buyer);
		Predicate condition_2 = qb.equal(status, 3);//待评价的订单
		criteriaQuery.where(qb.and(condition_1, condition_2));
		TypedQuery<OrderItem> typedQuery = em.createQuery(criteriaQuery);
		
		orders = typedQuery.getResultList();
		
		return orders.size();
	}

	@Override
	public List<OrderItem> findRecentBuy(Buyer nbuyer) {
		CriteriaBuilder cb = em.getCriteriaBuilder();
		List<OrderItem> orders = new ArrayList<OrderItem>();
		CriteriaQuery<OrderItem> criteriaQuery = cb.createQuery(OrderItem.class);
		Root<OrderItem> orderRoot = criteriaQuery.from(OrderItem.class);
		Path<String> buyer  = orderRoot.get("buyer");
		Path<String> status = orderRoot.get("orderStatus");
		Predicate condition_1 = cb.equal(buyer, nbuyer);
		Predicate condition_2 = cb.equal(status, 4);
		criteriaQuery.where(cb.and(condition_1, condition_2));
		criteriaQuery.orderBy(cb.asc(orderRoot.get("postTime")));
		
		TypedQuery<OrderItem> typedQuery = em.createQuery(criteriaQuery);
		
		orders = typedQuery.getResultList();
		return orders;
	}

	@Override
	public List<Favorites> getFavorites(Buyer buyer) {
		List<Favorites> list = new ArrayList<Favorites>();
		Buyer b = em.find(Buyer.class, buyer.getBuyerID());
		
		for( Favorites f : b.getFavorites()) {
			
			list.add(f);
		}
		if (list.isEmpty() == false) {
			return list;
		} else {
			return null;
		}
	}

	@Override
	public List<OrderItem> findExactOrder(Buyer buyer, String proName, String timeBegin,
			String timeEnd, String orderNum, String orderStatus) {
		CriteriaBuilder cBuilder = em.getCriteriaBuilder();
		List<OrderItem> orders = new ArrayList<OrderItem>();
		CriteriaQuery<OrderItem> criteriaQuery = cBuilder.createQuery(OrderItem.class);
		Root<OrderItem> orderRoot = criteriaQuery.from(OrderItem.class);
		Path<String> buyerPath = orderRoot.get("buyer");
		Path<Product> proNamePath = orderRoot.get("product");
		Path<String> timePath = orderRoot.get("postTime");
		Path<String> ordernumPath = orderRoot.get("orderID");
		Path<String> orderStatusPath = orderRoot.get("orderStatus");
		
		List<Predicate> predicates = new ArrayList<Predicate>();
		predicates.add(cBuilder.equal(buyerPath, buyer));
		if(proName != null && !proName.equals("")) {
			predicates.add(cBuilder.equal(proNamePath.get("productName"), proName));
		}
		if (timeBegin != null && !timeBegin.equals("")) {
			String tb = deleteString(timeBegin);
			predicates.add(cBuilder.greaterThanOrEqualTo(timePath, tb));
		}
		if (timeEnd != null && !timeEnd.equals("")) {
			String te = deleteString(timeEnd);
			predicates.add(cBuilder.lessThanOrEqualTo(timePath, te));
		}
		if (orderNum != null && !orderNum.equals("")) {
			predicates.add(cBuilder.equal(ordernumPath, orderNum));
		}
		if (orderStatus != null && !orderStatus.equals("")) {
			predicates.add(cBuilder.equal(orderStatusPath, orderStatus));
		}
		
		criteriaQuery.where(cBuilder.and(predicates.toArray(new Predicate[predicates.size()])));
		
		criteriaQuery.orderBy(cBuilder.asc(orderRoot.get("postTime")));
		
		TypedQuery<OrderItem> typedQuery = em.createQuery(criteriaQuery);
		orders = typedQuery.getResultList();
		
		return orders;
	}
	
	private String deleteString(String a) {
		StringBuffer buffer = new StringBuffer();
		for (int i = 0; i < a.length(); i++) {
			if(a.charAt(i) != '/') {
				buffer.append(a.charAt(i));
			}
		}
		buffer.append("000000");
		return buffer.toString();
	}

	@Override
	public int countArrive(Buyer buyer) {
		CriteriaBuilder qb = em.getCriteriaBuilder();
		List<OrderItem> orders = new ArrayList<OrderItem>();
		CriteriaQuery<OrderItem> criteriaQuery = qb.createQuery(OrderItem.class);
		Root<OrderItem> orderRoot = criteriaQuery.from(OrderItem.class);
		Path<String> buyerId = orderRoot.get("buyer");
		Path<String> status  = orderRoot.get("orderStatus");
		Predicate condition_1 = qb.equal(buyerId, buyer);
		Predicate condition_2 = qb.equal(status, 2);//待评价的订单
		criteriaQuery.where(qb.and(condition_1, condition_2));
		TypedQuery<OrderItem> typedQuery = em.createQuery(criteriaQuery);
		
		orders = typedQuery.getResultList();
		
		return orders.size();
	}

	@Override
	public boolean findByUserame(String username) {
		// TODO Auto-generated method stub
		Query query = em.createQuery("from Buyer buyer where buyer.username=?1");
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
