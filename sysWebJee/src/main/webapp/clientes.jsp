<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<%!// Declarando variáveis de conexão, instrução SQL e resultado
	Connection conexao = null;
	Statement instrucao = null;
	ResultSet resultado = null;

	// Declarando variáveis para ordenação e ação
	String ordem, acao;

	// Definindo informações de acesso ao banco de dados
	String user = "postgres";
	String pass = "1993";
	String port = "5432";
	String host = "localhost";
	String url = "jdbc:postgresql://" + host + ":" + port + "/sisWebJee";%>

<!DOCTYPE html>

<%
try {
	// Carregando o driver JDBC do PostgreSQL
	Class.forName("org.postgresql.Driver");
	// Estabelecendo uma conexão com o banco de dados
	conexao = DriverManager
	.getConnection("jdbc:postgresql://localhost/sisWebJee?user=postgres&password=1993&ssl=false");

	/*
	Criando uma instrução SQL com configurações específicas para suporte a rolagem sensível do ResultSet
	e capacidade de atualização dos registros
	
	ResultSet.TYPE_SCROLL_SENSITIVE: Isso indica que o ResultSet é sensível a alterações no banco de dados.
	Isso significa que se os dados subjacentes forem modificados por outra fonte após a criação do ResultSet,
	essas mudanças serão refletidas no ResultSet.
	Métodos "next()" para avançar para a próxima linha e "isLast()" para verificar se você está na última linha.
	Métodos "previous()" para mover para a linha anterior e "isFirst()" para verificar se você está na primeira linha.
	
	ResultSet.CONCUR_UPDATABLE: Isso indica que o ResultSet permite atualizações dos registros.
	Com essa configuração, você pode modificar os valores dos campos de um registro através do ResultSet e,
	posteriormente, aplicar essas mudanças no banco de dados.
	*/

	instrucao = conexao.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

	// Obtendo ação do parâmetro da solicitação
	acao = request.getParameter("acao");
	if (acao == null) {
		acao = "listar"; // Ação padrão é "listar"
	}

	// Se ação for "excluir", remove um cliente do banco
//@formatter:off 
	if (acao.equals("excluir")) {
		instrucao.executeUpdate("DELETE FROM cliente WHERE codigo = " + request.getParameter("codigo"));
	}else if (acao.equals("gravar")) {
	    String sql = "INSERT INTO cliente("
	            + "nome,endereco,numero,complemento,bairro,cidade,estado,"
	            + "rg,cpf,telfixo,telcel,email,genero,datanasc,datacad,obs"
	            + ") VALUES ('"
	            + request.getParameter("nome").toUpperCase() + "', '"
	            + request.getParameter("endereco")			 + "', '"
	            + request.getParameter("numero")			 + "', '"
	            + request.getParameter("complemento") 		 + "', '"
	            + request.getParameter("bairro") 			 + "', '"
	            + request.getParameter("cidade")			 + "', '"
	            + request.getParameter("estado")			 + "', '"
	            + request.getParameter("rg") 				 + "', '"
	            + request.getParameter("cpf") 				 + "', '"
	            + request.getParameter("telfixo") 			 + "', '"
	            + request.getParameter("telcel") 			 + "', '"
	            + request.getParameter("email") 		     + "', '"
	            + request.getParameter("genero") 			 + "', '"
	            + request.getParameter("datanasc") 			 + "', '"
	            + request.getParameter("datacad") 			 + "', '"
	            + request.getParameter("obs").trim() 		 + "')";

	        instrucao.executeUpdate(sql);
	    }


	// Obtendo ordem da ordenação a partir do parâmetro da solicitação
	ordem = request.getParameter("ordem");
	if (ordem == null) {
		ordem = "codigo"; // Ordem padrão é "codigo"
	}

	// Executando consulta SQL para obter dados dos clientes
	resultado = instrucao.executeQuery("SELECT * FROM cliente ORDER BY " + ordem);
%>
<html>
<head>
<meta charset="UTF-8">
<title>Cadastro de Clientes</title>
<style>
.center {
	text-align: center;
}

.container {
	display: flex;
	justify-content: center;
	align-items: center;
}
</style>
</head>
<body>
	<h1 class="center">Sistema de Cadastro de Clientes</h1>
	<p class="center">
		<%
		int maiorCodigo = Integer.MIN_VALUE;
		// Itera pelos resultados da tabela para encontrar o maior valor possível do campo "codigo"
		while (resultado.next()) {
			int codigoAtual = resultado.getInt("codigo");
			// Verifica se o valor atual de "codigo" é maior que o maior valor encontrado até o momento
			if (codigoAtual > maiorCodigo) {
				// Atualiza o valor de 'maiorCodigo' com o novo valor se ele for maior
				maiorCodigo = codigoAtual;
			}
		}
		%>
		<a href="clientesCadastrar.jsp?codigoNovo=<%=maiorCodigo + 1%>">[Cadastrar]</a>

		<%
		// Move o cursor de resultados de volta para antes do primeiro resultado
		// Isso permite que os resultados sejam percorridos novamente desde o início, se necessário
		resultado.beforeFirst();
		%>


		| <a href="clientesImprimir.jsp">[Imprimir]</a>
	</p>
	<section class="container">
		<table border="1">
			<thead>
				<tr>
					<th><a href="clientes.jsp?ordem=codigo">codigo</a></th>
					<th><a href="clientes.jsp?ordem=nome">nome</a></th>
					<th>CPF</th>
					<th>Email</th>
					<th>Opções</th>
				</tr>
			</thead>
			<tbody>
			    <%
			    int cont = 0;
			    // Loop para exibir os dados dos clientes
			    while (resultado.next()) {
			    %>
			    <tr>
			        <!-- Exibindo os dados do cliente -->
			        <td><%= resultado.getInt("codigo") %></td>
			        <td><%= resultado.getString("nome") %></td>
			        <td><%= resultado.getString("cpf") %></td>
			        <td><a href="mailto:<%= resultado.getString("email") %>"><%= resultado.getString("email") %></a></td>
			        <td>
			            <a href="javascript:confirma('<%= resultado.getInt("codigo") %>','excluir','Confirmar Exclusão!','clientes.jsp')">[Excluir]</a>
			            <a href="clientesAlterar.jsp?codigo=<%= resultado.getInt("codigo") %>">[Alterar]</a>
			        </td>
			    </tr>
			    <%
			    cont++;
			    }
			    %>
			</tbody>
			<tfoot>
				<tr>
					<!-- Exibindo a quantidade de clientes cadastrados -->
					<td colspan="5">Quantidade de Clientes cadastrados é: <%=cont%></td>
				</tr>
			</tfoot>
		</table>
	</section>
	<footer>
		<p class="center">
			<b>copyright &copy; 2023 - sisWebJee</b>
		</p>
	</footer>
</body>
</html>
<%
} catch (ClassNotFoundException ce) {
out.println("Não foi possível encontrar o driver Postgre! " + ce);
} catch (SQLException se) {
out.println("Erro ao trabalhar com o banco de dados! " + se);
} finally {
// Fechando recursos (resultado, instrução e conexão)
if (resultado != null) {
	resultado.close();
}
if (instrucao != null) {
	instrucao.close();
}
if (conexao != null) {
	conexao.close();
}
}
%>
