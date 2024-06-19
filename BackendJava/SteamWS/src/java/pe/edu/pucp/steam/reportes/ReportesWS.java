/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/WebServices/WebService.java to edit this template
 */
package pe.edu.pucp.steam.reportes;

import jakarta.jws.WebService;
import jakarta.jws.WebMethod;
import jakarta.jws.WebParam;
import java.awt.Image;
import java.sql.Connection;
import java.util.HashMap;
import javax.swing.ImageIcon;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.util.JRLoader;
import pe.edu.pucp.steam.dbmanager.config.DBManager;
import pe.edu.pucp.steam.servlet.ReporteMensajesEnviados;
import pe.edu.pucp.steam.servlet.ReporteProductosAdquiridos;


@WebService(serviceName = "ReportesWS", targetNamespace="http://services.softprog.pucp.edu.pe/")
public class ReportesWS {

    /**
     * This is a sample web service operation
     */
    @WebMethod(operationName = "generarReporteProductosAdquiridos")
    public byte[] generarReporteProductosAdquiridos(@WebParam(name = "uid") int uid, @WebParam(name = "nombreCuenta") String nombreCuenta,
            @WebParam(name = "monedaSimbolo") String monedaSimbolo, @WebParam(name = "monedaCambioDolares") double monedaCambioDolares) {
        byte[] reporte = null;
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
            hm.put("uid_usuario", uid);
            hm.put("usuario", nombreCuenta);
            hm.put("moneda_simbolo", monedaSimbolo);
            hm.put("moneda_cambio_dolares", monedaCambioDolares);
            hm.put("SubReporteGrafico", rutaSubreporteGrafico);
            hm.put("SubReporteProductos", rutaSubreporteProductosAdquiridos);
            hm.put("imagenLogo", logo);
            hm.put("imagenFooter", footer);
            JasperPrint jp = JasperFillManager.fillReport(jr, hm, con);
            reporte = JasperExportManager.exportReportToPdf(jp);
        }catch(JRException ex){
            System.out.println(ex.getMessage());
        }
        return reporte;
    }
    
    @WebMethod(operationName = "generarReporteMensajesEnviados")
    public byte[] generarReporteMensajesEnviados(@WebParam(name = "uid") int uid, @WebParam(name = "nombreCuenta") String nombreCuenta) {
        byte[] reporte = null;
        try {
            Connection con = DBManager.getInstance().getConnection();
            String rutaReporte = ReporteMensajesEnviados.class.getResource("/pe/edu/pucp/steam/reportes/ReporteMensajes.jasper").getPath();
            rutaReporte = rutaReporte.replace("%20", " ");
            JasperReport jr = (JasperReport) JRLoader.loadObjectFromFile(rutaReporte);
            HashMap hm = new HashMap();
            hm.put("uid_usuario", Integer.toString(uid));
            hm.put("usuario", nombreCuenta);
            JasperPrint jp = JasperFillManager.fillReport(jr, hm, con);
            reporte = JasperExportManager.exportReportToPdf(jp);
        }catch(JRException ex){
            System.out.println(ex.getMessage());
        }
        return reporte;
    }
}
