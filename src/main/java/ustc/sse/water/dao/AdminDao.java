package ustc.sse.water.dao;

import java.util.List;

import ustc.sse.water.pojo.Admin;
import ustc.sse.water.pojo.Advertisement;
import ustc.sse.water.pojo.Announcement;
import ustc.sse.water.pojo.ProductType;
/**
 * 管理员DAO接口. <br>
 * 接口.
 * <p>
 * Copyright: Copyright (c) 2013年12月23日 下午5:59:00
 * <p>
 * Company: 中国科学技术大学软件学院
 * <p>
 * @author wangytao@mail.ustc.edu.cn
 * @version 1.0.0
 */
public interface AdminDao  extends SuperDao {
	public void addAdmin(Admin admin);
	public Admin findAdmin(String userame, String password);
	
	public List<Advertisement> getAdvertisements();
	public void addAdvertisement(Advertisement advertisement);
	public void deleteAdvertisement(Advertisement advertisement);
	public void updateAdvertisement(Advertisement advertisement);
	
	public List<Announcement> getAnnouncements();
	public Announcement getAnnouncement(String id);
	public void addAnnouncement(Announcement announcement);
	public void deleteAnnouncement(Announcement announcement);
	public void updateAnnouncement(Announcement announcement);
	
	
	public ProductType getProductType(short id);
	public List<ProductType> getTopGradeProductTypes();
	public List<ProductType> getChildProductTypes(ProductType producttype);
	public void addProductTypeByBrother(ProductType productType, short id);
	public void addProductTypeByParent(ProductType productType, short id);

}
