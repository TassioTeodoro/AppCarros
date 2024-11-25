import 'package:firebase_auth/firebase_auth.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Método para criar uma conta com e-mail e senha
  Future<String?> signUp(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null; // Sucesso
    } on FirebaseAuthException catch (e) {
      return handleAuthError(e); // Tratamento de erro
    }
  }

  /// Método para realizar login com e-mail e senha
  Future<String?> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null; // Sucesso
    } on FirebaseAuthException catch (e) {
      return handleAuthError(e); // Tratamento de erro
    }
  }

  /// Método para redefinir senha
  Future<String?> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return null; // Sucesso
    } on FirebaseAuthException catch (e) {
      return handleAuthError(e); // Tratamento de erro
    }
  }

  /// Método para sair da conta
  Future<void> signOut() async {
    await _auth.signOut();
  }

  /// Retorna o usuário autenticado atualmente
  User? get currentUser => _auth.currentUser;

  /// Retorna detalhes do usuário atual
  Future<Map<String, String>> getUserDetails() async {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception('Nenhum usuário autenticado.');
    }

    return {
      'name': user.displayName ?? 'Usuário',
      'email': user.email ?? 'E-mail não disponível',
    };
  }

  /// Atualiza o perfil do usuário (displayName)
  Future<String?> updateProfile({required String name}) async {
    try {
      final user = _auth.currentUser;

      if (user == null) {
        throw Exception('Nenhum usuário autenticado.');
      }

      await user.updateDisplayName(name);
      await user.reload(); // Atualiza os dados do usuário

      return null; // Sucesso
    } catch (e) {
      return 'Erro ao atualizar perfil: $e';
    }
  }

  /// Trata os erros do FirebaseAuth
  String handleAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return 'E-mail inválido. Verifique o endereço de e-mail.';
      case 'user-not-found':
        return 'Usuário não encontrado. Verifique o e-mail digitado.';
      case 'wrong-password':
        return 'Senha incorreta. Tente novamente.';
      case 'email-already-in-use':
        return 'Este e-mail já está cadastrado. Use outro ou faça login.';
      case 'weak-password':
        return 'A senha é muito fraca. Escolha uma senha mais forte.';
      default:
        return 'Ocorreu um erro. Tente novamente.';
    }
  }
}
