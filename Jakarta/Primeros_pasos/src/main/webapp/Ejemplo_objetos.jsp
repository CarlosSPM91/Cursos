<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Ejemplo objetos</title>
</head>
<body>
<h2> Objetos predefinidos JSP</h2>

Peticion datos del navegador: <%= request.getHeader("User-Agent") %>
<br> <br>

Peticion idioma utilizado: <%= request.getLocale() %>

</body>
</html>