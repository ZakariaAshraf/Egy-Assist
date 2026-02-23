import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:study_path/core/utils/app_colors.dart';
import 'package:study_path/features/authenticate/presentation/pages/sign_in.dart';
import 'package:study_path/features/authenticate/presentation/pages/sign_up.dart';
import 'package:study_path/l10n/app_localizations.dart';

/// Reusable content for guest-restricted areas: message + Sign in / Create account buttons.
/// Used in full-screen guest placeholder (Profile, Bookmarks) and in-section overlay (Home).
class GuestRestrictedContent extends StatelessWidget {
  const GuestRestrictedContent({super.key, this.padding, this.messageStyle});

  final EdgeInsetsGeometry? padding;
  final TextStyle? messageStyle;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context).textTheme;
    final effectivePadding =
        padding ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 32);

    return Padding(
      padding: effectivePadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.lock_outline,
            size: 56,
            color: Theme.of(context).colorScheme.outline,
          ),
          const SizedBox(height: 16),
          Text(
            l10n.guestCreateAccountToAccess,
            textAlign: TextAlign.center,
            style:
                messageStyle ??
                theme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                onPressed: () {
                  final rootNav = Navigator.of(context, rootNavigator: true);
                  rootNav.pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const SignIn()),
                    (route) => false,
                  );
                },
                child: Text(l10n.login, style: theme.titleMedium),
              ),
              const SizedBox(width: 12),
              FilledButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.blueAccent),
                ),
                onPressed: () {
                  final rootNav = Navigator.of(context, rootNavigator: true);
                  rootNav.pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const SignUp()),
                    (route) => false,
                  );
                },
                child: Text(l10n.create, style: theme.titleMedium),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Full-screen placeholder for guest users (Profile tab, Bookmarks tab).
/// Shows a blurred-style background and [GuestRestrictedContent].
class GuestRestrictedScreen extends StatelessWidget {
  const GuestRestrictedScreen({super.key, this.title});

  final String? title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: title != null
          ? AppBar(title: Text(title!), centerTitle: true)
          : null,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.surface,
              Theme.of(context).colorScheme.surface.withOpacity(0.95),
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: GuestRestrictedContent(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
            ),
          ),
        ),
      ),
    );
  }
}

/// Wraps [child] in a Stack: blurred [child] with [GuestRestrictedContent] on top.
/// Use for in-place restriction (e.g. Saved Programs section on Home).
class GuestRestrictedBlurOverlay extends StatelessWidget {
  const GuestRestrictedBlurOverlay({
    super.key,
    required this.child,
    this.minHeight = 200,
  });

  final Widget child;
  final double minHeight;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Stack(
        alignment: Alignment.center,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(minHeight: minHeight),
            child: SizedBox(width: double.infinity, child: child),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
              child: Container(
                color: Theme.of(context).colorScheme.surface.withOpacity(0.6),
                alignment: Alignment.center,
                child: GuestRestrictedContent(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 24,
                  ),
                  messageStyle: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
