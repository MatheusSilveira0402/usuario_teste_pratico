/// Trata erros de autenticação vindos do Supabase e retorna mensagens amigáveis.
String getAuthErrorMessage(dynamic error) {
  if (error == null) {
    return 'Erro inesperado.';
  }

  final message = error is Exception
      ? error.toString().toLowerCase()
      : error.message?.toString().toLowerCase() ?? error.toString().toLowerCase();

  if (message.contains('user not found')) {
    return 'Usuário não encontrado.';
  }

  if (message.contains('invalid login credentials')) {
    return 'E-mail ou senha inválidos.';
  }

  if (message.contains('network') || message.contains('socket')) {
    return 'Erro de conexão. Verifique sua internet.';
  }

  if (message.contains('email not confirmed')) {
    return 'Confirme seu e-mail antes de continuar.';
  }

  // Outros erros genéricos
  return 'Erro: ${error.message ?? message}';
}