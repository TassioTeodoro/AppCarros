
# Controle de Abastecimento 🚗⛽

Aplicativo desenvolvido em Flutter para controle de abastecimentos de veículos, com integração ao Firebase para autenticação e armazenamento de dados. O objetivo do app é facilitar o gerenciamento de veículos e o acompanhamento de gastos com abastecimentos.

---

## 🛠️ Funcionalidades
- **Autenticação de Usuário**:
  - Cadastro e login com e-mail e senha.
  - Recuperação de senha.
  - Logout seguro.
- **Menu de Navegação **:
  - **Home**: Tela inicial com a listagem dos veículos cadastrados.
  - **Meus Veículos**: Lista de todos os veículos cadastrados pelo usuário.
  - **Adicionar Veículo**: Formulário para cadastrar novos veículos.
  - **Histórico de Abastecimentos**: Visualização dos abastecimentos realizados.
  - **Perfil**: Dados do perfil do usuário com possibilidade de edição.
  - **Logout**: Botão para sair do aplicativo.
- **Persistência de Dados**:
  - Armazenamento de informações no Firebase Firestore.

---

## 🚀 Pré-requisitos
Antes de começar, certifique-se de ter as seguintes ferramentas instaladas:
- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Dart SDK](https://dart.dev/get-dart)
- [Firebase CLI](https://firebase.google.com/docs/cli)

---

## 🛠️ Configuração do Firebase
1. Configure um projeto no [Firebase Console](https://console.firebase.google.com/).
2. Ative o **Authentication** com o método de e-mail/senha.
3. Configure o **Firestore Database** para armazenar os dados.
4. Baixe o arquivo `google-services.json` e adicione-o à pasta `android/app`.

---

## 💻 Como Executar
1. Clone este repositório:
   ```bash
   git clone https://github.com/TassioTeodoro/AppCarros.git
   ```
2. Acesse o diretório do projeto:
   ```bash
   cd controle-abastecimento
   ```
3. Instale as dependências:
   ```bash
   flutter pub get
   ```
4. Execute o aplicativo:
   ```bash
   flutter run
   ```

---

### 👨‍💻 Desenvolvido por Tássio  
[GitHub](https://github.com/TassioTeodoro/AppCarros.git)
