import * as dotenv from 'dotenv';
dotenv.config();

import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
// 1. Novo import do Swagger adicionado aqui:
import { DocumentBuilder, SwaggerModule } from '@nestjs/swagger';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  
  // A sua configuração de CORS mantida intacta
  app.enableCors({
    origin: '*', // Permite qualquer origem (ideal para desenvolvimento local)
    methods: 'GET,HEAD,PUT,PATCH,POST,DELETE',
    allowedHeaders: 'Content-Type,Authorization',
  });

  // --- 2. NOVA CONFIGURAÇÃO DO SWAGGER (SPEC-DRIVEN) ---
  const config = new DocumentBuilder()
    .setTitle('API Elas Conectadas')
    .setDescription('Documentação baseada em Spec-Driven Development')
    .setVersion('1.0')
    .build();
    
  const document = SwaggerModule.createDocument(app, config);
  
  // A documentação ficará disponível na rota /api/docs
  SwaggerModule.setup('api/docs', app, document);
  // -----------------------------------------------------

  // A sua porta 8080 mantida intacta
  await app.listen(8080, '0.0.0.0');
}
bootstrap();