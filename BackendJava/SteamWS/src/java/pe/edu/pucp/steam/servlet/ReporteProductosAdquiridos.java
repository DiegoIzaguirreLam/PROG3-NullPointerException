/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package pe.edu.pucp.steam.servlet;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.awt.Image;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.util.JRLoader;
import java.sql.Connection;
import java.util.HashMap;
import javax.swing.ImageIcon;
import net.sf.jasperreports.engine.JRException;
import pe.edu.pucp.steam.dbmanager.config.DBManager;


public class ReporteProductosAdquiridos extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Connection con = DBManager.getInstance().getConnection();
            String rutaReporte = ReporteProductosAdquiridos.class.getResource("/pe/edu/pucp/steam/reportes/ReporteProductosAdquiridos.jasper").getPath();
            rutaReporte = rutaReporte.replace("%20", " ");
            JasperReport jr = (JasperReport) JRLoader.loadObjectFromFile(rutaReporte);
            String rutaSubreporteGrafico = ReporteProductosAdquiridos.class.getResource("/pe/edu/pucp/steam/reportes/SubReporteGraficoTiempoUso.jasper").getPath();
            rutaSubreporteGrafico = rutaSubreporteGrafico.replace("%20", " ");
            String rutaSubreporteProductosAdquiridos = ReporteProductosAdquiridos.class.getResource("/pe/edu/pucp/steam/reportes/SubReporteProductosAdquiridos.jasper").getPath();
            rutaSubreporteProductosAdquiridos = rutaSubreporteProductosAdquiridos.replace("%20", " ");
            String rutaLogo = ReporteProductosAdquiridos.class.getResource("/pe/edu/pucp/steam/img/logo_web.jpg").getPath();
            rutaLogo = rutaLogo.replace("%20", " ");
            Image logo = (new ImageIcon(rutaLogo)).getImage();
            String rutaFooter = ReporteProductosAdquiridos.class.getResource("/pe/edu/pucp/steam/img/volba_footer.jpg").getPath();
            rutaFooter = rutaFooter.replace("%20", " ");
            Image footer = (new ImageIcon(rutaFooter)).getImage();
            
            HashMap hm = new HashMap();
            hm.put("uid_usuario", 45);
            hm.put("usuario", "Diego");
            hm.put("moneda_simbolo", "S/.");
            hm.put("moneda_cambio_dolares", 3.72);
            hm.put("SubReporteGrafico", rutaSubreporteGrafico);
            hm.put("SubReporteProductos", rutaSubreporteProductosAdquiridos);
            hm.put("imagenLogo", logo);
            hm.put("imagenFooter", footer);
            JasperPrint jp = JasperFillManager.fillReport(jr, hm, con);
            JasperExportManager.exportReportToPdfStream(jp, response.getOutputStream());
        } catch (IOException | JRException ex) {
            System.out.println(ex.getMessage());
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
