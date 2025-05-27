
/// Retorna uma mensagem amigável para erros do Supabase no fluxo de registro.
String getRegisterErrorMessage(dynamic error) {
  if (error == null) {
    return 'Erro inesperado.';
  }

  final message = error is Exception
      ? error.toString().toLowerCase()
      : error.message?.toString().toLowerCase() ?? error.toString().toLowerCase();

  if (message.contains('email already registered') || message.contains('duplicate key')) {
    return 'E-mail já cadastrado.';
  }

  if (message.contains('network')) {
    return 'Erro de conexão. Verifique sua internet.';
  }

  return 'Erro inesperado. Por favor, tente novamente.';
}
