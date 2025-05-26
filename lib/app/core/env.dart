import 'package:envied/envied.dart';

part 'env.g.dart';

/// Classe responsável por carregar variáveis de ambiente da aplicação.
///
/// Utiliza o pacote `envied` para gerar código seguro e evitar expor dados sensíveis.
/// As variáveis são definidas no arquivo `.env`, que deve estar na raiz do projeto.
@Envied(path: '.env')
abstract class Env {
  /// URL do projeto Supabase, definida na variável de ambiente `SUPABASE_URL`.
  ///
  /// Essa URL é usada para conectar o aplicativo ao backend do Supabase.
  @EnviedField(varName: 'SUPABASE_URL')
  static String apiUrl = _Env.apiUrl;
}
