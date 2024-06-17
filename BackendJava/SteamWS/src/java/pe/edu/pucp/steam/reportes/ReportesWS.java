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
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.util.JRLoader;
import pe.edu.pucp.steam.dbmanager.config.DBManager;
import pe.edu.pucp.steam.servlet.ReporteProductosAdquiridos;


@WebService(serviceName = "ReportesWS")
public class ReportesWS {

    /**
     * This is a sample web service operation
     */
    @WebMethod(operationName = "generarReporteProductosAdquiridos")
    public byte[] generarReporteProductosAdquiridos(@WebParam(name = "idBiblioteca") int idBiblioteca, @WebParam(name = "nombreCuenta") String nombreCuenta,
            @WebParam(name = "monedaSimbolo") String monedaSimbolo, @WebParam(name = "monedaCambioDolares") double monedaCambioDolares) {
        byte[] reporte = null;
        try {
            Connection con = DBManager.getInstance().getConnection();
            String rutaReporte = ReporteProductosAdquiridos.class.getResource("/pe/edu/pucp/steam/reportes/ReporteProductosAdquiridos.jasper").getPath();
            rutaReporte = rutaReporte.replace("%20", " ");
            JasperReport jr = (JasperReport) JRLoader.loadObjectFromFile(rutaReporte);
            String rutaSubreporteGrafico = ReporteProductosAdquiridos.class.getResource("/pe/edu/pucp/steam/reportes/SubReporteGraficoTiempoUso.jasper").getPath();
            rutaSubreporteGrafico = rutaSubreporteGrafico.replace("%20", " ");
            HashMap hm = new HashMap();
            hm.put("idBiblioteca", idBiblioteca);
            hm.put("usuario", nombreCuenta);
            hm.put("moneda_simbolo", monedaSimbolo);
            hm.put("moneda_cambio_dolares", monedaCambioDolares);
            hm.put("SubReporteGrafico", rutaSubreporteGrafico);
            JasperPrint jp = JasperFillManager.fillReport(jr, hm, con);
            reporte = JasperExportManager.exportReportToPdf(jp);
        }catch(JRException ex){
            System.out.println(ex.getMessage());
        }
        return reporte;
    }
}
