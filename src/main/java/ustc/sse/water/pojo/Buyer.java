package ustc.sse.water.pojo;

import java.io.Serializable;
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


/**
 * 
 * 商城买家用户信息. <br>
 * 类详细说明.
 * <p>
 * Copyright: Copyright (c) 2013年12月23日 下午6:53:18
 * <p>
 * Company: 中国科学技术大学软件学院
 * <p>
 * @author 杨飞：sa613371@mail.ustc.edu.cn
 * @version 1.0.0
 */
@SuppressWarnings("serial")
@Entity
public class Buyer implements Serializable {

	/** 买家id，主键，自增*/
	private long buyerID;
	
	/** 买家name，varchar(20) NOT NULL 注册账户*/
	private String username;
	
	/** 买家用户昵称 varchar(20) DEFAULT NULL*/
	private String buyerName;
	
	/** 买家登录密码 varchar(64) NOT NULL*/
	private String password;
	
	/** 买家真实姓名varchar(20) DEFAULT NULL*/
	private String trueName;
	
	/** 身份认证证件类型，tinyint DEFAULT NULL,0表示未身份认证，1表示身份证，2学生证，3军官证等*/
	private int idFlag;
	
	/** 证件号码varchar(20) DEFAULT NULL*/
	private String identification;
	
	/** 买家账户余额double DEFAULT NULL*/
	private double account;
	
	/** 买家性别char(1) DEFAULT,f-女性，m-男性'*/
	private char sex;
	
	/** 买家生日 date DEFAULT NULL */
	private String birthday;
	
	/** 买家当前居住地址varchar(100) DEFAULT NULL*/
	private String localAddr;
	
	/** 电话号码varchar(20) DEFAULT NULL*/
	private String telNum;
	
	/** 邮箱地址 varchar(20) DEFAULT NULL */
	private String email;
	
	/** 买家信誉度float DEFAULT*/
	private float buyerCredit;
	
	/** 买家积分int DEFAULT NULL*/
	private int buyerScore;
	
	/** 买家好评率float DEFAULT NULL*/
	private float buyerRate;
	
	/** 账号注册时间datetime NOT NULL*/
	private String registerTime;
	
	private Set<Addr> addrs = new HashSet<Addr>();
	
	private Set<OrderItem> orders = new HashSet<OrderItem>();

	private Set<BasketItem> basket = new HashSet<BasketItem>();
	
	private Set<Favorites> favorites = new HashSet<Favorites>();

	private Set<Complaint> complaints = new HashSet<Complaint>();

	@Id
	@GeneratedValue
	@Column(length=20, nullable=false)
	public long getBuyerID() {
		return buyerID;
	}

	public void setBuyerID(long buyerID) {
		this.buyerID = buyerID;
	}

	@Column(length=10, nullable=false, unique=true)
	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	@Column(length=20)
	public String getBuyerName() {
		return buyerName;
	}

	public void setBuyerName(String buyerName) {
		this.buyerName = buyerName;
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

	public String getBirthday() {
		return birthday;
	}

	public void setBirthday(String birthday) {
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

	@Column(length=20)
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public float getBuyerCredit() {
		return buyerCredit;
	}

	public void setBuyerCredit(float buyerCredit) {
		this.buyerCredit = buyerCredit;
	}

	public int getBuyerScore() {
		return buyerScore;
	}

	public void setBuyerScore(int buyerScore) {
		this.buyerScore = buyerScore;
	}

	public float getBuyerRate() {
		return buyerRate;
	}

	public void setBuyerRate(float buyerRate) {
		this.buyerRate = buyerRate;
	}

	public String getRegisterTime() {
		return registerTime;
	}

	public void setRegisterTime(String registerTime) {
		this.registerTime = registerTime;
	}

	@OneToMany(cascade={CascadeType.ALL}, fetch=FetchType.EAGER)
	@JoinColumn(name="buyer")
	public Set<Addr> getAddrs() {
		return addrs;
	}

	public void setAddrs(Set<Addr> addrs) {
		this.addrs = addrs;
	}

	@OneToMany(mappedBy="buyer",cascade={CascadeType.ALL}, fetch=FetchType.EAGER)
	public Set<OrderItem> getOrders() {
		return orders;
	}

	public void setOrders(Set<OrderItem> orders) {
		this.orders = orders;
	}

	@OneToMany(mappedBy="buyer",cascade={CascadeType.MERGE,CascadeType.REMOVE}, fetch=FetchType.EAGER)
	public Set<BasketItem> getBasket() {
		return basket;
	}

	public void setBasket(Set<BasketItem> basket) {
		this.basket = basket;
	}

	@OneToMany(mappedBy="buyer")
	public Set<Favorites> getFavorites() {
		return favorites;
	}

	public void setFavorites(Set<Favorites> favorites) {
		this.favorites = favorites;
	}

	@OneToMany
	@JoinColumn(name="Buyer_id")
	public Set<Complaint> getComplaints() {
		return complaints;
	}

	public void setComplaints(Set<Complaint> complaints) {
		this.complaints = complaints;
	}

}
