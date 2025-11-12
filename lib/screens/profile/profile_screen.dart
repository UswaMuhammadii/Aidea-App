import 'package:flutter/material.dart';
import '../../models/user_model.dart';
import 'edit_profile_screen.dart';
import 'addresses_screen.dart';
import '../notifications/notification_screen.dart';
import '../../gen_l10n/app_localizations.dart';

class AppColors {
  static const deepPurple = Color(0xFF7C3AED);
  static const electricBlue = Color(0xFF3B82F6);
  static const brightTeal = Color(0xFF14B8A6);

  static const primaryGradient = LinearGradient(
    colors: [deepPurple, electricBlue, brightTeal],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

class ProfileScreen extends StatefulWidget {
  final User user;
  final VoidCallback onLogout;

  const ProfileScreen({
    super.key,
    required this.user,
    required this.onLogout,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  void _logout(AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text(
          l10n.logout,
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        ),
        content: Text(
          l10n.areYouSureYouWantToLogout,
          style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              l10n.cancel,
              style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFEF4444), Color(0xFFDC2626)],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
                widget.onLogout();
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.transparent,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              child: Text(l10n.logout,
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToEditProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfileScreen(user: widget.user),
      ),
    );
  }

  void _navigateToAddresses() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddressesScreen(user: widget.user),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black87;
    final subtitleColor = isDark ? Colors.white70 : Colors.grey.shade600;
    final cardColor = isDark ? const Color(0xFF1E293B) : Colors.white;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.deepPurple.withValues(alpha: 0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(l10n.profile,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: IconButton(
                              onPressed: () => _logout(l10n),
                              icon: const Icon(Icons.logout, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.white,
                          child: Text(
                            widget.user.name.isNotEmpty
                                ? widget.user.name[0].toUpperCase()
                                : 'U',
                            style: const TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: AppColors.deepPurple,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        widget.user.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.user.email,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.9),
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: _navigateToEditProfile,
                            borderRadius: BorderRadius.circular(16),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 12,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.edit,
                                    color: AppColors.deepPurple,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    l10n.editProfile,
                                    style: const TextStyle(
                                      color: AppColors.deepPurple,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Settings Section
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.settings,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        if (!isDark)
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.08),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                      ],
                    ),
                    child: Column(
                      children: [
                        _buildSettingsTile(
                          icon: Icons.notifications_outlined,
                          title: l10n.notifications,
                          subtitle: l10n.manageNotificationPreferences,
                          iconColor: Colors.orange,
                          textColor: textColor,
                          subtitleColor: subtitleColor,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NotificationScreen(user: widget.user),
                              ),
                            );
                          },
                        ),
                        const Divider(height: 1, indent: 72),
                        _buildSettingsTile(
                          icon: Icons.location_on_outlined,
                          title: l10n.savedAddresses,
                          subtitle: widget.user.address,
                          iconColor: Colors.red,
                          textColor: textColor,
                          subtitleColor: subtitleColor,
                          onTap: _navigateToAddresses,
                        ),
                        const Divider(height: 1, indent: 72),
                        _buildSettingsTile(
                          icon: Icons.payment_outlined,
                          title: l10n.paymentMethods,
                          subtitle: l10n.managePaymentOptions,
                          iconColor: Colors.green,
                          textColor: textColor,
                          subtitleColor: subtitleColor,
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Payment methods coming soon!'),
                              ),
                            );
                          },
                        ),
                        const Divider(height: 1, indent: 72),
                        _buildSettingsTile(
                          icon: Icons.help_outline,
                          title: l10n.helpAndSupport,
                          subtitle: l10n.getHelpAndContactUs,
                          iconColor: Colors.blue,
                          textColor: textColor,
                          subtitleColor: subtitleColor,
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Help & support coming soon!'),
                              ),
                            );
                          },
                        ),
                        const Divider(height: 1, indent: 72),
                        _buildSettingsTile(
                          icon: Icons.info_outline,
                          title: l10n.about,
                          subtitle: l10n.appVersionAndInformation,
                          iconColor: Colors.purple,
                          textColor: textColor,
                          subtitleColor: subtitleColor,
                          onTap: () {
                            showAboutDialog(
                              context: context,
                              applicationName: 'Aidea Technology',
                              applicationVersion: '1.0.0',
                              applicationIcon: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  gradient: AppColors.primaryGradient,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.business,
                                  color: Colors.white,
                                  size: 32,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
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

  Widget _buildInfoTile({
    required IconData icon,
    required String title,
    required String value,
    required Color textColor,
    required Color subtitleColor,
    bool isAddress = false,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.deepPurple.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: AppColors.deepPurple, size: 24),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: textColor,
        ),
      ),
      subtitle: Text(
        value,
        style: TextStyle(
          color: subtitleColor,
          fontSize: 13,
        ),
        maxLines: isAddress ? 2 : 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color iconColor,
    required Color textColor,
    required Color subtitleColor,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: iconColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: iconColor, size: 24),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: textColor,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: subtitleColor,
          fontSize: 13,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: subtitleColor),
      onTap: onTap,
    );
  }
}