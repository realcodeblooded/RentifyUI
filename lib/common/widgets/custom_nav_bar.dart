import 'dart:ui';
import 'package:flutter/material.dart';

class CustomNavBar extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTabSelected;

  const CustomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
  });

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  bool _isExpanded = false;

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  void _onItemTapped(int index) {
    widget.onTabSelected(index);
    if (_isExpanded) {
      setState(() {
        _isExpanded = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Check if we are on a smaller screen (e.g., mobile)
        // We use a MediaQuery check usually, but here we can check parent constraints/screen width logic if passed or infer from context.
        // Assuming context.size is available via MediaQuery for global query since app_layout uses positioned.
        final screenWidth = MediaQuery.of(context).size.width;
        final isMobile =
            screenWidth < 800; // Using 800 as breakpoint for nav bar

        if (isMobile && !_isExpanded) {
          return Center(
            child: GestureDetector(
              onTap: _toggleExpanded,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white.withOpacity(0.2)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Icon(
                      _getIconForIndex(widget.currentIndex),
                      color: Colors.black87,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ),
          );
        }

        return Center(
          child: GestureDetector(
            onTap: isMobile && _isExpanded ? () {} : null, // Catch taps
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  constraints: BoxConstraints(
                    maxWidth: isMobile ? screenWidth - 32 : 800,
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.white.withOpacity(0.2)),
                  ),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _NavBarItem(
                          icon: Icons.bar_chart,
                          label: 'Metrics',
                          isSelected: widget.currentIndex == 0,
                          onTap: () => _onItemTapped(0),
                        ),
                        _NavBarItem(
                          icon: Icons.apartment,
                          label: 'Properties',
                          isSelected: widget.currentIndex == 1,
                          onTap: () => _onItemTapped(1),
                        ),
                        _NavBarItem(
                          icon: Icons.home,
                          label: 'Units',
                          isSelected: widget.currentIndex == 2,
                          onTap: () => _onItemTapped(2),
                        ),
                        _NavBarItem(
                          icon: Icons.build,
                          label: 'Requests',
                          isSelected: widget.currentIndex == 3,
                          onTap: () => _onItemTapped(3),
                        ),
                        _NavBarItem(
                          icon: Icons.person_remove,
                          label: 'Vacate',
                          isSelected: widget.currentIndex == 4,
                          onTap: () => _onItemTapped(4),
                        ),
                        if (isMobile) ...[
                          const SizedBox(width: 8),
                          IconButton(
                            icon:
                                const Icon(Icons.close, color: Colors.black54),
                            onPressed: _toggleExpanded,
                          ),
                        ]
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  IconData _getIconForIndex(int index) {
    switch (index) {
      case 0:
        return Icons.bar_chart;
      case 1:
        return Icons.apartment;
      case 2:
        return Icons.home;
      case 3:
        return Icons.build;
      case 4:
        return Icons.person_remove;
      default:
        return Icons.circle;
    }
  }
}

class _NavBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 100, // Fixed width for uniformity
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  )
                ]
              : [],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 20,
              color: isSelected ? Colors.black : Colors.black87,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? Colors.black : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
