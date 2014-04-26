package ustc.sse.water.web.controller;


import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import ustc.sse.water.constants.CommonConstant;
import ustc.sse.water.pojo.Advertisement;
import ustc.sse.water.pojo.Announcement;
import ustc.sse.water.pojo.BasketItem;
import ustc.sse.water.pojo.BookGoods;
import ustc.sse.water.pojo.Buyer;
import ustc.sse.water.pojo.Favorites;
import ustc.sse.water.pojo.FruitGoods;
import ustc.sse.water.pojo.Product;
import ustc.sse.water.pojo.ProductType;
import ustc.sse.water.pojo.QueryResult;
import ustc.sse.water.pojo.Seller;
import ustc.sse.water.pojo.Shop;
import ustc.sse.water.service.AdminService;
import ustc.sse.water.service.BuyerService;
import ustc.sse.water.service.ProductService;
import ustc.sse.water.service.SellerService;
import ustc.sse.water.utils.GZipUtil;
import ustc.sse.water.utils.HistoryCookieUtil;

/**
 * 主控制器. <br>
 * 负责将基本的跳转分发到买家，卖家和管理员.
 * <p>
 * Copyright: Copyright (c) 2013年12月23日 下午10:17:42
 * <p>
 * Company: 中国科学技术大学软件学院
 * <p>
 * @author wangytao@mail.ustc.edu.cn
 * @version 1.0.0
 */
@Controller
public class MainController {

	ProductService productService;
	
	private AdminService adminService;
	
	@Resource(name="BuyerService")
	protected BuyerService buyerService;
	
	public ProductService getProductService() {
		return productService;
	}

	@Resource(name="ProductService")
	public void setProductService(ProductService productService) {
		this.productService = productService;
	}

	public AdminService getAdminService() {
		return adminService;
	}

	@Resource(name="AdminService")
	public void setAdminService(AdminService adminService) {
		this.adminService = adminService;
	}

	@Resource(name="SellerService")
	protected SellerService sellerService;
	
	@SuppressWarnings("unchecked")
	@RequestMapping("")
	public String welcome(HttpServletRequest request, HttpServletResponse response){
		
		List<Product> top3 = new ArrayList<Product>();
		
		top3 = (List<Product>) request.getSession().getAttribute("top3");
		if (top3 == null) {
			top3 = productService.getTop3();
			request.getSession().setAttribute("top3", top3);
		}
		
		List<Product> newPros = new ArrayList<Product>();
		newPros = productService.getNewProducts();
		
		List<Advertisement> Advertisements = this.adminService.getAdvertisements();
		request.getSession().setAttribute("Advertisements", Advertisements);
		
		List<Announcement> Announcements = this.adminService.getAnnouncements();
		request.getSession().setAttribute("Announcements", Announcements);
		
		List<ProductType> ProductTypes = this.adminService.getTopGradeProductTypes();
		request.getSession().setAttribute("ProductTypes", ProductTypes);
		
		request.getSession().setAttribute("newPros", newPros);
		return "/main/welcome";
	}
	
	/**
	 * @return 跳转至登录页
	 */
	@RequestMapping("/tologin")
	public String tologin(){
		return"/main/login";
	}
	
	/**
	 * @return 跳转至注册页
	 */
	@RequestMapping("/toregister")
	public String register(HttpServletRequest request){
		String msg = request.getParameter("msg");
		request.setAttribute("msg", msg);
		return "/main/register";
	}
	
