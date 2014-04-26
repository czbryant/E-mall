package ustc.sse.water.pojo;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;


@Entity
@Inheritance(strategy=InheritanceType.JOINED)
public class Product implements Serializable{

	/** serialVersionUID */
	private static final long serialVersionUID = 7737960454785514538L;
	
	/** 
	 * ProductId 商品id 主键varchar(20)
	 * */
	private String productId;
	
	
	/** images 图片*/
	private Set<Image> images = new HashSet<Image>();
	
	/** goodsName  商品名称*/
	private String productName;
	
	/** price 单价*/
	private float price;
	
	/** 存货量，单位是kg，float DEFAULT NULL*/
	private int inventory;
	
	/** 销量，单位DEFAULT NULL*/
	private int salesNum;
	
	private float promotionPrice;
	
	/** typeId 类别*/
	private ProductType productType;
	
	/** keyWord 关键字*/
	private String keyWord;
	
	/** description 描述*/
	private String description;
	
	/** assessNum 评价次数*/
	private int assessNum;
	
	/**
	 * 主图的url
	 */
	private String mainImgUrl;
	
	/** inTime 添加时间*/
	private String inTime;
	
	private Seller seller;
	
	/** bill 发票*/
	private String bill;
	
	/** Guarantee 保修*/
	private String guarantee;
	
	/** 店铺分数float(8,2) DEFAULT NULL*/
	private String score;
	
	private Set<OrderItem> orderItems = new HashSet<OrderItem>();
	
	private Set<BasketItem> basketItems = new HashSet<BasketItem>();
	
	private Set<Evaluate> evaluates = new HashSet<Evaluate>();
	
	@Id
	@Column(length=50)
	public String getProductId() {
		return productId;
	}

	public void setProductId(String productId) {
		this.productId = productId;
	}

	public float getPrice() {
		return price;
	}

	public void setPrice(float price) {
		this.price = price;
	}

	public int getInventory() {
		return inventory;
	}

	public void setInventory(int inventory) {
		this.inventory = inventory;
	}

	/**
	 * 获取 promotionPrice
	 * @return promotionPrice
	 */
	@Column(name="PromotionPrice")
	public float getPromotionPrice() {
		return promotionPrice;
	}

	/**
	 * 设置 promotionPrice
	 * @param promotionPrice promotionPrice
	 */
	public void setPromotionPrice(float promotionPrice) {
		this.promotionPrice = promotionPrice;
	}

	public String getKeyWord() {
		return keyWord;
	}

	public void setKeyWord(String keyWord) {
		this.keyWord = keyWord;
	}

	@Column(length=5000)
	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public int getAssessNum() {
		return assessNum;
	}

	public void setAssessNum(int assessNum) {
		this.assessNum = assessNum;
	}

	@Column(length=100)
	public String getMainImgUrl() {
		return mainImgUrl;
	}

	public void setMainImgUrl(String mainImgUrl) {
		this.mainImgUrl = mainImgUrl;
	}

	public int getSalesNum() {
		return salesNum;
	}

	public void setSalesNum(int salesNum) {
		this.salesNum = salesNum;
	}

	public String getInTime() {
		return inTime;
	}

	public void setInTime(String inTime) {
		this.inTime = inTime;
	}

	@OneToMany(mappedBy="product", cascade={CascadeType.ALL}, fetch=FetchType.EAGER)
	public Set<Image> getImages() {
		return images;
	}

	public void setImages(Set<Image> images) {
		this.images = images;
	}

	@Column(length=2)
	public String getBill() {
		return bill;
	}

	public void setBill(String bill) {
		this.bill = bill;
	}

	@Column(length=2)
	public String getGuarantee() {
		return guarantee;
	}

	public void setGuarantee(String guarantee) {
		this.guarantee = guarantee;
	}

	@ManyToOne
	@JoinColumn(name="ProductType_id")
	public ProductType getProductType() {
		return productType;
	}

	public void setProductType(ProductType productType) {
		this.productType = productType;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	@ManyToOne(fetch=FetchType.EAGER)
	@JoinColumn(name="Seller_id")
	public Seller getSeller() {
		return seller;
	}

	public void setSeller(Seller seller) {
		this.seller = seller;
	}

	@OneToMany(mappedBy="product")
	public Set<OrderItem> getOrderItems() {
		return orderItems;
	}

	public void setOrderItems(Set<OrderItem> orderItems) {
		this.orderItems = orderItems;
	}

	@OneToMany(mappedBy="product")
	public Set<BasketItem> getBasketItems() {
		return basketItems;
	}

	public void setBasketItems(Set<BasketItem> basketItems) {
		this.basketItems = basketItems;
	}

	@OneToMany(mappedBy="product", cascade={CascadeType.ALL}, fetch=FetchType.EAGER)
	public Set<Evaluate> getEvaluates() {
		return evaluates;
	}

	public void setEvaluates(Set<Evaluate> evaluates) {
		this.evaluates = evaluates;
	}

	public String getScore() {
		return score;
	}

	public void setScore(String score) {
		this.score = score;
	}

	
}
