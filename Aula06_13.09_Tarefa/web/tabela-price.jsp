<%-- 
    Document   : tabela-price.jsp
    Created on : 13 de set. de 2021, 20:25:29
    Author     : isabela
--%>

<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%
double saldoDevedor = 0;
double juros = 0;
double jurosB = 0;
double jurosC = 0;
double potenA = 0;
double potenB = 0;
double parcela = 0;
double parcelaB = 0;
double devedor = 0;
int periodo = 0;
String error = null;
NumberFormat formatMoney = NumberFormat.getCurrencyInstance(new Locale("pt", "BR"));
if(request.getParameter("saldoDevedor") != null) {
    try {    
    saldoDevedor = Double.parseDouble(request.getParameter("saldoDevedor"));
    juros = Double.parseDouble(request.getParameter("juros"));
    periodo = Integer.parseInt(request.getParameter("meses"));
    jurosB = juros / 100;
    potenA = Math.pow((1 + jurosB), periodo) * jurosB;
    potenB = Math.pow((1 + jurosB), periodo) - 1;
    parcela = saldoDevedor * (potenA / potenB);
    devedor = (saldoDevedor - parcela);
    jurosC = saldoDevedor * jurosB;
    parcelaB = saldoDevedor - devedor;
    } catch(Exception e) {
        error = "Erro ao calcular, verifique e tente novamente.";
    }
}
%>

<html>
<head>
<title>Tabela Price</title>
</head>
<body>
	<%@include file="WEB-INF/jspf/header.jspf"%>
        <div style="text-align:center; margin-top: 40px">
            <h3 style="margin-bottom:20px">Tabela Price</h3>
         <form action ="tabela-price.jsp">  
            <label>Período</label>
            <input type="number" name="meses" value="1" required/>
            <br>
            <br>
            <label>Saldo devedor</label>
            <input type="number" name="saldoDevedor" value="1" required/>
            <br>
            <br>
            <label>Juros</label>
            <input type="number" name="juros" value="1" required/>
            <br>
            <br>            
            <br>
            <button type="submit" class="btn btn-dark" style="margin-bottom: 20px">Calcular</button>           
          </form> 
	<h5>Saldo devedor: <%=(formatMoney.format(saldoDevedor))%></h5>
	<h5>Juros: <%=juros%>%</h5>
	<h5>Período: <%=periodo%> meses</h5>
	<br>
	<br>        
       <% try { %>
        <table class="table">
        <thead>
                <tr>
                <th scope="col">Período</th>
                <th scope="col">Saldo Devedor</th>
                <th scope="col">Parcela</th>
                <th scope="col">Juros</th>
                <th scope="col">Amortização</th>
                </tr>
        </thead>
        <tbody>
                <tr>
                <th scope="row">0</th>
                <td><%=(formatMoney.format(saldoDevedor))%></td>
                <td></td>
                <td></td>
                <td></td>
                </tr>
                <tr>

                <%
                for (int j = 1; j <= periodo+2; j++) {
                %>
                <% saldoDevedor = (saldoDevedor + jurosC) - parcelaB;%>
                <th scope="row"><%=j%></th>
                <td><%=(formatMoney.format(saldoDevedor))%></td>
                <td><%=(formatMoney.format(parcelaB))%></td>
                <td><%=(formatMoney.format(jurosC))%></td>
                <td><%=(formatMoney.format(parcelaB - jurosC))%></td>
                <% jurosC = saldoDevedor * jurosB; %>
                </tr>
                <% devedor = saldoDevedor; %>
                <%devedor = saldoDevedor - parcela;%>
                <% };  %> 
		</tbody>
	</table>
       <% } catch (Exception e) { %>
            
       <p> <%= error %> </p>
        
       <% } %>
   </div>
	<%@include file="WEB-INF/jspf/footer.jspf"%>
</body>
</html>