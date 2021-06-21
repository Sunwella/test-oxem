FROM node:15

WORKDIR /test-oxem

COPY package*.json ./

RUN npm install

COPY . .

EXPOSE 8080

CMD [ "npm", "run", "serve" ] 