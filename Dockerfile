FROM node:20-alpine as builder

ENV NODE_ENV build

# Primeiro, usa usuário root (padrão é root no começo do container)
# Então NÃO colocar USER node ainda!

WORKDIR /home/node/backend

COPY backend/*.json ./
RUN npm ci

WORKDIR /home/node
COPY . .

WORKDIR /home/node/backend

# Prisma generate + build ainda como root
RUN npx prisma generate \
    && npm run build \
    && npm prune --omit=dev

# ---

FROM node:20-alpine

ENV NODE_ENV production

# Agora sim, muda para node (para rodar o app com menos privilégios)
USER node
WORKDIR /home/node

COPY --from=builder /home/node/backend/package*.json ./
COPY --from=builder /home/node/backend/node_modules/ ./node_modules/
COPY --from=builder /home/node/backend/dist/ ./dist/

CMD ["node", "dist/backend/src/main.js"]
