FROM node:latest

COPY . /app

WORKDIR /app

RUN npm install nodemon --save-dev

RUN npm install

CMD ["npm", "run", "start:dev"]