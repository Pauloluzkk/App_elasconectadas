/// Modelo de Produto/Serviço que espelha o schema Prisma do backend.
class ProdutoModel {
  final String? id;
  final String nome;
  final String descricao;
  final double preco;
  final String categoria; // 'PRODUCT' ou 'SERVICE'
  final String? imagemUrl;
  final String userId;
  final DateTime? criadoEm;

  const ProdutoModel({
    this.id,
    required this.nome,
    required this.descricao,
    required this.preco,
    required this.categoria,
    this.imagemUrl,
    required this.userId,
    this.criadoEm,
  });

  factory ProdutoModel.fromJson(Map<String, dynamic> json) {
    return ProdutoModel(
      id: json['id'] as String?,
      nome: json['nome'] as String? ?? '',
      descricao: json['descricao'] as String? ?? '',
      preco: (json['preco'] as num?)?.toDouble() ?? 0.0,
      categoria: json['categoria'] as String? ?? '',
      imagemUrl: json['imagemUrl'] as String?,
      userId: json['userId'] as String? ?? '',
      criadoEm: json['criado_em'] != null
          ? DateTime.tryParse(json['criado_em'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'nome': nome,
    'descricao': descricao,
    'preco': preco,
    'categoria': categoria,
    if (imagemUrl != null) 'imagemUrl': imagemUrl,
    'userId': userId,
  };

  String get precoFormatado => 'R\$ ${preco.toStringAsFixed(2).replaceAll('.', ',')}';
}
