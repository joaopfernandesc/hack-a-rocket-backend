# Zenvia Experience Hackathon - Hack a Rocket! - Time 

Neste repositório você encontra a parte do back-end proposta para o Hackathon. Trata-se da **dora****.co**, uma solução inovadora que visa unir universitário e profissionais de consultoria a pequenas e médias empresas.

A plataforma utiliza das APIs da Zenvia após algum desses triggers serem acionados:
- Para confirmar o cadastro, um token é enviado via WhatsApp para o usuário;
- Ao ser agendada uma mentoria, as duas partes recebem um whatsapp com data e hora;
- Sempre que faltar 1 hora para a mentoria, as duas partes recebem uma mensagem via WhatsApp lembrando da mentoria (tem uma rake que deve ser executada via Crontab para checar quais usuários devem receber a mensagem);
- Ao ter uma mentoria cancelada por qualquer uma das partes, a outra parte recebe um aviso do cancelamento;
---
## Endpoints disponibilizados:

### Agendamentos:
- **POST /appointments** - criação de agendamentos;
- **GET /appointments** - pega os agendamentos do usuário;
- **GET /appointments/:id** - pega os detalhes daquele agendamento;
- **DELETE /appointments/:id** - cancela o agendamento;

### Usuário (estudante/consultor/empresa)
- **POST /users** - cria um usuário (estudante/consultor/empresa);
- **PUT /users/:id** - edita informações básicas do usuário;
- **GET /users/:id** - pega as informações de um usuário específico;

### Trilhas do usuário
- **POST /user_paths** - associa uma trilha a um mentor;
- **GET /user_paths** - pega todas as trilhas de um usuário
- **DELETE /user_paths/:id** - desassocia a trilha de um mentor;

### Mentores
- **GET /mentors** - pega os mentores disponíveis daquela trilha para aquele dia;

### Trilhas
- **GET /paths** - pega todas as trilhas disponíveis no sistema;
 
### Avaliações
- **POST /ratings** - adiciona uma avaliação a um usuário;
- **GET /ratings** - pega as avaliações de um determinado usuário;

### Disponibilidade de horários
- **POST /regular_times** - adiciona a disponibilidade recorrente de um dia da semana (ex: toda segunda das 10h-12h);
- **GET /regular_times** - pega todos os horários disponíveis do usuário;
- **DELETE /regular_times/:id** - exclui uma disponibilidade recorrente;
 
### Login
- **POST /sessions** - gera um JWT;

### Confirmação de usuário:
- **POST /confirm** - confirma o usuário;
