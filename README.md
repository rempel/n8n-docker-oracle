# N8N com PostgreSQL, Oracle Instant Client e Nodes Personalizados via Docker Compose

Este projeto configura o ambiente de automação [n8n](https://n8n.io) usando Docker Compose com banco de dados PostgreSQL, suporte ao Oracle Instant Client e suporte a nodes personalizados via volume local.

---

## Estrutura

- `n8n`: container principal, baseado em `n8nio/n8n`, com suporte a Oracle e carregamento de nodes personalizados.
- `postgresql`: container do banco de dados PostgreSQL.
- `volumes`: utilizados para persistência dos dados do n8n, PostgreSQL e carregamento dos nodes customizados.

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
- `./custom`: mapeado como `/data/custom`, utilizado para nodes personalizados

---

## Nodes Personalizados

Para incluir nodes personalizados no ambiente, utilize a pasta `./custom` na raiz do projeto.

### Estrutura esperada

Exemplo para o pacote [@rempel/n8n-nodes-oracle](https://www.npmjs.com/package/@rempel/n8n-nodes-oracle).

Gere o build do pacote, `pnpm build`, e copie oconteúdo gerado do dist para dentro do `custom`.

```
./custom
└── nodes
    └── Oracle
        └── credentials
        └── nodes
```

Os arquivos `.js` devem estar transpilados e prontos para uso. Você pode buildar seu pacote localmente e mover os arquivos `dist` para `./custom/nodes`.

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
- Volume `./custom` montado em `/data/custom` para suporte a nodes externos

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