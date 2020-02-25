package com.huatusoft.electronictag.common.util;

import java.io.IOException;
import java.net.*;
import java.util.Enumeration;

/**
 * @author WangShun
 */
public class NetworkUtils {
	/**
	 * 是否能ping通
	 * @param ip
	 * @return
	 */
	public static boolean isAddressAvailable(String ip){
		boolean isReachable = false;
	    try{
	    	InetAddress address = InetAddress.getByName(ip);//ping this IP
	    	if(address instanceof java.net.Inet4Address){ 
	    		System.out.println(ip + " is ipv4 address");
	    	}else if(address instanceof java.net.Inet6Address){ 
    			System.out.println(ip + " is ipv6 address");
    		}else{ 
    			System.out.println(ip + " is unrecongized");
    		} 
	    	if(address.isReachable(5000)){ 
	    		System.out.println("SUCCESS - ping " + ip + " with no interface specified");
	    		isReachable = true;
	    	}else{ 
	    		System.out.println("FAILURE - ping " + ip + " with no interface specified");
	    	} 
	    	System.out.println("\n-------Trying different interfaces--------\n");
	    	Enumeration<NetworkInterface> netInterfaces =
			        NetworkInterface.getNetworkInterfaces();
	    	while(netInterfaces.hasMoreElements()) {    
	           NetworkInterface ni = netInterfaces.nextElement();
	           System.out.println(
	        		   	"Checking interface, DisplayName:" + ni.getDisplayName() + ", Name:" + ni.getName());
	           if(address.isReachable(ni, 0, 5000)){ 
	        	   System.out.println("SUCCESS - ping " + ip);
	        	   isReachable = true;
			   }else{ 
			       System.out.println("FAILURE - ping " + ip);
			   } 
	           Enumeration<InetAddress> ips = ni.getInetAddresses();
	           while(ips.hasMoreElements()) {    
	        	   System.out.println("IP: " + ips.nextElement().getHostAddress());
	           } 
	           System.out.println("-------------------------------------------");
	    	} 
	       }catch(Exception e){
	        	System.out.println("error occurs.");
	        	e.printStackTrace(); 
	        }       
	    return isReachable;
	 }
	/**
	 * 
	 * @param remoteAddr 远程地址
	 * @param port 端口
	 * @return
	 */
	public static boolean printReachableIP(InetAddress remoteAddr, int port){
		boolean isReachable = false;
	    String retIP = null;
	    Enumeration<NetworkInterface> netInterfaces;
	    try{ 
			netInterfaces = NetworkInterface.getNetworkInterfaces();
			while(netInterfaces.hasMoreElements()) {
			    NetworkInterface ni = netInterfaces.nextElement();
			    Enumeration<InetAddress> localAddrs = ni.getInetAddresses();
			    while(localAddrs.hasMoreElements()){ 
			        InetAddress localAddr = localAddrs.nextElement();
					// 测试是否能连通
			        if(isReachable(localAddr, remoteAddr, port, 5000)){
			           retIP = localAddr.getHostAddress(); 
			           break;        
			         } 
			      } 
			} 
	    } catch(SocketException e) {
	        System.out.println(
	        		"Error occurred while listing all the local network addresses."); 
	    }    
	    if(retIP == null){ 
	        System.out.println("NULL reachable local IP is found!");
	    }else{ 
	        System.out.println("Reachable local IP is found, it is " + retIP);
	        isReachable = true;
	    }
	    return isReachable;
	 } 	
	/**
	  * 
	  * @param url 域名加端口 http://www.baidu.com
	  * @return
	  */
	 public static  boolean isConnect(String url) {
		  HttpURLConnection connection = null;
		  URL urlStr;
		  int state = -1;
		  boolean isReachable = false;
		  int counts = 0;
		  while (counts < 5) {
			  try {
				  urlStr = new URL(url);
				  connection = (HttpURLConnection) urlStr.openConnection();
				  state = connection.getResponseCode();
				  if (state == 200) {
					  isReachable = true;
					  break;
				  }
			  } catch (Exception ex) {
				  counts++;
				  ex.printStackTrace();
				  continue;
			  }finally{
				  if (connection != null) {
					  connection.disconnect();
				  }
			  }
		  }
		  return isReachable;
	  }
	 private static boolean isReachable(InetAddress localInetAddr, InetAddress remoteInetAddr,
                                        int port, int timeout) {
	    boolean isReachable = false; 
	    Socket socket = null;
	    try{ 
	        socket = new Socket();
	        // 端口号设置为 0 表示在本地挑选一个可用端口进行连接
	        SocketAddress localSocketAddr = new InetSocketAddress(localInetAddr, 0);
	        socket.bind(localSocketAddr); 
	        InetSocketAddress endpointSocketAddr =
	        new InetSocketAddress(remoteInetAddr, port);
	        socket.connect(endpointSocketAddr, timeout);        
	        System.out.println("SUCCESS - connection established! Local: " +
	        				localInetAddr.getHostAddress() + " remote: " + 
	        remoteInetAddr.getHostAddress() + " port" + port); 
	        isReachable = true; 
	    } catch(IOException e) {
	    	System.out.println("FAILRE - CAN not connect! Local: " +
			localInetAddr.getHostAddress() + " remote: " + 
			remoteInetAddr.getHostAddress() + " port" + port); 
	    } finally{ 
	        if(socket != null) { 
		        try{ 
		        	socket.close(); 
		        } catch(IOException e) {
		           System.out.println("Error occurred while closing socket..");
		        } 
	        } 
	    } 
	    return isReachable; 
	 }
}
