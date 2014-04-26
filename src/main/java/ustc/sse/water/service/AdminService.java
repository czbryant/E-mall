package ustc.sse.water.service;


import java.util.List;

import ustc.sse.water.pojo.Admin;
import ustc.sse.water.pojo.Advertisement;
import ustc.sse.water.pojo.Announcement;
import ustc.sse.water.pojo.ProductType;
/**
 * 管理员service类. <br>
 * 类详细说明.
 * <p>
 * Copyright: Copyright (c) 2014年1月29日 上午9:22:03
 * <p>
 * Company: 中国科学技术大学软件学院
 * <p>
 * @author wangytao@mail.ustc.edu.cn
 * @version 1.0.0
 */
public interface AdminService {
	
	public void addAdmin(Admin admin);
	public Admin findAdmin(String name, String password);
	
	
	public List<Advertisement> getAdvertisements();
	public void updateAdvertisement(Advertisement advertisement);
	public void deleteAdvertisement(long id);
	public void addAdvertisement(Advertisement advertisement);
	
	public List<Announcement> getAnnouncements();
	public Announcement getAnnouncement(String id);
	public void updateAnnouncement(Announcement announcement);
	public void deleteAnnouncement(long id);
	public void addAnnouncement(Announcement announcement);
	
	public List<ProductType> getTopGradeProductTypes();      		//获取一级商品类型
	public List<ProductType> getChildProductTypes(short id);     	//获取对应商品类型的子类型
	public void addProductType(String name, short id, String b_Or_p);
	
	
}
