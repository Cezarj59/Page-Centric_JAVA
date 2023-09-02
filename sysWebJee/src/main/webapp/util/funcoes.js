// Função para aplicar uma máscara a um campo de entrada com base em um formato específico
function mascaraCampo(item, formato) {
	var campo = item.value.length; // Obtém o comprimento atual do valor no campo de entrada
	var resultado = formato.substring(0, 1); // Obtém o primeiro caractere do formato da máscara
	var texto = formato.substring(campo); // Obtém o restante do formato da máscara com base no comprimento do valor atual

	// Verifica se o próximo caractere no formato é diferente do primeiro caractere
	if (texto.substring(0, 1) != resultado) {
		item.value += texto.substring(0, 1); // Adiciona o próximo caractere da máscara ao valor no campo de entrada
	}
}

// Função para permitir somente números no campo de entrada
function somenteNumero(e) {
	navegador = /msie/i.test(navigator.userAgent); // Verifica se o navegador é Internet Explorer (não recomendado)
	if (navegador)
		var caractere = event.keyCode; // Obtém o código da tecla pressionada no Internet Explorer
	else
		var caractere = e.which; // Obtém o código da tecla pressionada em outros navegadores

	// Verifica se o código da tecla pressionada está na faixa de códigos das teclas numéricas
	if (caractere > 47 && caractere < 58)
		return true; // Permite a entrada da tecla numérica
	else {
		// Verifica se a tecla pressionada não é a tecla de retrocesso (Backspace)
		if (caractere != 8)
			return false; // Bloqueia a entrada de outras teclas não numéricas
		else
			return true; // Permite a entrada da tecla de retrocesso
	}
}


/**
 * Função para exibir uma caixa de confirmação ao usuário e redirecionar para uma página específica
 * com base na escolha do usuário.
 */
function confirma(parametro, acao, aviso, pagina) {
    // Exibe uma caixa de confirmação com a mensagem fornecida.
    if (window.confirm(aviso)) {
        // Se o usuário confirmar, redireciona para a página especificada com os parâmetros apropriados.
        // A concatenação do parâmetro "acao" e "codigo" é feita na URL.
        location.href = pagina + "?acao=" + acao + "&codigo=" + parametro;
    }
}



