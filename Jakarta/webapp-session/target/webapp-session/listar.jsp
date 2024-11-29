<%@page contentType="UTF-8" import="java.util.*, org.aguzman.apiservlet.webapp.headers.models.*"%>
<%
List<Producto> productos= (List<Producto>)request.getAttribute("productos");
Optional<String> username= (Optional<String>) request.getAttribute("username");
String mensajeRequest = (String) request.getAttribute("mensaje");
String mensajeApp = (String) getServletContext().getAttribute("mensaje");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Listado Productos</title>
</head>
<body>
<h1>Listado Productos</h1>
<% if(username.isPresent()){%>
<div>Hola<%=username.get()%> , bienvenido!</div>
<%}%>
<table>
    <tr>
        <th>id</th>
                <th>nombre</th>
                <th>tipo</th>
                <%if(username.isPresent()){%>
                <th>precio</th>
                <th>agregar</th>
            <%}%>
        </tr>
        <tr>
            <% for(Producto p: productos){%>
                <td><%=p.getId()%></td>
                <td><%=p.getNombre()%></td>
                <td><%=p.getTipo()%></td>
                <%if(username.isPresent()){%>
                <td><%=p.getPrecio()%></td>
                <td><a href="<%=request.getContextPath()%>/carro/agregar?id=<%=p.getId()%>">agregar al carro</a></td>
            <%}%>
        </tr>
        <%}%>
    </table>
<p><%=mensajeApp%></p>
<p><%=mensajeRequest%></p>
</body>
</html>