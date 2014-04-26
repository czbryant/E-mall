package ustc.sse.water.web.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;


import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import ustc.sse.water.pojo.Addr;
import ustc.sse.water.pojo.BasketItem;
import ustc.sse.water.pojo.Buyer;
import ustc.sse.water.pojo.Favorites;
import ustc.sse.water.pojo.OrderItem;
import ustc.sse.water.pojo.Product;
import ustc.sse.water.pojo.Shop;
import ustc.sse.water.service.BuyerService;
import ustc.sse.water.service.ProductService;

@Controller
@RequestMapping("/BMgrLoader")
public class BMgrLoader {
	@Resource(name="BuyerService")
	protected BuyerService buyerService;
	
	@Resource(name="ProductService")
	protected ProductService productService;
	
	@RequestMapping("/loadHead")
	public String loadHead(){
		return "/buyer/topFrame";
	}
	
	@RequestMapping("/loadLeft")
	public String loadLeft(HttpServletRequest request){
		Buyer buyer = (Buyer) request.getSession().getAttribute("current_user");
		int complaintCounts, evaluateCounts, arriveCounts;
		complaintCounts = buyerService.countComplaint(buyer);
		evaluateCounts  = buyerService.countEval(buyer);
		arriveCounts    = buyerService.countArrive(buyer);
		request.setAttribute("arriveCounts", arriveCounts);
		request.setAttribute("comCounts", complaintCounts);
		request.setAttribute("evaCounts", evaluateCounts);
		return "/buyer/left";
	}
	
	@RequestMapping("/loadInfoChange")
	public String loadInfoChange(){
		return "/buyer/info_change";
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping("/loadCenter")
	public String loadCenter(HttpServletRequest request){
		Buyer buyer = (Buyer) request.getSession().getAttribute("current_user");
		Buyer nbuyer = buyerService.findBuyerById(buyer.getBuyerID());
		
		List<Product> recentviewProducts = productService.getRecentViewProducts(request);
		request.setAttribute("recentView", recentviewProducts);
		
		List<OrderItem> recentBuyList = buyerService.getRecentBuy(nbuyer);
		request.setAttribute("recentBuyList", recentBuyList);
		
		List<BasketItem> proList = new ArrayList<BasketItem>();
		List<Product> shops = (List<Product>) request.getSession().getAttribute("collectShops");
		List<OrderItem> orders = (List<OrderItem>) request.getSession().getAttribute("recentlyOrders");
		if(buyer.getBasket() != null) {
			int i = 0;
			for (BasketItem item : nbuyer.getBasket()) {
				if(i < 3){
					proList.add(item);
					i++;
				} else {
					break;
				}
			}
			request.setAttribute("buyerSmallCart", proList);
		}
		if(shops == null) {
			shops = new ArrayList<Product>();
			for (Favorites favorite : buyerService.getFavorites(nbuyer)) {
				if(favorite.getProductOrShop() == 1) {
					shops.add(favorite.getProduct());
				}
				if(shops.size()>=3){
					break;
				}
			}
			request.setAttribute("collections", shops);
		}
		if(orders == null) {
			
		}
		return "/buyer/center";
	}
	
	@RequestMapping("loadArrive")
	public String loadArrive(HttpServletRequest request) {
		Buyer buyer = (Buyer) request.getSession().getAttribute("current_user");
		List<OrderItem> items = buyerService.getConfirmArriveOrders(buyer);
		request.setAttribute("confirmitems", items);
		return "/buyer/confirm";
	}
	
	@RequestMapping("/loadOrder")
	public String loadOrder(HttpServletRequest request){
		Buyer buyer = (Buyer) request.getSession().getAttribute("current_user");
		buyer = buyerService.findBuyerById(buyer.getBuyerID());
		Set<OrderItem> orderSet = productService.getNoPayOrders(buyer);
		request.setAttribute("noPayOders", orderSet);
		return "/buyer/order_page";
	}
	
	@RequestMapping("/loadAlreadyBuy")
	public String loadAlready(){
		return "/buyer/already_buy";
	}
	
	@RequestMapping("/loadPerINF")
	public String loadPerINF(HttpServletRequest request){
		Buyer buyer = (Buyer) request.getSession().getAttribute("current_user");
		request.setAttribute("buyer", buyer);
		return "/buyer/personal_info";
	}
	
	@RequestMapping("/loadAddr")
	public String loadAddr(HttpServletRequest request){
		Buyer buyer = (Buyer) request.getSession().getAttribute("current_user");
		if(buyer != null){
		Set<Addr> addrs = buyerService.findBuyerById(buyer.getBuyerID()).getAddrs();
		request.setAttribute("addrs", addrs);
		}
		return "/buyer/address";
	}
	
	@RequestMapping("/loadSecurity")
	public String loadMainPage(){
		return "/buyer/security_center";
	}
	
	@RequestMapping("/loadComplaint")
	public String loadComp(HttpServletRequest request) {
		return "/buyer/complaint";
	}
	
	@RequestMapping("/loadAssess")
	public String loadAssess(HttpServletRequest request) {
		Buyer buyer = (Buyer) request.getSession().getAttribute("current_user");
		List<OrderItem> orders = buyerService.getAssessOrders(buyer);
		request.setAttribute("orders", orders);
		return "/buyer/assess";
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
		}
		return "/buyer/collection";
	}
	
	@RequestMapping("/delFromFavorites")
	@ResponseBody
	public String delFromFavorites(HttpServletRequest request, HttpServletResponse response, String itemId) {
		
		/*Buyer buyer = (Buyer) request.getSession().getAttribute("current_user");
		
		List<Favorites> favorites =  buyerService.getFavorites(buyer);
		for (Favorites item : favorites) {
			boolean a = itemId.equals(Long.toString(item.getId()));
			if(a){
				buyerService.deleteFavorite(item);
				break;
			}
		}*/
		buyerService.deleteFavorite(Long.parseLong(itemId));
		
		return "1";
	}
	
	@RequestMapping("/deleteFavoritess")
	@ResponseBody
	public String deleteFavoritess(HttpServletRequest request, HttpServletResponse response, String select) {
		
		String string = select.substring(0,select.length()-1);
		String[] selected = string.split(",");
		if(selected != null) {
			for (String item : selected) {
				buyerService.deleteFavorite(Long.parseLong(item));
			}
		}
		
		return "1";
	}
	
	
	@RequestMapping("/addFavorites")
	@ResponseBody
	public String addFavorites(HttpServletRequest request, HttpServletResponse response, String fid, String ftype) {
		
		Buyer buyer = (Buyer) request.getSession().getAttribute("current_user");
		if(buyer==null){
			return "0";
		}else{
			List<Favorites> favoritess =  buyerService.getFavorites(buyer);
			if (favoritess != null)
				for (Favorites item : favoritess) {
					if(ftype.equals(item.getProductOrShop()+"")){
						if(ftype.equals("1")  &&  fid.equals(item.getProduct().getProductId()))
							return "2";
						else  if ( ftype.equals("0")  &&  fid.equals(item.getShop().getShopId()))
							return "2";
					}
					
				}
			
			Favorites favorites = new Favorites();
			favorites.setBuyer(buyer);
			buyerService.addFavorite(favorites , fid, ftype);
			return "1";
		}
	}
	
}
