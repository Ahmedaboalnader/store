# FROM node:18-alpine AS build

# WORKDIR /app

# COPY package*.json ./
# RUN npm install

# COPY . .
# RUN npm run build

# FROM nginx:alpine

# # نسخ الملفات المبنية
# COPY --from=build /app/build /usr/share/nginx/html

# # تعديل Nginx ليسمع على 8080 لأن Cloud Run بيبعت traffic عليه
# RUN sed -i 's/listen\s\+80;/listen 8080;/' /etc/nginx/conf.d/default.conf

# EXPOSE 8080

# CMD ["nginx", "-g", "daemon off;"]
# 1️⃣ استخدم صورة Node الرسمية للبناء 


FROM node:18-alpine AS build

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

FROM nginx:alpine

COPY --from=build /app/build /usr/share/nginx/html


EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
