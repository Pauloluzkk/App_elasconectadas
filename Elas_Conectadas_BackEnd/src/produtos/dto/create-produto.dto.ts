import { ApiProperty } from '@nestjs/swagger';

export class CreateProdutoDto {
  @ApiProperty({ example: 'Consultoria de TI', description: 'Nome do produto ou serviço' })
  nome: string;

  @ApiProperty({ example: 'Manutenção de computadores', description: 'Descrição detalhada' })
  descricao: string;

  @ApiProperty({ example: 120.50, description: 'Preço do item' })
  preco: number;

  @ApiProperty({ example: 'Serviços', description: 'Categoria do item' })
  categoria: string;

  @ApiProperty({ 
    example: 'https://minhaimagem.com/foto.jpg', 
    description: 'URL da imagem (opcional)', 
    required: false 
  })
  imagemUrl?: string;

  @ApiProperty({ 
    example: 'ID-DA-USUARIA-AQUI', 
    description: 'ID (UUID) da usuária dona do produto' 
  })
  userId: string;
}