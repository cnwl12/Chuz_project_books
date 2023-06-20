import java.net.URLDecoder;

import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

public class XmlParsingClass{
	
	// tag 정보 가져오는 메서드 
	public static String getTagValue(String tag, Element eElement) {
		NodeList nlList = eElement.getElementsByTagName(tag).item(0).getChildNodes();
		Node nValue = (Node)nlList.item(0);
		
		if(nValue == null) {
			return null;
		}
		return nValue.getNodeValue();
	}
	
	public void search() {
		
		try {
			// parsing할 url 지정 
			String url = "https://www.nl.go.kr/seoji/SearchApi.do";
			String cert_key = "ac7d1bc365859ebd1c00acc4e5576dd7a36ead8e4b842c850ff72b99b5aa8570";
			String result_style = ""; //결과형식
			String author = ""; // 저자
			String isbn = ""; // isbn
			String decodeCert_key = URLDecoder.decode(cert_key, "UTF-8"); // 한글 변환
			String title = ""; // 본표제
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
}
	
	

