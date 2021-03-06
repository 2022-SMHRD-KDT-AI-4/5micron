package xe.smhrd.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import xe.smhrd.model.InviteDAO;
import xe.smhrd.model.InviteVO;

@WebServlet("/MyResultService")
public class MyResultService extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		request.setCharacterEncoding("UTF-8");
		int v_id = Integer.parseInt(request.getParameter("v_id"));
		
		InviteDAO dao = new InviteDAO();
		InviteVO vo = dao.selectMyOne(v_id);
		List<InviteVO> list = dao.selectResultItem(v_id);	// id값 1 이상인 리스트만 출력
		
		session.setAttribute("myvo", vo);
		session.setAttribute("myitemlist", list);
		RequestDispatcher rd = request.getRequestDispatcher("MyPartyResult.jsp");
		rd.forward(request, response);
		
	}

}
