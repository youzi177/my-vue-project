
# 第一阶段：构建 Vue 项目
FROM node:26-alpine AS builder

WORKDIR /app

# 安装 pnpm
RUN npm install -g pnpm

# 安装依赖
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --frozen-lockfile

# 复制项目代码
COPY . .

# 构建生产文件
RUN pnpm build


# 第二阶段：Nginx 运行生产文件
FROM nginx:alpine AS production

# 删除 Nginx 默认页面
RUN rm -rf /usr/share/nginx/html/*

# 复制 Vue 构建产物
COPY --from=builder /app/dist /usr/share/nginx/html

# 暴露 HTTP 端口
EXPOSE 80

# 启动 Nginx
CMD ["nginx", "-g", "daemon off;"]
