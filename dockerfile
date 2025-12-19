FROM eclipse-temurin:17-jdk

WORKDIR /app

# Copiar arquivos do Gradle Wrapper
COPY gradlew .
COPY gradle gradle
COPY build.gradle .
COPY gradle.properties .

# Dar permissão de execução
RUN chmod +x gradlew

# Copiar o restante do projeto
COPY grails-app grails-app
COPY src src

# Baixar dependências
RUN ./gradlew dependencies --no-daemon

# Expor a porta padrão do Grails
EXPOSE 8080

# Comando para rodar a aplicação
CMD ["./gradlew", "bootRun", "--no-daemon"]