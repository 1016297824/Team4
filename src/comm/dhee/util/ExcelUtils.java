package comm.dhee.util;

import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Map;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.Workbook;

import net.sf.jxls.transformer.XLSTransformer;

public class ExcelUtils {

	public static void exportToExcel(HttpServletRequest request, HttpServletResponse response, String outFileName,
			String tplFileName, Map<String, Object> bean) throws IOException {
		String outFile;
		String tplFile;

		outFile = ExcelUtils.processFileName(request, outFileName);
		tplFile = request.getServletContext().getRealPath("/") + CONTANTS.TEMPLATEFILES + tplFileName;

		response.setHeader("Cache-Control", "private");
		response.setHeader("Pragma", "private");
		response.setContentType("application/vnd.ms-excel; charset=utf-8");
		response.setHeader("Content-Type", "application/force-download");

		response.setHeader("Content-disposition", "attachment;filename=\"" + outFile + "\"");
		XLSTransformer transformer = new XLSTransformer();

		InputStream is = new BufferedInputStream(new FileInputStream(tplFile));
		Workbook workbook = null;
		try {
			workbook = transformer.transformXLS(is, bean);
		} catch (InvalidFormatException e) {
			e.printStackTrace();
		}
		ServletOutputStream out = response.getOutputStream();
		workbook.write(out);
		is.close();
		out.flush();
		out.close();
	}

	private static String processFileName(HttpServletRequest request, String fileNames) {
		String codedfilename = null;
		try {
			String agent = request.getHeader("USER-AGENT");
			if (null != agent && -1 != agent.indexOf("MSIE") || null != agent && -1 != agent.indexOf("Trident")) {// ie
				String name = java.net.URLEncoder.encode(fileNames, "UTF8");
				codedfilename = name;
			} else if (null != agent && -1 != agent.indexOf("Mozilla")) {
				codedfilename = new String(fileNames.getBytes("UTF-8"), "iso-8859-1");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return codedfilename;
	}
}
