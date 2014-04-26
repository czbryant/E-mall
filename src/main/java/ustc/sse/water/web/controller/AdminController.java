package ustc.sse.water.web.controller;


import java.io.File;
import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;





import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import ustc.sse.water.constants.CommonConstant;
import ustc.sse.water.pojo.Admin;
import ustc.sse.water.pojo.Advertisement;
import ustc.sse.water.pojo.Announcement;
import ustc.sse.water.pojo.ProductType;
import ustc.sse.water.service.AdminService;
import ustc.sse.water.utils.CompressImg;
import ustc.sse.water.utils.SecurityUtil;
import ustc.sse.water.utils.SingleSignOnUtil;

@Controller
@RequestMapping("/AdminController")
public class AdminController {
	
	
	private AdminService adminService;
	
	/**
	 * 获取 adminService
	 * @return adminService
	 */
	public AdminService getAdminService() {
		return adminService;
	}

	/**
	 * 设置 adminService
	 * @param adminService adminService
	 */

	@Resource(name="AdminService")
	public void setAdminService(AdminService adminService) {
		this.adminService = adminService;
	}
	
	@RequestMapping("")
	public String admin(HttpServletRequest request, HttpServletResponse response) {
		
		return "/admin/admin_login";
		
	}
	
	@RequestMapping("/login")
	public String login(HttpServletRequest request, HttpServletResponse response) throws NoSuchAlgorithmException, UnsupportedEncodingException{
		request.setCharacterEncoding("utf-8");
		String name = request.getParameter("username");
		String password = request.getParameter("password");
		String pwd = SecurityUtil.AESCode(password);
		Admin admin = adminService.findAdmin(name, pwd);		
		if(admin!=null){
			request.getSession().setAttribute("current_user", admin);
			
			SingleSignOnUtil.setCookie(request, response, CommonConstant.WWW_COOKIE_NAME, admin.getUsername());
			return "redirect:adminMgr";
		} else{
			return "/admin/admin_login";
		}
	}
	
	
	
