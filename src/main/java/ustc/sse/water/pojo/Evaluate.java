package ustc.sse.water.pojo;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
/**
 * 
 * 评价表. <br>
 * 类详细说明.
 * <p>
 * Copyright: Copyright (c) 2014年2月19日 下午7:01:24
 * <p>
 * Company: 中国科学技术大学软件学院
 * <p>
 * @author 杨飞：sa613371@mail.ustc.edu.cn
 * @version 1.0.0
 */
@SuppressWarnings("serial")
@Entity
public class Evaluate implements Serializable {

	/*评价id,主键，自增*/
	private long id;
	
	private Product product;
	
	/*商品评价内容*/
	private String productEval;
	
	/*店铺打分分数*/
	private int shopEvaluation;
	
	private Date postTime; 
	
	private OrderItem orderItem;

	@Id
	@GeneratedValue
	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getProductEval() {
		return productEval;
	}

	public void setProductEval(String productEval) {
		this.productEval = productEval;
	}

	public int getShopEvaluation() {
		return shopEvaluation;
	}

	public void setShopEvaluation(int shopEvaluation) {
		this.shopEvaluation = shopEvaluation;
	}

	@Temporal(TemporalType.DATE)
	public Date getPostTime() {
		return postTime;
	}

	public void setPostTime(Date postTime) {
		this.postTime = postTime;
	}
	
	@OneToOne
	@JoinColumn(name="OrderItem_id")
	public OrderItem getOrderItem() {
		return orderItem;
	}

	public void setOrderItem(OrderItem orderItem) {
		this.orderItem = orderItem;
	}
	
	@ManyToOne(fetch=FetchType.EAGER)
	@JoinColumn(name="Product_id")
	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

	
	
	
}
