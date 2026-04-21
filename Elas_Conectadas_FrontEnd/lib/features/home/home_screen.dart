import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Dados de exemplo para o feed (serão substituídos pela API futuramente)
  static const _tabs = ['Produtos', 'Serviços', 'Parcerias'];

  final _mockAds = const [
    _AdItem(
      emoji: '👟',
      title: 'Sandália de Couro',
      description: 'Artesanal, numeração 34-40',
      price: 'R\$ 99,90',
      author: 'por Mariana S.',
      category: 'Produto',
      type: 'PRODUCT',
    ),
    _AdItem(
      emoji: '💻',
      title: 'Design de Marca',
      description: 'Identidade visual para MEI',
      price: 'A partir R\$ 350',
      author: 'por Carla M.',
      category: 'Designer',
      type: 'SERVICE',
    ),
    _AdItem(
      emoji: '🤝',
      title: 'Co-fundadora para fintech de mães',
      description: 'Renata L. • Produto • Campinas',
      price: '',
      author: 'Aberta • 4 interessadas',
      category: 'Parceria',
      type: 'COLLAB',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Elas Conectadas'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: AppColors.textWhite),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: AppColors.textWhite),
            onPressed: () {},
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: _tabs.map((t) => Tab(text: t)).toList(),
        ),
      ),
      body: Column(
        children: [
          // ── Banner de verificação (condicional) ──────────────────────────
          _UnverifiedBanner(),

          // ── Feed ─────────────────────────────────────────────────────────
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _AdFeed(ads: _mockAds.where((a) => a.type == 'PRODUCT').toList()),
                _AdFeed(ads: _mockAds.where((a) => a.type == 'SERVICE').toList()),
                _AdFeed(ads: _mockAds.where((a) => a.type == 'COLLAB').toList()),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textWhite,
        onPressed: _showNewAdSheet,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showNewAdSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Novo anúncio', style: AppTextStyles.headlineMedium),
            const SizedBox(height: 16),
            _SheetOption(icon: Icons.shopping_bag_outlined, label: 'Produto', onTap: () => Navigator.pop(context)),
            _SheetOption(icon: Icons.design_services_outlined, label: 'Serviço', onTap: () => Navigator.pop(context)),
            _SheetOption(icon: Icons.handshake_outlined, label: 'Parceria', onTap: () => Navigator.pop(context)),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

// ── Widgets internos ──────────────────────────────────────────────────────────

class _UnverifiedBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: conectar ao estado real da conta
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      color: AppColors.unverifiedBanner,
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Conta não verificada · Verifique para aparecer nas buscas',
              style: AppTextStyles.labelMedium.copyWith(color: AppColors.textMedium),
            ),
          ),
          GestureDetector(
            onTap: () => context.go('/otp', extra: ''),
            child: Text('Verificar →', style: AppTextStyles.labelMedium.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
            )),
          ),
        ],
      ),
    );
  }
}

class _AdFeed extends StatelessWidget {
  final List<_AdItem> ads;
  const _AdFeed({required this.ads});

  @override
  Widget build(BuildContext context) {
    if (ads.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.inbox_outlined, size: 48, color: AppColors.border),
            const SizedBox(height: 8),
            Text('Nenhum anúncio aqui ainda', style: AppTextStyles.bodyMedium),
          ],
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: ads.length,
      itemBuilder: (_, i) => _AdCard(ad: ads[i]),
    );
  }
}

class _AdCard extends StatelessWidget {
  final _AdItem ad;
  const _AdCard({required this.ad});

  @override
  Widget build(BuildContext context) {
    final isCollab = ad.type == 'COLLAB';
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagem/Emoji
            Container(
              width: 56, height: 56,
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(child: Text(ad.emoji, style: const TextStyle(fontSize: 28))),
            ),
            const SizedBox(width: 12),
            // Conteúdo
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isCollab)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.chip,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text('PARCERIA', style: AppTextStyles.labelMedium.copyWith(
                        color: AppColors.primary, fontWeight: FontWeight.w700, fontSize: 10)),
                    ),
                  if (isCollab) const SizedBox(height: 4),
                  Text(ad.title, style: AppTextStyles.titleMedium),
                  const SizedBox(height: 2),
                  Text(ad.description, style: AppTextStyles.bodyMedium),
                  if (ad.price.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(ad.price, style: AppTextStyles.priceStyle),
                  ],
                  const SizedBox(height: 2),
                  Text(ad.author, style: AppTextStyles.labelMedium),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text('Conectar →', style: AppTextStyles.labelMedium.copyWith(
                        color: AppColors.textWhite, fontWeight: FontWeight.w600)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SheetOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _SheetOption({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(label, style: AppTextStyles.bodyLarge),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.textLight),
      onTap: onTap,
    );
  }
}

class _AdItem {
  final String emoji;
  final String title;
  final String description;
  final String price;
  final String author;
  final String category;
  final String type;
  const _AdItem({
    required this.emoji, required this.title, required this.description,
    required this.price, required this.author, required this.category, required this.type,
  });
}
