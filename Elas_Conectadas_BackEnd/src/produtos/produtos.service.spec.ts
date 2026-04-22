import { Injectable, NotFoundException } from '@nestjs/common';
import { CreateProdutoDto } from './dto/create-produto.dto';
import { UpdateProdutoDto } from './dto/update-produto.dto';
import { PrismaService } from '../prisma/prisma.service';

@Injectable()
export class ProdutosService {
  constructor(private prisma: PrismaService) {}

  // POST: Cria um produto
  async create(createProdutoDto: CreateProdutoDto) {
    return await this.prisma.produto.create({
      data: createProdutoDto,
    });
  }

  // GET: Lista todos os produtos
  async findAll() {
    return await this.prisma.produto.findMany();
  }

  // GET: Busca um produto específico pelo ID
  async findOne(id: string) {
    const produto = await this.prisma.produto.findUnique({
      where: { id },
    });
    
    // Tratamento de erro: se não achar, avisa o frontend com erro 404
    if (!produto) {
      throw new NotFoundException(`Produto com ID ${id} não encontrado`);
    }
    return produto;
  }

  // PATCH: Atualiza os dados de um produto
  async update(id: string, updateProdutoDto: UpdateProdutoDto) {
    // Primeiro verifica se o produto existe
    await this.findOne(id); 
    
    return await this.prisma.produto.update({
      where: { id },
      data: updateProdutoDto,
    });
  }

  // DELETE: Remove um produto
  async remove(id: string) {
    // Primeiro verifica se o produto existe
    await this.findOne(id);

    return await this.prisma.produto.delete({
      where: { id },
    });
  }
}