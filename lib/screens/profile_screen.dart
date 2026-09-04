import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../data/user_repository.dart';
import '../utils/app_colors.dart';
import 'login_screen.dart';
import 'order_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Scaffold(
        body: Center(
          child: Text('Please login again.'),
        ),
      );
    }

    return FutureBuilder<Map<String, dynamic>?>(
      future: UserRepository().getUser(user.uid),
      builder: (context, snapshot) {
        final userData = snapshot.data;

        final userName =
            userData?['name']?.toString().isNotEmpty == true
                ? userData!['name'].toString()
                : 'Food Lover';

        final userEmail =
            userData?['email']?.toString().isNotEmpty == true
                ? userData!['email'].toString()
                : user.email ?? 'No email available';

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: AppColors.background,
            elevation: 0,
            centerTitle: true,
            title: const Text(
              'My Profile',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(22),
            child: Column(
              children: [
                const SizedBox(height: 10),
                Container(
                  width: 105,
                  height: 105,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(
                      alpha: 0.12,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person_rounded,
                    size: 60,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  userName,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  userEmail,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 30),
                _ProfileOption(
                  icon: Icons.person_outline_rounded,
                  title: 'Edit Profile',
                  subtitle: 'Update your personal information',
                  onTap: () {
                    _showComingSoon(
                      context,
                      'Edit Profile',
                    );
                  },
                ),
                _ProfileOption(
                  icon: Icons.location_on_outlined,
                  title: 'My Address',
                  subtitle: 'Manage your delivery addresses',
                  onTap: () {
                    _showComingSoon(
                      context,
                      'My Address',
                    );
                  },
                ),
                _ProfileOption(
                  icon: Icons.receipt_long_outlined,
                  title: 'My Orders',
                  subtitle: 'View your previous orders',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const OrderScreen(),
                      ),
                    );
                  },
                ),
                _ProfileOption(
                  icon: Icons.notifications_none_rounded,
                  title: 'Notifications',
                  subtitle: 'Manage notification preferences',
                  onTap: () {
                    _showComingSoon(
                      context,
                      'Notifications',
                    );
                  },
                ),
                _ProfileOption(
                  icon: Icons.settings_outlined,
                  title: 'Settings',
                  subtitle: 'App settings and preferences',
                  onTap: () {
                    _showComingSoon(
                      context,
                      'Settings',
                    );
                  },
                ),
                const SizedBox(height: 10),
                _ProfileOption(
                  icon: Icons.logout_rounded,
                  title: 'Logout',
                  subtitle: 'Sign out from your account',
                  iconColor: Colors.red,
                  titleColor: Colors.red,
                  onTap: () {
                    _showLogoutDialog(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showComingSoon(
    BuildContext context,
    String feature,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$feature feature coming soon!',
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showLogoutDialog(
    BuildContext context,
  ) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            'Logout',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            'Are you sure you want to logout?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(dialogContext);

                try {
                  await FirebaseAuth.instance.signOut();

                  if (!context.mounted) return;

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const LoginScreen(),
                    ),
                    (route) => false,
                  );
                } on FirebaseAuthException {
                  if (!context.mounted) return;

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Unable to logout. Please try again.',
                      ),
                    ),
                  );
                }
              },
              child: const Text(
                'Logout',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ProfileOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final Color? iconColor;
  final Color? titleColor;

  const _ProfileOption({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.iconColor,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 6,
        ),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: (iconColor ?? AppColors.primary)
                .withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(
            icon,
            color: iconColor ?? AppColors.primary,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: titleColor ?? Colors.black,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            fontSize: 12,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios_rounded,
          size: 16,
          color: Colors.grey,
        ),
        onTap: onTap,
      ),
    );
  }
}