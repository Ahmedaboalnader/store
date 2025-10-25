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

# عرّف المنفذ
EXPOSE 5000

# الأمر اللي يشغل السيرفر
CMD ["node", "server.js"]