	// @SuppressWarnings("unchecked")
	@RequestMapping(value = "adminMgr")
	public String adminManage(HttpServletRequest request) {

		List<Advertisement> Advertisements = this.adminService
				.getAdvertisements();
		List<Announcement> Announcements = this.adminService.getAnnouncements();

		List<ProductType> ProductTypes = this.adminService.getTopGradeProductTypes();

		
		/*for (Announcement c : Announcements) {
			System.out.println("AdminController   " + c.getTitle() + "  Time:"
					+ (new Date()).toString());

		}*/

		request.getSession().setAttribute("Advertisements", Advertisements);
		request.getSession().setAttribute("Announcements", Announcements);
		request.getSession().setAttribute("ProductTypes", ProductTypes);
		
		return "/admin/adminMgr";
	}
	
	
	@RequestMapping(value="/addAdvertisement", method=RequestMethod.POST)
	public String addAdvertisement(HttpServletRequest request, String profile) {
		Advertisement advertisement = new Advertisement();
		
		MultipartHttpServletRequest  multipartRequest = (MultipartHttpServletRequest) request;
		
		CommonsMultipartFile uploadfile = (CommonsMultipartFile) multipartRequest.getFile("imageURL");


		String imgName = UUID.randomUUID().toString() + ".jpg";
		String realPath = "C://home//upload//admin//";//硬地址
		File dirPath = new File(realPath);
		if (!dirPath.exists()){
			dirPath.mkdirs();
		} 
		
		File imgFile = new File("C://home//123//" + imgName);
		try {
			uploadfile.getFileItem().write(imgFile);										//存放原图
			CompressImg.compressImgMethod(imgFile, realPath, imgName, 700, 400, false);		//存放缩略图
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		advertisement.setImageURL(realPath + imgName);
		advertisement.setProfile(profile);
		
		
		
		
		this.adminService.addAdvertisement(advertisement);
		
		return "redirect:adminMgr";
	}

	@RequestMapping(value="/deleteAdvertisement")
	@ResponseBody
	public String deleteAdvertisement(HttpServletRequest request, String id) {
		
		this.adminService.deleteAdvertisement(Long.parseLong(id));
		
		return "1";
	}

	@RequestMapping(value="/addAnnouncement", method=RequestMethod.POST)
	public String addAnnouncement(HttpServletRequest request, String announcementTitle, String announcementContent) {
		Announcement announcement = new Announcement();
		String tmp = String.valueOf(announcementContent.replaceAll(" ","&nbsp;").replaceAll("\\n","<br>"));
		announcement.setTitle(announcementTitle);
		announcement.setContent(tmp);
		
		this.adminService.addAnnouncement(announcement);
		
		return "redirect:adminMgr";
	}
	
	@RequestMapping(value="/deleteAnnouncement")
	@ResponseBody
	public String deleteAnnouncement(HttpServletRequest request, String id) {
		
		this.adminService.deleteAnnouncement(Long.parseLong(id));
		
		return "1";
	}
	
	
	@RequestMapping(value="/type")
	public String type(HttpServletRequest request) {

		List<ProductType> ProductTypes = this.adminService.getTopGradeProductTypes();

		request.getSession().setAttribute("ProductTypes", ProductTypes);
		
		return "admin/type";
	}
	
	@RequestMapping(value="/GetProductTypeChilds")
	public void GetProductTypeChilds(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String str=request.getParameter("id");
		List<ProductType> childs = null;
		try {
			short tmp = Short.parseShort(str);
			childs = adminService.getChildProductTypes(tmp);
		} catch (NumberFormatException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
	        
		response.setContentType("text/xml;charset=utf-8");
		response.setHeader("Cache-Control", "no-cache");
		StringBuffer buf = new StringBuffer();

		buf.append("document.frm.child.length = 0;\n");   
		
		if(childs == null) {
		
			buf.append("document.frm.child.length = " + (1) + ";\n");
			buf.append("document.frm.child.options[0].value = '-1';\n");
			buf.append("document.frm.child.options[0].text = 'Noned Selected!';\n");
			//buf.append("document.frm.child.selectedIndex = 0;\n");
		}
		else {
			buf.append("document.frm.child.length = " + (childs.size()) + ";\n");
			for(int i=0; i<childs.size(); i++) {
				ProductType c = childs.get(i);
				buf.append("document.frm.child.options[" + (i) + "].value = '" + c.getId() + "';\n");
				buf.append("document.frm.child.options[" + (i) + "].text = '" + c.getName() + "';\n");
			}
		}
		response.setHeader("Pragma", "no-cache"); //HTTP1.0
		response.setDateHeader("Expires", 0); //prevents catching at proxy server

		response.getWriter().write(buf.toString());
		
	}
	
	@RequestMapping(value="/GetProductTypeGrandChilds")
	public void GetProductTypeGrandChilds(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String str=request.getParameter("id");
		short id = Short.parseShort(str);
		List<ProductType> grandSon = null;
		try {
			grandSon = adminService.getChildProductTypes(id);
		} catch (NumberFormatException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		response.setContentType("text/xml;charset=utf-8");
		response.setHeader("Cache-Control", "no-cache");
		StringBuffer buf = new StringBuffer();
		buf.append("document.frm.grandson.length = 0;\n");   
		if(id != -1) {
			if(grandSon == null) {
				buf.append("document.frm.grandson.length = " + (1) + ";\n");
				buf.append("document.frm.grandson.options[0].value = '-1';\n");
				buf.append("document.frm.grandson.options[0].text = 'Noned Selected!';\n");
				//buf.append("document.frm.grandson.selectedIndex = 0;\n");
			}
			else {
				buf.append("document.frm.grandson.length = " + (grandSon.size()) + ";\n");
				for(int i=0; i<grandSon.size(); i++) {
					ProductType c = grandSon.get(i);
					buf.append("document.frm.grandson.options[" + (i) + "].value = '" + c.getId() + "';\n");
					buf.append("document.frm.grandson.options[" + (i) + "].text = '" + c.getName() + "';\n");
				}
			}
		}
			
		response.setHeader("Pragma", "no-cache"); //HTTP1.0
		response.setDateHeader("Expires", 0); //prevents catching at proxy server

		response.getWriter().write(buf.toString());
		
	}
	
	@RequestMapping(value="/addProductType")
	public String addProductType(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String id=request.getParameter("id");
		String b_OR_p=request.getParameter("b_OR_p");
		String productTypeName = request.getParameter("productType");
		System.out.println("bid	" + id);
		System.out.println("parentOrBrother	" + b_OR_p);
		System.out.println("productType	" + productTypeName);
		
	
		adminService.addProductType(productTypeName, Short.parseShort(id), b_OR_p);
		
		
		return "redirect:adminMgr";
	}
	
	
}