	@RequestMapping("/tologout")
	public void toLogout(HttpServletRequest request, HttpServletResponse response){
		try {
			request.getRequestDispatcher("/BuyerController/logout").forward(request, response);
		} catch (ServletException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping("/toDetail")
	public String toDetail(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException{
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		String goodsId = request.getParameter("id");
		
		HistoryCookieUtil.addHistoryCookie(request, response, goodsId);
		
		if(goodsId.substring(0, 6).equals("000001")){
			FruitGoods fruitGoods = (FruitGoods) productService.getProductById(goodsId);
			Seller seller = fruitGoods.getSeller();
			Shop shop = seller.getShop();
			String deString = GZipUtil.gunzip(fruitGoods.getDescription());
			request.getSession().setAttribute("description", deString);
			request.setAttribute("product", fruitGoods);
			request.setAttribute("seller", seller);
			request.setAttribute("shop", shop);
		}else if(goodsId.substring(0, 6).equals("000002")){
			BookGoods bookGoods = (BookGoods) productService.getProductById(goodsId);
			Seller seller = bookGoods.getSeller();
			Shop shop = seller.getShop();
			String deString = GZipUtil.gunzip(bookGoods.getDescription());
			request.setAttribute("product", bookGoods);
			request.setAttribute("seller", seller);
			request.setAttribute("shop", shop);
			request.getSession().setAttribute("description", deString);
		}
		return "/main/product_detail";
	}
	
	@RequestMapping("/addToCart")
	@ResponseBody
	public String addCart(HttpServletRequest request, HttpServletResponse response, String num){
		Buyer buyer = (Buyer) request.getSession().getAttribute("current_user");
		buyer = buyerService.findBuyerById(buyer.getBuyerID());
		if (buyer != null) {
			String goodsID = request.getParameter("id");
			Product product = (Product) productService.getProductById(goodsID);
			BasketItem item = new BasketItem();
			item.setAddCount(Integer.parseInt(num));
			item.setProductIllustration("");
			item.setProduct(product);
			item.setBuyer(buyer);
			productService.saveItemIntoCart(buyer, item);
			return "1";
		} else {
			return "0";
		}
	}
	
	@RequestMapping("/toMyCart")
	public ModelAndView toMyCart(HttpServletRequest request){
		Buyer buyer = (Buyer) request.getSession().getAttribute("current_user");
		ModelAndView mav = new ModelAndView();
		if (buyer != null) {
			Set<BasketItem> carts = productService.getBasketByUid(buyer);
			request.setAttribute("mydbCart", carts);
			mav.setViewName("/buyer/cart");
		} else {
			mav.setViewName("/main/login");
		}
		return mav;
	}
	
	@RequestMapping(value="/delFromCart")
	@ResponseBody
	public String removeItemFromCart(HttpServletRequest request, String itemId, String itemDsc) {
		Buyer buyer = (Buyer) request.getSession().getAttribute("current_user");
		if (buyer == null) {
			return "fail";
		} else {
			buyer = buyerService.findBuyerById(buyer.getBuyerID());
			for (BasketItem item : buyer.getBasket()) {
				boolean a = (item.getProduct().getProductId()).equals(itemId);
				boolean b = item.getProductIllustration().equals(itemDsc);
				if(a && b){
					buyerService.removeItem(item);
					break;
				}
			}
			buyer = buyerService.findBuyerById(buyer.getBuyerID());
			request.setAttribute("mydbCart", buyer.getBasket());
			request.getSession().setAttribute("current_user", buyer);
			return "";
		}
	}

	
	/**
	 * 搜索controller
	 */
	@RequestMapping(value="/search")
	public String search(HttpServletRequest request){
		String pid = request.getParameter("page");
		String productname = request.getParameter("productname");
		List<Product> result = null;
		QueryResult<Product> queryResult = productService.productQuery(0, productname);
		int totalpage = (int) (queryResult.getTotalRecord() / CommonConstant.ONEPAGE_COUNTS + 1);
		request.setAttribute("totalpages", totalpage);
		if (pid != null) {//非第一次调用
			int pidInt = Integer.parseInt(pid);
			request.setAttribute("currentPage", pidInt);
			int firstIndex = (pidInt-1)*CommonConstant.ONEPAGE_COUNTS;
			queryResult = productService.productQuery(firstIndex, productname);
			if(pidInt == totalpage) {
				int begin = (int) (queryResult.getTotalRecord() - (pidInt-1)*CommonConstant.ONEPAGE_COUNTS);
				result = queryResult.getResultList().subList(0, begin);
			} else {
				result = queryResult.getResultList().subList(0, CommonConstant.ONEPAGE_COUNTS);
			}
		} else {
			request.setAttribute("currentPage", 1);
			request.getSession().setAttribute("queryname", productname);
			if(queryResult.getTotalRecord() < CommonConstant.ONEPAGE_COUNTS) {
				result = queryResult.getResultList();
			} else {
				result = queryResult.getResultList();
			}
		}
		request.setAttribute("queryResult", result);
		return "/main/search_result";
	}
	
	@RequestMapping(value="/announcement")
	public String announcementDetail(HttpServletRequest request, String anno_id) {
		Announcement anno = this.adminService.getAnnouncement(anno_id);
		
		request.getSession().setAttribute("anno", anno);
		return "/main/anno";
	}
	
	@RequestMapping("/imgout")
	public void outputImg(String imgurl, HttpServletResponse response){
		try {
			InputStream inputStream = null;
			ServletOutputStream sos = response.getOutputStream();
			response.reset();
			response.setContentType("image/jpeg");
			byte[] b = new byte[1024];
			
			try {
				inputStream = new FileInputStream(imgurl);
				int n = 0;
	            do {
	                n = inputStream.read(b);
	                if (n > 0) {
	                    sos.write(b, 0, n);
	                }
	            } while (n > 0);
				sos.flush();
			} finally {
				if (inputStream != null) {
	                 inputStream.close();
	             }
	             if (sos != null) {
	                 sos.close();
	             }
			}
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}

	@RequestMapping(value="/toSellerShop")
	public String toSellerShop(HttpServletRequest request,String id){
		Shop shop = sellerService.findShop(id);
		Seller seller = shop.getSeller();
		Iterator<Product> allGoods = seller.getProducts().iterator();
		List<Product> promotionGoods = sellerService.getPromotionGoods(seller.getsellerID());
		List<Product> newGoods = sellerService.getNewGoods(seller.getsellerID());
		List<Product> rankGoods = sellerService.getRanking(seller.getsellerID());
		request.getSession().setAttribute("shop", shop);
		request.getSession().setAttribute("seller", seller);
		request.getSession().setAttribute("promotionGoods", promotionGoods);
		request.getSession().setAttribute("newGoods", newGoods);
		request.getSession().setAttribute("rankGoods", rankGoods);
		request.getSession().setAttribute("allGoods", allGoods);
		String flag = "1";
		request.getSession().setAttribute("flag", flag);
		return "/seller/shop";
	}
	
	@RequestMapping("/loadConnection")
	public String loadConnection(HttpServletRequest request) {
		
		Buyer buyer = (Buyer) request.getSession().getAttribute("current_user");
		if(buyer != null){
			List<Favorites> favoritess =  buyerService.getFavorites(buyer);
			List<Favorites> fav_Products = new ArrayList<Favorites>();
			List<Favorites> fav_Shops = new ArrayList<Favorites>();
			if(favoritess != null)
				for( Favorites f : favoritess) {
					if (f.getProductOrShop() == 1)
						fav_Products.add(f);
					else
						fav_Shops.add(f);
				}
			
			request.getSession().setAttribute("fav_Products", fav_Products);
			request.getSession().setAttribute("fav_Shops", fav_Shops);

			return "/main/main_collection";
		}
		else
			return "redirect:tologin";
	}
	
	/**
	 * 验证卖家和买家账户的用户名唯一性
	 * userType = 0  表示买家
	 * userType = 1  表示卖家
	 * @param request
	 * @return
	 */
	@RequestMapping("validateUsername")
	@ResponseBody
	public String validateUsername(HttpServletRequest request) {
		String username = request.getParameter("username");
		String userType = request.getParameter("userType");
		if(userType.equals("0") && buyerService.findByUserame(username)) {
			return "failed";
		}
		else if(userType.equals("1") && sellerService.findByUserame(username)) {
			return "failed";
		}
		else
			return "success";
	}
	
}
