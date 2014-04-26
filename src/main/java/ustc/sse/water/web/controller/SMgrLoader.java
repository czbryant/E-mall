package ustc.sse.water.web.controller;

import java.io.UnsupportedEncodingException;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import ustc.sse.water.constants.CommonConstant;
import ustc.sse.water.pojo.OrderItem;
import ustc.sse.water.pojo.Product;
import ustc.sse.water.pojo.Seller;
import ustc.sse.water.pojo.Shop;
import ustc.sse.water.service.ProductService;
import ustc.sse.water.service.SellerService;
import ustc.sse.water.utils.SingleSignOnUtil;

@Controller
@RequestMapping("/SMgrLoader")
public class SMgrLoader {
	
	ProductService productService;
	
	public ProductService getProductService() {
		return productService;
	}

	@Resource(name="ProductService")
	public void setProductService(ProductService productService) {
		this.productService = productService;
	}
	
	private SellerService sellerService;
	
	/**
	 * 获取 sellerService
	 * @return sellerService
	 */
	public SellerService getSellerService() {
		return sellerService;
	}

	/**
	 * 设置 sellerService
	 * @param sellerService sellerService
	 */
	@Resource(name="SellerService")
	public void setSellerService(SellerService sellerService) {
		this.sellerService = sellerService;
	}
	
	@RequestMapping("/loadHead")
	public String loadHead(){
		return "/seller/topFrame";
	}
	
	@RequestMapping("/loadLeft")
	public String loadLeft(HttpServletRequest request){
		Seller seller = (Seller) request.getSession().getAttribute("current_seller");
		Shop shop = seller.getShop();
		request.getSession().setAttribute("shop", shop);
		return "/seller/left";
	}
	
	@RequestMapping("/loadCenter")
	public String loadCenter(HttpServletRequest request){
		Cookie cookie = SingleSignOnUtil.getCookie(request, CommonConstant.WWW_COOKIE_NAME);
		if(cookie != null && cookie.getValue() != null){
			Seller seller = (Seller) request.getSession().getAttribute("current_seller");			
			Shop shop = seller.getShop();
			List<OrderItem> newTradeOrders = sellerService.getSellerOrders(seller.getsellerID(), 10, 15);//状态10代表获取状态为1或者为0的订单
			List<OrderItem> newSuccOrders = sellerService.getSellerOrders(seller.getsellerID(), 34, 10);
			List<OrderItem> viewOrders = sellerService.getSellerOrders(seller.getsellerID(), 4, 10);
			request.getSession().setAttribute("newTradeOrders", newTradeOrders);
			request.getSession().setAttribute("newSuccOrders", newSuccOrders);
			request.getSession().setAttribute("viewOrders", viewOrders);
			request.getSession().setAttribute("seller", seller);
			request.getSession().setAttribute("shop", shop);
		}
		return "/seller/center";
	}
	
	@RequestMapping("/editSellerInfo")
	public String loadSellerInfo(HttpServletRequest request){
		Cookie cookie = SingleSignOnUtil.getCookie(request, CommonConstant.WWW_COOKIE_NAME);
		if(cookie != null && cookie.getValue() != null){
			Seller seller = (Seller) request.getSession().getAttribute("current_seller");
			
			request.getSession().setAttribute("seller", seller);
		}
		return "/seller/editSellerInfo";
	}
	
	@RequestMapping("/loadMyShop")
	public String loadMyShop(HttpServletRequest request){
		//在此写代码，先要获取商家信息，然后找到具体的店铺，最后获取店铺详细内容
		Cookie cookie = SingleSignOnUtil.getCookie(request, CommonConstant.WWW_COOKIE_NAME);
		if(cookie != null && cookie.getValue() != null){
			Seller seller = (Seller) request.getSession().getAttribute("current_seller");
			Shop shop = seller.getShop();
			Iterator<Product> allGoods = seller.getProducts().iterator();
			List<Product> promotionGoods = sellerService.getPromotionGoods(seller.getsellerID());
			List<Product> newGoods = sellerService.getNewGoods(seller.getsellerID());
			List<Product> rankGoods = sellerService.getRanking(seller.getsellerID());
			request.getSession().setAttribute("shop", shop);
			request.getSession().setAttribute("promotionGoods", promotionGoods);
			request.getSession().setAttribute("newGoods", newGoods);
			request.getSession().setAttribute("rankGoods", rankGoods);
			request.getSession().setAttribute("allGoods", allGoods);
			String flag = "2";
			request.getSession().setAttribute("flag", flag);
			
		}
		return "/seller/shop";
	}
	
	@RequestMapping("/loadProductMgr")
	public String loadProductMgr(HttpServletRequest request){
		Seller seller = (Seller) request.getSession().getAttribute("current_seller");
		
		Set<Product> proSet = sellerService.findseller(seller.getsellerID()).getProducts();
		request.setAttribute("proSell", proSet);
		return "/seller/product_mgr";
	}
	
	@RequestMapping("/loadTradeMgr")
	public String loadTradeMgr(HttpServletRequest request){
		Cookie cookie = SingleSignOnUtil.getCookie(request, CommonConstant.WWW_COOKIE_NAME);
		if(cookie != null && cookie.getValue() != null){
			Seller seller = (Seller) request.getSession().getAttribute("current_seller");
			List<OrderItem> orders = sellerService.getAllOrders(seller.getsellerID());
			for(int i=0;i<orders.size();i++){
				System.out.println(orders.get(i).getOrderID());
				System.out.println(orders.get(i).getBuyer().getBuyerName());
			}
			request.setAttribute("orders", orders);
		}
		return "/seller/order_mgr";
	}
	
	@RequestMapping("/loadImgSpace")
	public String loadImgSpace(){
		return "/seller/imgSpace";
	}
	
	@RequestMapping("/toproPage")
	public String loadToproPage(HttpServletRequest request){
		try {
			request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		String pageName = request.getParameter("proType");
		return "/product/" + pageName;
	}
	
	@RequestMapping("/loadSMgr")
	public String loadString(){
		return "/seller/sellerMgr";
	}
	
	@RequestMapping("/loadCourier")
	public String loadCourier(HttpServletRequest request){
		Seller seller = (Seller) request.getSession().getAttribute("current_seller");
		if(seller == null){
			
		}else{
			
		}
		return "/seller/courierMgr";
	}
	
	@RequestMapping("/loadCancelMgr")
	public String loadCancelMgr(HttpServletRequest request){
		Seller seller = (Seller) request.getSession().getAttribute("current_seller");
		if(seller == null){
			
		}else{
			List<OrderItem> cancelApplys = sellerService.getSellerOrders(seller.getsellerID(), 5, 0);
			List<OrderItem> cancelOrders = sellerService.getSellerOrders(seller.getsellerID(), 67, 0);
			request.setAttribute("cancelApplys", cancelApplys);
			request.setAttribute("cancelOrders", cancelOrders);
		}
		return "/seller/cancelMgr";
	}
	
	@RequestMapping("/loadService")
	public String loadService(HttpServletRequest request){
		Seller seller = (Seller) request.getSession().getAttribute("current_seller");
		if(seller == null){
			
		}else{
			List<OrderItem> evaluatedOrders = sellerService.getSellerOrders(seller.getsellerID(), 4, 0);
			List<OrderItem> complaintedOrders = sellerService.getSellerOrders(seller.getsellerID(), -2, 0);
			request.setAttribute("evaluatedOrders", evaluatedOrders);
			request.setAttribute("complaintedOrders", complaintedOrders);
		}
		return "/seller/serviceMgr";
	}
}
