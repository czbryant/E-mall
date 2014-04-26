package ustc.sse.water.pojo;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;

/**
 * 
 * 订单信息. <br>
 * 类详细说明.
 * <p>
 * Copyright: Copyright (c) 2013年12月23日 下午8:35:16
 * <p>
 * Company: 中国科学技术大学软件学院
 * <p>
 * @author 杨飞：sa613371@mail.ustc.edu.cn
 * @version 1.0.0
 */
@SuppressWarnings("serial")
@Entity
public class OrderItem implements Serializable {

	/** id主键int NOT NULL AUTO_INCREMENT*/
	private long id;
	
	/** 订单号varchar(20) NOT NULL*/
	private String orderID;
	
	/** 买家buyer*/
	private Buyer buyer;
	
	/** 卖家buyer*/
	private Long sellerId;
	
	/** 商品id varchar(20) NOT NULL*/
	private Product product;
	
	/** 已购买商品详细配置信息varchar(200) DEFAULT NULL*/
	private String productIllustration;
	
	/** 相同的同件商品购买数量 **/
	private int count;
	
	/** 订单成交时间datetime DEFAULT NULL*/
	private String postTime;
	
	/** 商品当前价格float(8,2) DEFAULT NULL*/
	private float currentPrice;
	
	/** 付款方式tinyint DEFAULT NULL,1-货到付款;2-支付宝支付;3-银行支付*/
	private int payType;
	
	/** 配送方式smallint DEFAULT NULL，指快递公司，1-申通；2-韵达；3-ems等等*/
	private int conveyType;
	
	/** 物流单号varchar(20) DEFAULT NULL*/
	private String logisticsId;
	
	/** 收货信息，根据buyer获取到addr中设置为默认的varchar(300) DEFAULT NULL*/
	private String receiveInfo;
	
	/** 最近更新时间datetime DEFAULT NULL*/
	private String updateTime;
	
	/** 订单状态tinyint DEFAULT NULL，-1表示关闭交易，0表示初始化订单等待付款，1表示已付款等待发货，2已发货等待确认收货，
	 * 3等待评价，4买家已评价,5退款申请，6是退款处理结束，7是不予退款，8双方互评，-2是投诉状态*/
	private int orderStatus;
	
	private Evaluate evaluate;
	
	@Id
	@GeneratedValue
	@Column(length=20, nullable=false)
	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	@Column(length=50, nullable=false)
	public String getOrderID() {
		return orderID;
	}

	public void setOrderID(String orderID) {
		this.orderID = orderID;
	}
	
	public String getPostTime() {
		return postTime;
	}

	public void setPostTime(String postTime) {
		this.postTime = postTime;
	}

	public float getCurrentPrice() {
		return currentPrice;
	}

	public void setCurrentPrice(float currentPrice) {
		this.currentPrice = currentPrice;
	}

	public int getPayType() {
		return payType;
	}

	public void setPayType(int payType) {
		this.payType = payType;
	}

	public int getConveyType() {
		return conveyType;
	}

	public void setConveyType(int conveyType) {
		this.conveyType = conveyType;
	}

	@Column(length=20)
	public String getLogisticsId() {
		return logisticsId;
	}

	public void setLogisticsId(String logisticsId) {
		this.logisticsId = logisticsId;
	}

	@Column(length=300)
	public String getReceiveInfo() {
		return receiveInfo;
	}

	public void setReceiveInfo(String receiveInfo) {
		this.receiveInfo = receiveInfo;
	}

	@Column(length=30)
	public String getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(String updateTime) {
		this.updateTime = updateTime;
	}

	public int getOrderStatus() {
		return orderStatus;
	}

	public void setOrderStatus(int orderStatus) {
		this.orderStatus = orderStatus;
	}

	@ManyToOne(fetch=FetchType.EAGER)
	@JoinColumn(name="Buyer_id")
	public Buyer getBuyer() {
		return buyer;
	}

	public void setBuyer(Buyer buyer) {
		this.buyer = buyer;
	}
	
	
	@Column(name = "Seller_id", length=20)
	public Long getSellerId() {
		return sellerId;
	}

	public void setSellerId(Long sellerId) {
		this.sellerId = sellerId;
	}

	@ManyToOne
	@JoinColumn(name="Product_id")
	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

	@Column(length=200)
	public String getProductIllustration() {
		return productIllustration;
	}

	public void setProductIllustration(String productIllustration) {
		this.productIllustration = productIllustration;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	@OneToOne(mappedBy="orderItem")
	public Evaluate getEvaluate() {
		return evaluate;
	}

	public void setEvaluate(Evaluate evaluate) {
		this.evaluate = evaluate;
	}



}
