import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:portfolio_3/utils/constants.dart';
import 'package:portfolio_3/utils/custom_icons.dart';
import 'package:portfolio_3/utils/env_constants.dart';
import 'package:portfolio_3/utils/extensions/context_extensions.dart';
import 'package:portfolio_3/utils/extensions/int_extensions.dart';
import 'package:portfolio_3/widgets/app/app_divider.dart';
import 'package:portfolio_3/widgets/app/app_text.dart';
import 'package:portfolio_3/widgets/mobile_navbar_button.dart';
import 'package:portfolio_3/widgets/ripple_button.dart';
import 'package:portfolio_3/widgets/theme_switcher.dart';
import 'package:portfolio_3/widgets/wrappers/noise_wrapper.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';

class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isMobile;
  final List<bool> panelsEnabled;
  final Function(int) onPanelToggle;

  const AppAppBar({
    super.key,
    required this.isMobile,
    required this.panelsEnabled,
    required this.onPanelToggle,
  });
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kAppBarHeight),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(kOuterBorderRadius),
          child: AppBar(
            surfaceTintColor: Colors.transparent,
            leadingWidth: 160,
            leading: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                spacing: 10,
                children: [
                  Icon(Icons.person_4_rounded),
                  BodyMediumText('Yahya Amarneh'),
                ],
              ),
            ),
            centerTitle: true,
            title:
                !isMobile
                    ? FittedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          panelsEnabled.length,
                          (index) =>
                              index == 1
                                  ? const SizedBox.shrink()
                                  : MobileNavbarButton(
                                    index: index,
                                    isSelected: panelsEnabled[index],
                                    label:
                                        index == 0
                                            ? 'About'
                                            : index == 1
                                            ? 'Home'
                                            : index == 2
                                            ? 'Projects'
                                            : index == 3
                                            ? 'Project Display'
                                            : 'Experience',
                                    onPressed: () => onPanelToggle(index),
                                  ),
                        ),
                      ),
                    )
                    : null,
            actionsPadding: const EdgeInsets.only(right: 20),
            actions: [
              const ThemeSwitcher(),
              const SizedBox(width: 10),
              RippleButton(
                onPressed: () {
                  //contact me/socials dialog
                  showDialog(
                    context: context,
                    builder:
                        (context) => BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: NoiseWrapper(
                            child: AlertDialog(
                              title: const H3('Contact Me'),
                              content: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: 10,
                                  children: [
                                    ContactMeButton(
                                      text: 'Email',
                                      icon: Icons.contact_mail_rounded,
                                      onPressed:
                                          () => launchUrl(
                                            Uri.parse('mailto:$kEmail'),
                                          ),
                                    ),
                                    ContactMeButton(
                                      text: 'Phone',
                                      icon: Icons.phone_rounded,
                                      onPressed: () {
                                        Clipboard.setData(
                                          const ClipboardData(text: kPhone),
                                        );
                                        context.showSnackBar(
                                          const BodyMediumText(
                                            'Phone number copied to clipboard',
                                          ),
                                        );
                                      },
                                    ),
                                    Row(
                                      children: [
                                        //show resume in google drive
                                        ContactMeButton(
                                          text: 'Resume',
                                          icon: CustomIcons.cv,
                                          onPressed:
                                              () => launchUrl(
                                                Uri.parse(kResumeInWeb),
                                              ),
                                        ),
                                        //show resume in app
                                        CreditsButton(
                                          icon: Icons.remove_red_eye_rounded,
                                          height: 40,
                                          width: 40,
                                          onPressed:
                                              () => showResumeDialog(context),
                                        ),
                                      ],
                                    ),
                                    ContactMeButton(
                                      text: 'LinkedIn',
                                      icon: CustomIcons.linkedin,
                                      onPressed:
                                          () => launchUrl(
                                            Uri.parse(kLinkedInUrl),
                                          ),
                                    ),
                                    ContactMeButton(
                                      text: 'Instagram',
                                      icon: CustomIcons.instagram,
                                      onPressed:
                                          () => launchUrl(
                                            Uri.parse(kInstagramUrl),
                                          ),
                                    ),
                                    ContactMeButton(
                                      text: 'Github',
                                      icon: CustomIcons.github,
                                      onPressed:
                                          () =>
                                              launchUrl(Uri.parse(kGithubUrl)),
                                    ),
                                    const AppDivider(thickness: 1),
                                    CreditsButton(
                                      text: 'Design Inspired by:',
                                      icon: Icons.open_in_new_rounded,
                                      onPressed:
                                          () => launchUrl(
                                            Uri.parse(kDesignInspiredBy),
                                          ),
                                    ),
                                    CreditsButton(
                                      text: 'Logo Inspired by:',
                                      icon: Icons.open_in_new_rounded,
                                      onPressed:
                                          () => launchUrl(
                                            Uri.parse(kLogoInspiredBy),
                                          ),
                                    ),
                                    CreditsButton(
                                      text: '3D Models by:',
                                      icon: Icons.open_in_new_rounded,
                                      onPressed:
                                          () =>
                                              launchUrl(Uri.parse(k3dModelsBy)),
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const LabelSmallText('Close'),
                                ),
                              ],
                            ),
                          ),
                        ),
                  );
                },
                width: 120,
                height: 30,
                centerChild: true,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  spacing: 5,
                  children: [
                    Icon(Icons.mail_rounded, size: kIconSizeSmall),
                    LabelSmallText('Contact Me'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showResumeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: NoiseWrapper(
              child: AlertDialog(
                title: const H3('Resume'),
                content: ClipRRect(
                  borderRadius: BorderRadius.circular(kOuterBorderRadius),
                  child: SizedBox(
                    height: context.height(),
                    width: 500,
                    child: SfPdfViewer.network(kResumeInApp),
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => context.pop(),
                    child: const LabelSmallText('Close'),
                  ),
                ],
              ),
            ),
          ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kAppBarHeight);
}

class CreditsButton extends StatelessWidget {
  final String? text;
  final IconData icon;
  final VoidCallback onPressed;
  final double? width;
  final double? height;

  const CreditsButton({
    super.key,
    this.text,
    required this.icon,
    required this.onPressed,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        text != null ? BodySmallText(text!) : const SizedBox.shrink(),
        RippleButton(
          onPressed: onPressed,
          width: width ?? 30,
          height: height ?? 30,
          child: Icon(icon, size: kIconSizeSmall),
        ),
      ],
    );
  }
}

class ContactMeButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;
  const ContactMeButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return RippleButton(
      onPressed: onPressed,
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        spacing: 5,
        children: [
          0.width,
          Icon(icon, size: kIconSizeSmall),
          LabelMediumText(text),
        ],
      ),
    );
  }
}
