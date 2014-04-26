package ustc.sse.water.pojo;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
/**
 * 
 * 购物车. <br>
 * 类详细说明.
 * <p>
 * Copyright: Copyright (c) 2013年12月23日 下午8:23:56
 * <p>
 * Company: 中国科学技术大学软件学院
 * <p>
 * @author 杨飞：sa613371@mail.ustc.edu.cn
 * @version 1.0.0
 */
@Entity
public class BasketItem implements Serializable {
	/** serialVersionUID */
	private static final long serialVersionUID = 5270522214314869344L;

	/** 主键id，int NOT NULL AUTO_INCREMENT*/
	private long id;
	
	/** 买家buyer*/
	private Buyer buyer;
	
	/** 商品id varchar(50) NOT NULL*/
	private Product product;
	
	
	/** 添加商品的数量int DEFAULT NULL*/
	private int addCount;
	
	/** 已添加到购物车的商品被选中的详细信息varchar(200) DEFAULT NULL*/
	private String productIllustration;

	@Column(length=50, nullable=false)
	public String getProductIllustration() {
		return productIllustration;
	}

	public void setProductIllustration(String productIllustration) {
		this.productIllustration = productIllustration;
	}

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	@Column(nullable=true)
	public int getAddCount() {
		return addCount;
	}

	public void setAddCount(int addCount) {
		this.addCount = addCount;
	}

	@ManyToOne
	@JoinColumn(name="Buyer_id")
	public Buyer getBuyer() {
		return buyer;
	}

	public void setBuyer(Buyer buyer) {
		this.buyer = buyer;
	}

	@ManyToOne
	@JoinColumn(name="Product_id")
	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}
	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((productIllustration == null) ? 0 : productIllustration.hashCode())
				+ 7 * product.getProductId().hashCode();
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		BasketItem other = (BasketItem) obj;
		if (productIllustration.equals(other.productIllustration) &&
			product.getProductId().equals(other.product.getProductId()))
			return true;
		else {
			return false;
		}
	}

}
