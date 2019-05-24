package be.afelio.pco;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.Date;
import java.util.Locale;
import java.text.DateFormat;

public class Day extends HttpServlet {
	
	private final Locale DEFAULT_LOCALE = Locale.ENGLISH;
	// private Locale savedLocale;
	
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
		throws ServletException, IOException {
		
		Locale usedLocale = DEFAULT_LOCALE;
		
		String chosenLanguage = req.getParameter("language");
		if (chosenLanguage != null) {
			try {
				usedLocale = new Locale(chosenLanguage);
				// savedLocale = usedLocale;
				HttpSession session = req.getSession();
				session.setAttribute("persistedLocale", usedLocale);
			} catch(Exception e) {
				e.printStackTrace();
			}
		} else {
			HttpSession session = req.getSession();
			Locale savedLocale = (Locale) session.getAttribute("persistedLocale");
			if (savedLocale != null) {
				usedLocale = savedLocale;
			}
		}
		
		Date today = new Date();
		DateFormat dateFormat = DateFormat.getDateInstance(
			DateFormat.FULL, usedLocale);
		String formatedDate = dateFormat.format(today);
		
		resp.setContentType("text/plain");
		
		PrintWriter writer = resp.getWriter();
		writer.write(formatedDate);
	}
}






