# Sistema Integrado de Gestão e Chamados da Prefeitura (SIGEC)

**Versão:** Beta 0.1 – **Data:** 29/04/2025

Este sistema foi desenvolvido com o objetivo de modernizar e facilitar a comunicação interna entre os setores da prefeitura. Ele permite que servidores públicos registrem chamados, acompanhem o andamento das solicitações, alterem suas senhas de acesso, e que administradores possam gerenciar usuários de forma prática e segura.

Projetado com uma navegação intuitiva, o sistema utiliza criptografia de senhas para garantir a segurança dos dados e apresenta um layout adaptado à identidade visual da prefeitura, com tons de verde e espaço reservado para inclusão dos logotipos oficiais. O menu lateral fixo proporciona acesso rápido às principais funcionalidades: Home, Criar Chamado, Ver Chamados, Alterar Senha e Sair, todas acompanhadas por breadcrumbs para facilitar a navegação.

Este aplicativo é exclusivo para uso interno da administração pública municipal, com foco em eficiência, organização e clareza no atendimento às demandas internas.

Desenvolvido por Victor Valariano, estagiário de TI da prefeitura, com base nas necessidades reais dos setores municipais.

---

## Como rodar o sistema

1. **Banco de dados:**  
   - Execute os scripts em `sigec-database/scripts` para criar e popular o banco MySQL.
2. **Backend:**  
   - Coloque os arquivos PHP na pasta do XAMPP (`htdocs/meu-sistema-prefeitura`).
   - Configure o acesso ao banco em `backend/db.php`.
3. **Frontend:**  
   - Acesse `http://localhost/meu-sistema-prefeitura/` no navegador.
4. **App Desktop (Electron):**  
   - Rode `npm install` e depois `npx electron .` na pasta do projeto.

---

## Funcionalidades principais

- **Servidor público:**  
  - Criar chamado
  - Ver andamento e histórico dos seus chamados
  - Alterar senha
  - Soluções rápidas para problemas comuns

- **Administrador:**  
  - Visualizar e gerenciar todos os chamados
  - Finalizar chamados
  - Controle de usuários (ver, cadastrar, histórico)
  - Dashboard de chamados por área

---

## Estrutura de pastas

```
/backend
/components
/imag
/sigec-database
/styles.css
/index.html
/menu.html
/server_menu.html
/admin_menu.html
/admin_users.html
/admin_register_server.html
/admin_dashboard.html
/report_problem.html
/ver_chamados.html
/alterar_senha.html
/login.html
/register.html
/quick_solutions.html
/info_app.html
```

---

## Observações

- O backend precisa estar acessível para todos os usuários (rede interna ou internet).
- O sistema é seguro, com senhas criptografadas e controle de sessão.
- O layout é responsivo e segue a identidade visual da prefeitura.

---