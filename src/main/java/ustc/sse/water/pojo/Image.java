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
 * 图片库信息. <br>
 * 类详细说明.
 * <p>
 * Copyright: Copyright (c) 2013年12月23日 下午9:00:42
 * <p>
 * Company: 中国科学技术大学软件学院
 * <p>
 * @author 杨飞：sa613371@mail.ustc.edu.cn
 * @version 1.0.0
 */
@SuppressWarnings("serial")
@Entity
public class Image implements Serializable {

	/** 商品图片id，主键varchar(20) NOT NULL*/
	private long imageId;
	
	/** 商品图片地址varchar(20) DEFAULT NULL*/
	private String imageUrl;
	
	private Product product;

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(length=255)
	public long getImageId() {
		return imageId;
	}

	public void setImageId(long imageId) {
		this.imageId = imageId;
	}

	
	@Column(name="Image_url")
	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}

	@ManyToOne
	@JoinColumn(name="product_id")
	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}
	
}
