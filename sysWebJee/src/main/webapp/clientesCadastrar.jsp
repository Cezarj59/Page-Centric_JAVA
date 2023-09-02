<%@ page import="java.util.Date, java.text.SimpleDateFormat, java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<%!//Declarando variáveis de conexão, instrução SQL e resultado
	Connection conexao = null;
	Statement instrucao = null;
	ResultSet resultado = null;

	Date data = new Date();
	SimpleDateFormat dataFormatada = new SimpleDateFormat("dd-MM-yyyy");
	String codigoNovo, hoje;%>


<!DOCTYPE html>
<%
try {
	// Carregando o driver JDBC do PostgreSQL	
	Class.forName("org.postgresql.Driver");

	// Estabelecendo uma conexão com o banco de dados
	conexao = DriverManager
	.getConnection("jdbc:postgresql://localhost/sisWebJee?user=postgres&password=1993&ssl=false");

	//	Criando uma instrução SQL com configurações específicas para suporte a rolagem sensível do ResultSet
	//e capacidade de atualização dos registros

	instrucao = conexao.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

	codigoNovo = request.getParameter("codigoNovo");
	if (codigoNovo == null)
		codigoNovo = "0";
	hoje = dataFormatada.format(data);
%>
<html>
<head>
<script  src="util/funcoes.js"></script>
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
	<p class="center">
		<b>Sistema de Cadastro de Clientes</b><br> <font
			style="color: dodgerblue">Cadastrar novo Cliente</font>

	</p>
	<section class="container">
		<form id="form-cadastrar-clientes" name="formCadastrar" method="post"
			action="clientes.jsp?acao=gravar">
			<!-- // @formatter:off -->
			<p>
				<label for="input-codigo">Código.:</label> 
				<input id="input-codigo" name="codigo" type="text" value="<%=codigoNovo%>" disabled /> 
					-
				<label for="input-datatela">Data de Cadastro.: (dd-MM-aaaa)</label>
				<input id="input-datatela" name="datatela" type="text" value="<%=hoje%>" disabled size="10" maxlength="10" /> 
				<input type="hidden" name="datacad" value="<%=data%>">
			</p>
			<!-- // @formatter:on -->
			<p>
				<label for="input-nome">Nome.:</label> <input id="input-nome"
					name="nome" type="text" size="40" maxlength="40" />
			</p>

			<p>
				<label for="input-endereco">Endereço.:</label> <select
					name="endereco">
					<%
					ResultSet resultadoEndereco = instrucao.executeQuery("SELECT * FROM endereco ORDER BY nome");

					if (resultadoEndereco != null)
						while (resultadoEndereco.next()) {
					%>
					<option value="<%=resultadoEndereco.getInt("codigo")%>">
						<%=resultadoEndereco.getString("nome")%>
					</option>
					<%
					}

					if (resultadoEndereco != null) {
					resultadoEndereco.close();
					}
					%>
				</select>
			</p>

			<p>
				<label for="input-numero">Numero.:</label> <input id="input-numero"
					name="numero" type="text" size="4" maxlength="4" /> - <label
					for="input-complemento">Complemento.:</label> <input
					id="input-complemento" name="complemento" type="text" size="10"
					maxlength="10" />
			</p>

			<p>
			
			
				<label for="input-bairro">Bairro.:</label>
			
				 <select name="bairro">
							<%
					ResultSet resultadoBairro = instrucao.executeQuery("SELECT * FROM bairro ORDER BY nome");

					if (resultadoBairro != null)
						while (resultadoBairro.next()) {
					%>
					<option value="<%=resultadoBairro.getInt("codigo")%>">
						<%=resultadoBairro.getString("nome")%>
					</option>
					<%
					}

					if (resultadoBairro != null) {
					resultadoBairro.close();
					}
					%>
				</select>
			
			
				<label for="input-cidade">Cidade.:</label>
				
				 <select name="cidade">
				 <%
					ResultSet resultadoCidade = instrucao.executeQuery("SELECT * FROM cidade ORDER BY nome");

					if (resultadoCidade != null)
						while (resultadoCidade.next()) {
					%>
					<option value="<%=resultadoCidade.getInt("codigo")%>">
						<%=resultadoCidade.getString("nome")%>
					</option>
					<%
					}

					if (resultadoCidade != null) {
					resultadoCidade.close();
					}
					%>
				</select>
			
				<label for="input-estado">Estado.:</label> 
				
				<select name="estado">
				<%
					ResultSet resultadoEstado = instrucao.executeQuery("SELECT * FROM estado ORDER BY nome");

					if (resultadoEstado != null)
						while (resultadoEstado.next()) {
					%>
					<option value="<%=resultadoEstado.getInt("codigo")%>">
						<%=resultadoEstado.getString("nome")%>
					</option>
					<%
					}

					if (resultadoEstado != null) {
					resultadoEstado.close();
					}
					%>
				</select>
						
			</p>

			<p>
				<label for="input-rg">RG.:</label> 
				<input id="input-rg" name="rg" type="text" size="12" maxlength="12"
				  onkeypress="mascaraCampo(this, '##.###.###-#'); return somenteNumero(event);"/>
				- 
				<label for="input-cpf">CPF.:</label>
				<input id="input-cpf" name="cpf" type="text" size="14" maxlength="14"
				 onkeypress="mascaraCampo(this, '###.###.###-##'); return somenteNumero(event);"/>

			</p>

			<p>
				<label for="input-telfixo">TelFixo.:</label> 
				<input id="input-telfixo" name="telfixo" type="text" size="12" maxlength="12" placeholder="(DDD) 0000-0000"
				onkeypress="mascaraCampo(this, '##-####-####'); return somenteNumero(event);"/> 
					-
				<label for="input-telcel">TelCelular.:</label>
				<input id="input-telcel" name="telcel" type="text" size="13" maxlength="13" placeholder="(DDD) 90000-0000"
				onkeypress="mascaraCampo(this, '##-#####-####'); return somenteNumero(event);"/>
			</p>
			<p>
				<label for="input-email">E-mail.:</label> <input id="input-email"
					name="email" type="text" size="50" maxlength="50" />
			</p>
			<p>
				<label for="input-genero">Genero.:</label>
				 	<input type="radio" name="genero" id="genero_M" value="M" checked="checked">Masculino
				 	<input type="radio" name="genero" id="genero_F" value="F">Feminino
				- 
				<label for="input-datanasc">Data de Nascimento.:</label> 
				<input id="input-datanasc" name="datanasc" type="text" size="10" maxlength="10" placeholder="dd-MM-aaaa"
				onkeypress="mascaraCampo(this, '##-##-####'); return somenteNumero(event);"/>
			</p>
			<p>
				<label for="input-obs">Obs.:</label> <input id="input-obs"
					name="obs" type="text" size="50" maxlength="50" />
			</p>
			<p>
				<input type="submit" name="btGravar" value="Gravar" /> <input
					type="reset" name="btLimpar" value="Limpar" />
			</p>
		</form>
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