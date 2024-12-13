FROM nginx:alpine

COPY ./static-content /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

