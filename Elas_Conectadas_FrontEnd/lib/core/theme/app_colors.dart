// Paleta de cores centralizada do Elas Conectadas.
// NUNCA use cores hardcoded nas telas - sempre importe daqui.
import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primários
  static const Color primary = Color(0xFF7C3AED);       // Roxo principal
  static const Color primaryDark = Color(0xFF6B21A8);   // Roxo escuro (AppBar/NavBar)
  static const Color primaryLight = Color(0xFFEDE9FE);  // Roxo bem claro

  // Fundo
  static const Color background = Color(0xFFFAF8FF);    // Roxo quase branco (fundo geral)
  static const Color surface = Color(0xFFFFFFFF);        // Branco (cards)

  // Bordas e chips
  static const Color border = Color(0xFFDDD6FE);
  static const Color chip = Color(0xFFEDE9FE);

  // Texto
  static const Color textDark = Color(0xFF1E1B4B);      // Texto principal escuro
  static const Color textMedium = Color(0xFF6B7280);    // Texto secundário
  static const Color textLight = Color(0xFF9CA3AF);     // Texto desabilitado/placeholder
  static const Color textWhite = Color(0xFFFFFFFF);

  // Semânticas
  static const Color success = Color(0xFF059669);        // Verde (preço / sucesso)
  static const Color error = Color(0xFFDC2626);          // Vermelho (erro)
  static const Color warning = Color(0xFFF59E0B);        // Amarelo (aviso)

  // Extras
  static const Color gradientEnd = Color(0xFFC026D3);   // Final do gradiente de perfil
  static const Color verifiedBadge = Color(0xFF7C3AED); // Selo verificado
  static const Color unverifiedBanner = Color(0xFFFDF4FF);
}
