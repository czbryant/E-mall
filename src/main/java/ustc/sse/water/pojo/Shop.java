package ustc.sse.water.pojo;

import java.io.Serializable;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToOne;

/**
 * 
 * 店铺信息. <br>
 * 类详细说明.
 * <p>
 * Copyright: Copyright (c) 2013年12月23日 下午8:52:11
 * <p>
 * Company: 中国科学技术大学软件学院
 * <p>
 * @author 杨飞：sa613371@mail.ustc.edu.cn
 * @version 1.0.0
 */
@SuppressWarnings("serial")
@Entity
public class Shop implements Serializable {

	/** 店铺编号id主键bigint(20) NOT NULL AUTO_INCREMENT*/
	private String shopId;
	
	/** 卖家编号varchar(20) NOT NULL*/
	private Seller seller;
	
	/** 店铺名varchar(20) NOT NULL*/
	private String shopName;
	
	/** 总评论数int DEFAULT NULL*/
	private int evaluateNum;
	
	/**
	 * 商店标志，只允许一张，代表本商店
	 */
	private String shopImg;

	@Id
	@Column(length=20, nullable=false)
	public String getShopId() {
		return shopId;
	}

	public void setShopId(String shopId) {
		this.shopId = shopId;
	}

	@Column(length=50)
	public String getShopName() {
		return shopName;
	}

	public void setShopName(String shopName) {
		this.shopName = shopName;
	}

	public int getEvaluateNum() {
		return evaluateNum;
	}

	public void setEvaluateNum(int evaluateNum) {
		this.evaluateNum = evaluateNum;
	}

	@OneToOne(mappedBy="shop", cascade={CascadeType.ALL})
	public Seller getSeller() {
		return seller;
	}

	public void setSeller(Seller seller) {
		this.seller = seller;
	}

	@Column(length=100)
	public String getShopImg() {
		return shopImg;
	}

	public void setShopImg(String shopImg) {
		this.shopImg = shopImg;
	}
		
}
