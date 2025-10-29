# استخدم Node.js خفيف
FROM node:18-alpine

# حدد مجلد العمل داخل الحاوية
WORKDIR /app

# انسخ ملفات الباكج أولاً لتقليل إعادة البناء
COPY package*.json ./

# نزّل الـ dependencies
RUN npm install --production

# انسخ باقي الملفات
COPY . .
ARG DB_SERVER_IP

# بعد كده أخليها كمتغير بيئي داخل الكونتينر
ENV DATABASE_HOST=$DB_SERVER_IP
# عرّف المنفذ
EXPOSE 5000

# الأمر اللي يشغل السيرفر
CMD ["node", "server.js"]
