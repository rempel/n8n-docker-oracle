# N8N com PostgreSQL e Oracle Instant Client via Docker Compose

Este projeto configura o ambiente de automação [n8n](https://n8n.io) usando Docker Compose com banco de dados PostgreSQL e suporte ao Oracle Instant Client para conexões com banco Oracle.

---

## Estrutura

- `n8n`: container principal, baseado em `n8nio/n8n`, com suporte a Oracle e configuração persistente.
- `postgresql`: container do banco de dados PostgreSQL.
- `volumes`: utilizados para persistência dos dados do n8n e PostgreSQL.

---

## Pré-requisitos

- Docker
- Docker Compose
- Arquivo `.env` com as variáveis de ambiente definidas (exemplo abaixo)

---

## Exemplo de `.env`

```env
N8N_HOST=localhost
N8N_PORT=5678
N8N_PROTOCOL=http
TZ=America/Sao_Paulo

POSTGRES_USER=n8n
POSTGRES_PASSWORD=senha_segura
POSTGRES_DB=n8ndb
```

---

## Subindo o ambiente

```bash
docker-compose up -d --build
```

A aplicação estará disponível em: [http://localhost:5678](http://localhost:5678)

---

## Volumes

- `n8n-data`: configurações e workflows do n8n
- `postgresql-data`: dados persistentes do PostgreSQL

---

## Healthchecks

- **n8n**: verificação via `http://localhost:5678/healthz`
- **PostgreSQL**: verificação via `pg_isready`

---

## Oracle Instant Client

A imagem personalizada do n8n instala o Oracle Instant Client (v21.13) e o driver `oracledb` (v6.8.0), permitindo integrações com bancos Oracle.

---

## Personalizações

- Instalação de dependências via `apk`
- Configuração de variáveis `LD_LIBRARY_PATH`, `ORACLE_HOME` e `TNS_ADMIN`
- Permissões corrigidas para o usuário `node`

---

## Comandos úteis

```bash
# Verificar logs
docker-compose logs -f n8n

# Parar containers
docker-compose down

# Acessar shell do container n8n
docker exec -it nome-do-container-n8n sh
```

---

## Licença

Este projeto está licenciado sob a [MIT License](LICENSE).


## 💸 Buy Me a Coffee

If you like this project, please consider buying me a coffee. Thank you for your support!

[![Buy Me a Coffee](https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png)](https://www.buymeacoffee.com/rempel)
