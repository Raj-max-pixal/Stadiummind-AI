import 'package:flutter/material.dart';
import '../../core/theme/color_palette.dart';

class CustomCard extends StatefulWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final Color? color;
  final double? elevation;
  final BorderRadius? borderRadius;
  final BorderSide? borderSide;
  final bool enableGlassmorphism;
  final bool enableAnimation;
  final Gradient? gradient;

  const CustomCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.onTap,
    this.color,
    this.elevation,
    this.borderRadius,
    this.borderSide,
    this.enableGlassmorphism = true,
    this.enableAnimation = true,
    this.gradient,
  });

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.98).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _opacityAnimation = Tween<double>(begin: 1.0, end: 0.9).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (widget.enableAnimation) {
      _controller.forward();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (widget.enableAnimation) {
      _controller.reverse();
    }
  }

  void _handleTapCancel() {
    if (widget.enableAnimation) {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final hoverShadow = _isHovered
        ? [
            BoxShadow(
              color: isDark
                  ? Colors.black.withOpacity(0.35)
                  : Colors.black.withOpacity(0.12),
              blurRadius: 25,
              offset: const Offset(0, 14),
            ),
          ]
        : [
            BoxShadow(
              color: isDark
                  ? Colors.black.withOpacity(0.2)
                  : Colors.black.withOpacity(0.05),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ];

    Widget cardContent = MouseRegion(
      onEnter: widget.onTap != null ? (_) => setState(() => _isHovered = true) : null,
      onExit: widget.onTap != null ? (_) => setState(() => _isHovered = false) : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        transform: Matrix4.translationValues(0, _isHovered ? -5.0 : 0.0, 0.0),
        decoration: widget.gradient != null
            ? BoxDecoration(
                gradient: widget.gradient,
                borderRadius: widget.borderRadius ?? BorderRadius.circular(20),
                border: Border.all(
                  color: isDark
                      ? AppColors.glassBorderDark
                      : AppColors.glassBorderLight,
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: isDark
                        ? Colors.black.withOpacity(_isHovered ? 0.4 : 0.25)
                        : AppColors.primary.withOpacity(_isHovered ? 0.35 : 0.2),
                    blurRadius: _isHovered ? 25 : 15,
                    offset: Offset(0, _isHovered ? 12 : 8),
                  )
                ],
              )
            : widget.enableGlassmorphism
                ? BoxDecoration(
                    color: widget.color ??
                        (isDark
                            ? AppColors.cardDark.withOpacity(0.6)
                            : AppColors.cardLight.withOpacity(0.9)),
                    borderRadius: widget.borderRadius ?? BorderRadius.circular(20),
                    border: Border.all(
                      color: isDark
                          ? AppColors.glassBorderDark
                          : AppColors.glassBorderLight,
                      width: 1,
                    ),
                    boxShadow: hoverShadow,
                  )
                : null,
        child: Padding(
          padding: widget.padding ?? const EdgeInsets.all(20),
          child: widget.child,
        ),
      ),
    );

    if (widget.enableAnimation && widget.onTap != null) {
      cardContent = GestureDetector(
        onTapDown: _handleTapDown,
        onTapUp: _handleTapUp,
        onTapCancel: _handleTapCancel,
        onTap: widget.onTap,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Opacity(
                opacity: _opacityAnimation.value,
                child: child,
              ),
            );
          },
          child: cardContent,
        ),
      );
    } else if (widget.onTap != null) {
      cardContent = InkWell(
        onTap: widget.onTap,
        borderRadius: widget.borderRadius ?? BorderRadius.circular(20),
        child: cardContent,
      );
    }

    return Padding(
      padding: widget.margin ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: cardContent,
    );
  }
}
