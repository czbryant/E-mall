package ustc.sse.water.dao.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import javax.persistence.Query;
import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Path;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.springframework.stereotype.Repository;

import ustc.sse.water.dao.ProductDao;
import ustc.sse.water.pojo.BasketItem;
import ustc.sse.water.pojo.Buyer;
import ustc.sse.water.pojo.OrderItem;
import ustc.sse.water.pojo.Product;

@Repository("ProductDao")
public class ProductDaoImpl extends SuperDaoImpl implements ProductDao {

	@Override
	public Set<BasketItem> findBasketByUid(String uid) {
		Buyer buyer = new Buyer();
		String hql = "from Buyer b where b.buyerId = " + uid;
		buyer = (Buyer) em.createQuery(hql).getResultList().get(0);
		return buyer.getBasket();
	}

	@Override
	public List<Product> top3ProSet() {
		List<Product> products = new ArrayList<Product>();
		String hql = "from Product p order by p.salesNum desc";
		@SuppressWarnings("unchecked")
		List<Product> list = em.createQuery(hql).getResultList();
		if(list.size() >= 3) {
			for (int i = 0; i < 3; i++) {
				products.add(list.get(i));
			}
		} else {
			for (Product product : list) {
				products.add(product);
			}
		}
		
		
		return products;
	}

	@Override
	public void delFromBasket(BasketItem item) {
		String hqlString = null;
		if(item.getProductIllustration().equals("")){
			hqlString = "delete BasketItem item where item.id = " + item.getId();
		} else {
			hqlString = "delete BasketItem item where item.id = " + item.getId() 
					+ " and item.productIllustration = " + item.getProductIllustration();
		}
		Query query = em.createQuery(hqlString);
		query.executeUpdate();
	}

	@Override
	public List<OrderItem> findNoPayOrder(Buyer buyer) {
		CriteriaBuilder qb = em.getCriteriaBuilder();
		List<OrderItem> orders = new ArrayList<OrderItem>();
		CriteriaQuery<OrderItem> criteriaQuery = qb.createQuery(OrderItem.class);
		Root<OrderItem> orderRoot = criteriaQuery.from(OrderItem.class);
		Path<String> buyerId = orderRoot.get("buyer");
		Path<String> status  = orderRoot.get("orderStatus");
		Predicate condition_1 = qb.equal(buyerId, buyer);
		Predicate condition_2 = qb.equal(status, 0);
		criteriaQuery.where(qb.and(condition_1, condition_2));
		TypedQuery<OrderItem> typedQuery = em.createQuery(criteriaQuery);
		
		orders = typedQuery.getResultList();
		
		return orders;
	}

	@Override
	public List<OrderItem> findAssessOrder(Buyer buyer) {
		CriteriaBuilder qb = em.getCriteriaBuilder();
		List<OrderItem> orders = new ArrayList<OrderItem>();
		CriteriaQuery<OrderItem> criteriaQuery = qb.createQuery(OrderItem.class);
		Root<OrderItem> orderRoot = criteriaQuery.from(OrderItem.class);
		Path<String> buyerId = orderRoot.get("buyer");
		Path<String> status  = orderRoot.get("orderStatus");
		Predicate condition_1 = qb.equal(buyerId, buyer);
		Predicate condition_2 = qb.equal(status, 3);//等待评价
		criteriaQuery.where(qb.and(condition_1, condition_2));
		TypedQuery<OrderItem> typedQuery = em.createQuery(criteriaQuery);
		
		orders = typedQuery.getResultList();
		
		return orders;
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<Product> findNewPro6() {
		List<Product> list = new ArrayList<Product>();
		String hql = "from Product p order by p.inTime desc";
		Query query = em.createQuery(hql);
		list = query.getResultList();
		return list;
	}

	@Override
	public List<OrderItem> findConfirmArriveOrders(Buyer buyer) {
		CriteriaBuilder qb = em.getCriteriaBuilder();
		List<OrderItem> orders = new ArrayList<OrderItem>();
		CriteriaQuery<OrderItem> criteriaQuery = qb.createQuery(OrderItem.class);
		Root<OrderItem> orderRoot = criteriaQuery.from(OrderItem.class);
		Path<String> buyerId = orderRoot.get("buyer");
		Path<String> status  = orderRoot.get("orderStatus");
		Predicate condition_1 = qb.equal(buyerId, buyer);
		Predicate condition_2 = qb.equal(status, 2);
		criteriaQuery.where(qb.and(condition_1, condition_2));
		TypedQuery<OrderItem> typedQuery = em.createQuery(criteriaQuery);
		
		orders = typedQuery.getResultList();
		
		return orders;
	}

}
