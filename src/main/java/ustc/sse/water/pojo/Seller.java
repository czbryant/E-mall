package ustc.sse.water.pojo;

import java.io.Serializable;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * 
 * 卖家用户信息. <br>
 * 类详细说明.
 * <p>
 * Copyright: Copyright (c) 2013年12月23日 下午7:47:22
 * <p>
 * Company: 中国科学技术大学软件学院
 * <p>
 * @author 杨飞：sa613371@mail.ustc.edu.cn
 * @version 1.0.0
 */
@SuppressWarnings("serial")
@Entity
public class Seller implements Serializable {
	/** 卖家id，主键bigint NOT NULL AUTO_INCREMENT*/
	private long sellerID;
	
	/** 卖家id，varchar(20) NOT NULL邮箱注册账户*/
	private String username;
	
	/** 卖家用户昵称varchar(20) DEFAULT NULL */
	private String sellerName;
	
	/** 卖家登录密码varchar(64) NOT NULL*/
	private String password;
	
	/** 卖家真实姓名varchar(20) DEFAULT NULL*/
	private String trueName;
	
	/** 身份认证证件类型 tinyint DEFAULT NULL ，0表示未身份认证，1表示身份证，2学生证，3军官证等*/
	private int idFlag;
	
	/** 证件号码varchar(20) DEFAULT*/
	private String identification;
	
	/** 卖家店铺id,varchar(200) DEFAULT NULL,多个店铺可用分号分割*/
	private Shop shop;
	
	/** 卖家账户余额double DEFAULT NULL*/
	private double account;
	
	/** 卖家性别char(1) DEFAULT NULL*/
	private char sex;
	
	/** 卖家生日date DEFAULT NULL*/
	private Date birthday;
	
	/** 卖家当前居住地址varchar(100) DEFAULT NULL*/
	private String localAddr;
	
	/** 电话号码varchar(20) DEFAULT NULL*/
	private String telNum;
	
	/** 邮箱地址varchar(20) DEFAULT NULL*/
	private String email;
	
	/** 邮政编varchar(10) DEFAULT NULL*/
	private String postcode;
	
	/** 卖家信誉度float DEFAULT NULL*/
	private float sellerCredit;
	
	/** 卖家好评率float DEFAULT NULL*/
	private float sellerRate;
	
	/** 账号注册时间datetime NOT NULL*/
	private String registerTime;
	
	private Set<Product> products = new HashSet<Product>();

	@Id
	@GeneratedValue
	@Column(nullable=false)
	public long getsellerID() {
		return sellerID;
	}

	public void setsellerID(long sellerID) {
		this.sellerID = sellerID;
	}

	@Column(length=20, nullable=false, unique=true)
	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	@Column(length=20)
	public String getsellerName() {
		return sellerName;
	}

	public void setsellerName(String sellerName) {
		this.sellerName = sellerName;
	}

	@Column(length=64, nullable=false)
	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	@Column(length=20)
	public String getTrueName() {
		return trueName;
	}

	public void setTrueName(String trueName) {
		this.trueName = trueName;
	}

	public int getIdFlag() {
		return idFlag;
	}

	public void setIdFlag(int idFlag) {
		this.idFlag = idFlag;
	}

	@Column(length=20)
	public String getIdentification() {
		return identification;
	}

	public void setIdentification(String identification) {
		this.identification = identification;
	}

	public double getAccount() {
		return account;
	}

	public void setAccount(double account) {
		this.account = account;
	}

	public char getSex() {
		return sex;
	}

	public void setSex(char sex) {
		this.sex = sex;
	}

	@Temporal(TemporalType.DATE)
	public Date getBirthday() {
		return birthday;
	}

	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}

	@Column(length=100)
	public String getLocalAddr() {
		return localAddr;
	}

	public void setLocalAddr(String localAddr) {
		this.localAddr = localAddr;
	}

	@Column(length=20)
	public String getTelNum() {
		return telNum;
	}

	public void setTelNum(String telNum) {
		this.telNum = telNum;
	}

	@Column(length=40)
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	@Column(length=10)
	public String getPostcode() {
		return postcode;
	}

	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}

	public float getsellerCredit() {
		return sellerCredit;
	}

	public void setsellerCredit(float sellerCredit) {
		this.sellerCredit = sellerCredit;
	}

	public float getsellerRate() {
		return sellerRate;
	}

	public void setsellerRate(float sellerRate) {
		this.sellerRate = sellerRate;
	}

	@Column(length=20)
	public String getRegisterTime() {
		return registerTime;
	}

	public void setRegisterTime(String registerTime) {
		this.registerTime = registerTime;
	}

	@OneToMany(mappedBy="seller",fetch=FetchType.EAGER)
	public Set<Product> getProducts() {
		return products;
	}

	public void setProducts(Set<Product> products) {
		this.products = products;
	}

	@OneToOne(fetch=FetchType.EAGER,cascade={CascadeType.ALL})
	@JoinColumn(name="Shop_id")
	public Shop getShop() {
		return shop;
	}

	public void setShop(Shop shop) {
		this.shop = shop;
	}
}
