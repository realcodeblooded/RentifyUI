import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../common/widgets/custom_button.dart';
import '../../../common/widgets/custom_card.dart';
import '../../../common/widgets/app_background.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: CustomCard(
                isGlass: true,
                padding: const EdgeInsets.all(32),
                // Using 'content' alias for the main body since CustomCard supports child/content
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Icon Placeholder (Hand wave)
                    Container(
                      width: 48,
                      height: 48,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Text('👋', style: TextStyle(fontSize: 24)),
                      ),
                    ),
                    const SizedBox(height: 24, width: 8),

                    // Welcome Text
                    Text(
                      'Hi there Thomas!',
                      style:
                          Theme.of(context).textTheme.displayMedium?.copyWith(
                                color: Colors.white,
                              ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Welcome to Rentify - your all-in-one property management solution',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.white.withOpacity(0.9),
                            height: 1.5,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),

                    // Feature List
                    _buildFeatureItem('Track rental units and tenants'),
                    const SizedBox(height: 12),
                    _buildFeatureItem('Manage rent payments effortlessly'),
                    const SizedBox(height: 12),
                    _buildFeatureItem('Handle maintenance requests easily'),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: CustomButton(
                        label: 'Get Started',
                        onPressed: () {
                          context.go('/auth/login');
                        },
                        variant: ButtonVariant.defaultVariant,
                      ),
                    ),
                    // Footer Text
                    const Text(
                      'Streamline your property management with Rentify\'s intuitive platform',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white60,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem(String text) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.check,
            size: 12,
            color: Colors.purple,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }
}
