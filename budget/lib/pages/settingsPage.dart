import 'package:budget/colors.dart';
import 'package:budget/database/tables.dart' hide AppSettings;
import 'package:budget/pages/aboutPage.dart';
import 'package:budget/pages/addObjectivePage.dart';
import 'package:budget/pages/addTransactionPage.dart';
import 'package:budget/pages/billSplitter.dart';
import 'package:budget/pages/budgetsListPage.dart';
import 'package:budget/pages/creditDebtTransactionsPage.dart';
import 'package:budget/pages/editHomePage.dart';
import 'package:budget/pages/editObjectivesPage.dart';
import 'package:budget/pages/exchangeRatesPage.dart';
import 'package:budget/pages/homePage/homePageNetWorth.dart';
import 'package:budget/pages/objectivesListPage.dart';
import 'package:budget/pages/premiumPage.dart';
import 'package:budget/pages/transactionsListPage.dart';
import 'package:budget/pages/upcomingOverdueTransactionsPage.dart';
import 'package:budget/struct/currencyFunctions.dart';
import 'package:budget/struct/languageMap.dart';
import 'package:budget/struct/navBarIconsData.dart';
import 'package:budget/widgets/amountRangeSlider.dart';
import 'package:budget/widgets/animatedExpanded.dart';
import 'package:budget/widgets/bottomNavBar.dart';
import 'package:budget/widgets/dropdownSelect.dart';
import 'package:budget/widgets/exportDB.dart';
import 'package:budget/widgets/importCSV.dart';
import 'package:budget/widgets/exportCSV.dart';
import 'package:budget/pages/autoTransactionsPageEmail.dart';
import 'package:budget/pages/editAssociatedTitlesPage.dart';
import 'package:budget/pages/editBudgetPage.dart';
import 'package:budget/pages/editCategoriesPage.dart';
import 'package:budget/pages/editWalletsPage.dart';
import 'package:budget/pages/notificationsPage.dart';
import 'package:budget/pages/subscriptionsPage.dart';
import 'package:budget/widgets/accountAndBackup.dart';
import 'package:budget/widgets/importDB.dart';
import 'package:budget/widgets/moreIcons.dart';
import 'package:budget/widgets/navigationFramework.dart';
import 'package:budget/widgets/notificationsSettings.dart';
import 'package:budget/widgets/openBottomSheet.dart';
import 'package:budget/widgets/framework/pageFramework.dart';
import 'package:budget/widgets/openPopup.dart';
import 'package:budget/widgets/radioItems.dart';
import 'package:budget/widgets/ratingPopup.dart';
import 'package:budget/widgets/restartApp.dart';
import 'package:budget/widgets/selectColor.dart';
import 'package:budget/widgets/settingsContainers.dart';
import 'package:budget/pages/walletDetailsPage.dart';
import 'package:budget/struct/initializeBiometrics.dart';
import 'package:budget/struct/initializeNotifications.dart';
import 'package:budget/struct/upcomingTransactionsFunctions.dart';
import 'package:budget/widgets/sliderSelector.dart';
import 'package:budget/widgets/tappable.dart';
import 'package:budget/widgets/tappableTextEntry.dart';
import 'package:budget/widgets/textWidgets.dart';
import 'package:budget/widgets/timeDigits.dart';
import 'package:budget/widgets/util/checkWidgetLaunch.dart';
import 'package:budget/widgets/util/showTimePicker.dart';
import 'package:budget/widgets/viewAllTransactionsButton.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:budget/main.dart';
import 'package:intl/number_symbols.dart';
import 'package:intl/number_symbols_data.dart';
import 'package:provider/provider.dart';
import '../functions.dart';
import 'package:budget/struct/settings.dart';
import 'package:budget/widgets/framework/popupFramework.dart';
import 'package:app_settings/app_settings.dart';
import 'package:universal_io/io.dart';

//To get SHA1 Key run
// ./gradlew signingReport
//in budget\Android
//Generate new OAuth and put JSON in budget\android\app folder

class MoreActionsPage extends StatefulWidget {
  const MoreActionsPage({
    Key? key,
  }) : super(key: key);

  @override
  State<MoreActionsPage> createState() => MoreActionsPageState();
}

class MoreActionsPageState extends State<MoreActionsPage>
    with AutomaticKeepAliveClientMixin {
  GlobalKey<PageFrameworkState> pageState = GlobalKey();

  void refreshState() {
    print("refresh settings");
    setState(() {});
  }

  void scrollToTop() {
    pageState.currentState!.scrollToTop();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, _) {
      return PageFramework(
        key: pageState,
        title: "more-actions".tr(),
        backButton: false,
        horizontalPadding: getHorizontalPaddingConstrained(context),
        listWidgets: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: PremiumBanner(),
          ),
          MorePages()
        ],
      );
    });
  }
}

class MorePages extends StatelessWidget {
  const MorePages({super.key});

  @override
  Widget build(BuildContext context) {
    bool hasSideNavigation = getIsFullScreen(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        children: [
          if (hasSideNavigation == false)
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: SettingsContainerOpenPage(
                    openPage: SettingsPageFramework(
                      key: settingsPageFrameworkStateKey,
                    ),
                    title: navBarIconsData["settings"]!.labelLong.tr(),
                    icon: navBarIconsData["settings"]!.iconData,
                    description: "settings-and-customization-description".tr(),
                    isOutlined: true,
                    // description: "Theme, Language, CSV Import",
                    isWideOutlined: true,
                  ),
                ),
              ],
            ),
          if (hasSideNavigation == false)
            Row(
              children: [
                Expanded(
                  child: SettingsContainerOpenPage(
                    openPage: WalletDetailsPage(wallet: null),
                    title: navBarIconsData["allSpending"]!.labelLong.tr(),
                    icon: navBarIconsData["allSpending"]!.iconData,
                    description: "all-spending-description".tr(),
                    isOutlined: true,
                    isWideOutlined: true,
                  ),
                ),
              ],
            ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Expanded(
              //   child: Padding(
              //     padding: EdgeInsets.symmetric(vertical: 5, horizontal: 4),
              //     child: SettingsContainer(
              //       onTap: () {
              //         openUrl("https://github.com/jameskokoska/Cashew");
              //       },
              //       title: "open-source".tr(),
              //       icon: MoreIcons.github,
              //       isOutlined: true,
              //     ),
              //   ),
              // ),
              Expanded(
                child: SettingsContainerOpenPage(
                  openPage: AboutPage(),
                  title: "about-app".tr(namedArgs: {"app": globalAppName}),
                  icon: navBarIconsData["about"]!.iconData,
                  isOutlined: true,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 4),
                  child: SettingsContainer(
                    onTap: () {
                      openBottomSheet(context, RatingPopup(), fullSnap: true);
                    },
                    title: "feedback".tr(),
                    icon: appStateSettings["outlinedIcons"]
                        ? Icons.rate_review_outlined
                        : Icons.rate_review_rounded,
                    isOutlined: true,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              notificationsGlobalEnabled
                  ? Expanded(
                      child: SettingsContainerOpenPage(
                        openPage: NotificationsPage(),
                        title: navBarIconsData["notifications"]!.label.tr(),
                        icon: navBarIconsData["notifications"]!.iconData,
                        isOutlined: true,
                      ),
                    )
                  : SizedBox.shrink(),
              if (hasSideNavigation == false)
                Expanded(child: GoogleAccountLoginButton()),
            ],
          ),
          if (hasSideNavigation == false)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: SettingsContainerOpenPage(
                    openPage: SubscriptionsPage(),
                    title: navBarIconsData["subscriptions"]!.label.tr(),
                    icon: navBarIconsData["subscriptions"]!.iconData,
                    isOutlined: true,
                  ),
                ),
                Expanded(
                  child: SettingsContainerOpenPage(
                    openPage:
                        UpcomingOverdueTransactions(overdueTransactions: null),
                    title: navBarIconsData["scheduled"]!.label.tr(),
                    icon: navBarIconsData["scheduled"]!.iconData,
                    isOutlined: true,
                  ),
                ),
              ],
            ),
          if (hasSideNavigation == false)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: SettingsContainerOpenPage(
                    openPage: ObjectivesListPage(
                      backButton: true,
                    ),
                    title: navBarIconsData["goals"]!.label.tr(),
                    icon: navBarIconsData["goals"]!.iconData,
                    isOutlined: true,
                  ),
                ),
                Expanded(
                  child: SettingsContainerOpenPage(
                    openPage: CreditDebtTransactions(isCredit: null),
                    title: navBarIconsData["loans"]!.label.tr(),
                    icon: navBarIconsData["loans"]!.iconData,
                    isOutlined: true,
                  ),
                ),
              ],
            ),
          if (hasSideNavigation == false)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: SettingsContainerOpenPage(
                    isOutlinedColumn: true,
                    openPage: EditWalletsPage(),
                    title: navBarIconsData["accountDetails"]!.label.tr(),
                    icon: navBarIconsData["accountDetails"]!.iconData,
                    isOutlined: true,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SettingsContainerOpenPage(
                    isOutlinedColumn: true,
                    // If budget page not pinned to home, open budget list page
                    openPage: appStateSettings["customNavBarShortcut1"] !=
                                "budgets" &&
                            appStateSettings["customNavBarShortcut2"] !=
                                "budgets"
                        ? BudgetsListPage(enableBackButton: true)
                        : EditBudgetPage(),
                    title: navBarIconsData["budgetDetails"]!.label.tr(),
                    icon: navBarIconsData["budgetDetails"]!.iconData,
                    iconScale: navBarIconsData["budgetDetails"]!.iconScale,
                    isOutlined: true,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SettingsContainerOpenPage(
                    isOutlinedColumn: true,
                    openPage: EditCategoriesPage(),
                    title: navBarIconsData["categoriesDetails"]!.label.tr(),
                    icon: navBarIconsData["categoriesDetails"]!.iconData,
                    isOutlined: true,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SettingsContainerOpenPage(
                    isOutlinedColumn: true,
                    openPage: EditAssociatedTitlesPage(),
                    title: navBarIconsData["titlesDetails"]!.label.tr(),
                    icon: navBarIconsData["titlesDetails"]!.iconData,
                    isOutlined: true,
                  ),
                )
              ],
            ),
          if (hasSideNavigation) SettingsPageContent(),
        ],
      ),
    );
  }
}

class EnterName extends StatelessWidget {
  const EnterName({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SettingsContainer(
      title: "username".tr(),
      icon: Icons.edit,
      onTap: () {
        enterNameBottomSheet(context);
        // Fix over-scroll stretch when keyboard pops up quickly
        Future.delayed(Duration(milliseconds: 100), () {
          bottomSheetControllerGlobal.scrollTo(0,
              duration: Duration(milliseconds: 100));
        });
      },
    );
  }
}

Future enterNameBottomSheet(context) async {
  return await openBottomSheet(
    context,
    fullSnap: true,
    PopupFramework(
      title: "enter-name".tr(),
      child: Column(
        children: [
          SelectText(
            icon: appStateSettings["outlinedIcons"]
                ? Icons.person_outlined
                : Icons.person_rounded,
            setSelectedText: (_) {},
            nextWithInput: (text) {
              updateSettings("username", text.trim(),
                  pagesNeedingRefresh: [0], updateGlobalState: false);
            },
            selectedText: appStateSettings["username"],
            placeholder: "nickname".tr(),
            autoFocus: false,
            requestLateAutoFocus: true,
          ),
        ],
      ),
    ),
  );
}

class SettingsPageFramework extends StatefulWidget {
  const SettingsPageFramework({super.key});

  @override
  State<SettingsPageFramework> createState() => SettingsPageFrameworkState();
}

class SettingsPageFrameworkState extends State<SettingsPageFramework> {
  void refreshState() {
    print("refresh settings framework");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return PageFramework(
      title: "settings".tr(),
      dragDownToDismiss: true,
      listWidgets: [SettingsPageContent()],
    );
  }
}

class SettingsPageContent extends StatelessWidget {
  const SettingsPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SettingsHeader(title: "theme".tr()),
        Builder(
          builder: (context) {
            late Color? selectedColor =
                HexColor(appStateSettings["accentColor"]);

            return SettingsContainer(
              onTap: () {
                openBottomSheet(
                  context,
                  PopupFramework(
                    title: "select-color".tr(),
                    child: Column(
                      children: [
                        getPlatform() == PlatformOS.isIOS
                            ? Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: SettingsContainerSwitch(
                                  title: "colorful-interface".tr(),
                                  onSwitched: (value) {
                                    updateSettings("materialYou", value,
                                        updateGlobalState: true);
                                  },
                                  initialValue: appStateSettings["materialYou"],
                                  icon: appStateSettings["outlinedIcons"]
                                      ? Icons.brush_outlined
                                      : Icons.brush_rounded,
                                  enableBorderRadius: true,
                                ),
                              )
                            : SizedBox.shrink(),
                        SelectColor(
                          includeThemeColor: false,
                          selectedColor: selectedColor,
                          setSelectedColor: (color) {
                            selectedColor = color;
                            updateSettings("accentColor", toHexString(color),
                                updateGlobalState: true);
                            updateSettings("accentSystemColor", false,
                                updateGlobalState: true);
                            generateColors();
                            updateWidgetColorsAndText(context);
                          },
                          useSystemColorPrompt: true,
                        ),
                      ],
                    ),
                  ),
                );
              },
              title: "accent-color".tr(),
              description: "accent-color-description".tr(),
              icon: appStateSettings["outlinedIcons"]
                  ? Icons.color_lens_outlined
                  : Icons.color_lens_rounded,
            );
          },
        ),
        getPlatform() == PlatformOS.isIOS
            ? SizedBox.shrink()
            : SettingsContainerSwitch(
                title: "material-you".tr(),
                description: "material-you-description".tr(),
                onSwitched: (value) {
                  updateSettings("materialYou", value, updateGlobalState: true);
                },
                initialValue: appStateSettings["materialYou"],
                icon: appStateSettings["outlinedIcons"]
                    ? Icons.brush_outlined
                    : Icons.brush_rounded,
              ),
        SettingsContainerDropdown(
          title: "theme-mode".tr(),
          icon: Theme.of(context).brightness == Brightness.light
              ? appStateSettings["outlinedIcons"]
                  ? Icons.lightbulb_outlined
                  : Icons.lightbulb_rounded
              : appStateSettings["outlinedIcons"]
                  ? Icons.dark_mode_outlined
                  : Icons.dark_mode_rounded,
          initial: appStateSettings["theme"].toString(),
          items: ["system", "light", "dark"],
          onChanged: (value) async {
            await updateSettings("theme", value, updateGlobalState: true);
            updateWidgetColorsAndText(context);
          },
          getLabel: (item) {
            return item.tr();
          },
        ),

        // EnterName(),
        SettingsHeader(title: "preferences".tr()),

        SettingsContainerOpenPage(
          openPage: EditHomePage(),
          title: "edit-home-page".tr(),
          icon: appStateSettings["outlinedIcons"]
              ? Icons.home_outlined
              : Icons.home_rounded,
        ),

        notificationsGlobalEnabled && getIsFullScreen(context) == false
            ? SettingsContainerOpenPage(
                openPage: NotificationsPage(),
                title: "notifications".tr(),
                icon: appStateSettings["outlinedIcons"]
                    ? Icons.notifications_outlined
                    : Icons.notifications_rounded,
              )
            : SizedBox.shrink(),

        BiometricsSettingToggle(),

        SettingsContainer(
          title: "language".tr(),
          icon: appStateSettings["outlinedIcons"]
              ? Icons.language_outlined
              : Icons.language_rounded,
          afterWidget: Tappable(
            color: Theme.of(context).colorScheme.secondaryContainer,
            borderRadius: 10,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: TextFont(
                text: languageDisplayFilter(
                    appStateSettings["locale"].toString()),
                fontSize: 14,
              ),
            ),
          ),
          onTap: () {
            openLanguagePicker(context);
          },
        ),

        SettingsContainerOpenPage(
          openPage: MoreOptionsPagePreferences(),
          title: "more-options".tr(),
          description: "more-options-description".tr(),
          icon: appStateSettings["outlinedIcons"]
              ? Icons.app_registration_outlined
              : Icons.app_registration_rounded,
        ),

        SettingsHeader(title: "automation".tr()),
        // SettingsContainerOpenPage(
        //   openPage: AutoTransactionsPage(),
        //   title: "Auto Transactions",
        //   icon: appStateSettings["outlinedIcons"] ? Icons.auto_fix_high_outlined : Icons.auto_fix_high_rounded,
        // ),

        SettingsContainer(
          title: "auto-mark-transactions".tr(),
          description: "auto-mark-transactions-description".tr(),
          icon: appStateSettings["outlinedIcons"]
              ? Icons.check_circle_outlined
              : Icons.check_circle_rounded,
          onTap: () {
            openBottomSheet(
              context,
              PopupFramework(
                hasPadding: false,
                child: UpcomingOverdueSettings(),
              ),
            );
          },
        ),

        appStateSettings["emailScanning"]
            ? SettingsContainerOpenPage(
                openPage: AutoTransactionsPageEmail(),
                title: "auto-email-transactions".tr(),
                icon: appStateSettings["outlinedIcons"]
                    ? Icons.mark_email_unread_outlined
                    : Icons.mark_email_unread_rounded,
              )
            : SizedBox.shrink(),

        SettingsContainerOpenPage(
          openPage: BillSplitter(),
          title: "bill-splitter".tr(),
          icon: appStateSettings["outlinedIcons"]
              ? Icons.summarize_outlined
              : Icons.summarize_rounded,
        ),

        SettingsHeader(title: "import-and-export".tr()),

        ExportCSV(),

        ImportCSV(),

        SettingsHeader(title: "backups".tr()),

        ExportDB(),

        ImportDB(),

        GoogleAccountLoginButton(
          isOutlinedButton: false,
          forceButtonName: "google-drive".tr(),
        ),
      ],
    );
  }
}

class MoreOptionsPagePreferences extends StatelessWidget {
  const MoreOptionsPagePreferences({super.key});

  @override
  Widget build(BuildContext context) {
    return PageFramework(
      title: "more".tr(),
      dragDownToDismiss: true,
      horizontalPadding: getHorizontalPaddingConstrained(context),
      listWidgets: [
        SettingsHeader(title: "style".tr()),
        HeaderHeightSetting(),
        OutlinedIconsSetting(),
        FontPickerSetting(),
        IncreaseTextContrastSetting(),
        SettingsHeader(title: "transactions".tr()),
        TransactionsSettings(),
        SettingsHeader(title: "accounts".tr()),
        ShowAccountLabelSettingToggle(),
        SettingsContainerOpenPage(
          onOpen: () {
            checkIfExchangeRateChangeBefore();
          },
          onClosed: () {
            checkIfExchangeRateChangeAfter();
          },
          openPage: ExchangeRates(),
          title: "exchange-rates".tr(),
          icon: appStateSettings["outlinedIcons"]
              ? Icons.account_balance_wallet_outlined
              : Icons.account_balance_wallet_rounded,
        ),
        SettingsHeader(title: "budgets".tr()),
        BudgetSettings(),
        SettingsHeader(title: "goals".tr()),
        ObjectiveSettings(),
        SettingsHeader(title: "titles".tr()),
        AskForTitlesToggle(),
        AutoTitlesToggle(),
        WidgetSettings(),
        SettingsHeader(title: "formatting".tr()),
        NumberFormattingSetting(),
        Time24HourFormatSetting(),
        ExtraZerosButtonSetting(),
      ],
    );
  }
}

class WidgetSettings extends StatelessWidget {
  const WidgetSettings({super.key});

  @override
  Widget build(BuildContext context) {
    if (getPlatform(ignoreEmulation: true) != PlatformOS.isAndroid)
      return SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SettingsHeader(title: "widgets".tr()),
        NetWorthWidgetSetting(),
        SettingsContainerDropdown(
          title: "widget-theme".tr(),
          icon: appStateSettings["outlinedIcons"]
              ? Icons.contrast_outlined
              : Icons.contrast_rounded,
          initial: appStateSettings["widgetTheme"].toString(),
          items: ["system", "light", "dark"],
          onChanged: (value) async {
            await updateSettings("widgetTheme", value,
                updateGlobalState: false);
            updateWidgetColorsAndText(context);
          },
          getLabel: (item) {
            return item.tr();
          },
        ),
        SettingsContainer(
          title: "widget-background-opacity".tr(),
          icon: appStateSettings["outlinedIcons"]
              ? Icons.blur_on_outlined
              : Icons.blur_on_rounded,
          descriptionWidget: Container(
            height: 28,
            padding: EdgeInsets.only(right: 10),
            child: SliderTheme(
              data: SliderThemeData(
                trackShape: CustomTrackShape(),
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 9),
              ),
              child: SliderSelector(
                min: 0,
                max: 1,
                initialValue:
                    (appStateSettings["widgetOpacity"] ?? 1).toDouble(),
                onChange: (value) {},
                divisions: 20,
                onFinished: (value) {
                  updateSettings("widgetOpacity", value,
                      updateGlobalState: false);
                  updateWidgetColorsAndText(context);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final trackHeight = sliderTheme.trackHeight;
    final trackLeft = offset.dx;
    final trackTop =
        offset.dy + (parentBox.size.height - (trackHeight ?? 0)) / 2;
    final trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, (trackHeight ?? 0));
  }
}

class BiometricsSettingToggle extends StatefulWidget {
  const BiometricsSettingToggle({super.key});

  @override
  State<BiometricsSettingToggle> createState() =>
      _BiometricsSettingToggleState();
}

class _BiometricsSettingToggleState extends State<BiometricsSettingToggle> {
  bool isLocked = appStateSettings["requireAuth"];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        biometricsAvailable
            ? SettingsContainerSwitch(
                title: "biometric-lock".tr(),
                description: "biometric-lock-description".tr(),
                onSwitched: (value) async {
                  try {
                    bool result = await checkBiometrics(
                      checkAlways: true,
                      message: "verify-identity".tr(),
                    );
                    if (result) {
                      updateSettings("requireAuth", value,
                          updateGlobalState: false);
                      setState(() {
                        isLocked = value;
                      });
                    }

                    return result;
                  } catch (e) {
                    openPopup(
                      context,
                      icon: appStateSettings["outlinedIcons"]
                          ? Icons.warning_outlined
                          : Icons.warning_rounded,
                      title: getPlatform() == PlatformOS.isIOS
                          ? "biometrics-disabled".tr()
                          : "biometrics-error".tr(),
                      description: getPlatform() == PlatformOS.isIOS
                          ? "biometrics-disabled-description".tr()
                          : "biometrics-error-description".tr(),
                      onCancelLabel:
                          getPlatform() == PlatformOS.isIOS ? "ok".tr() : null,
                      onCancel: () {
                        Navigator.pop(context);
                      },
                      onSubmitLabel: getPlatform() == PlatformOS.isIOS
                          ? "open-settings".tr()
                          : "ok".tr(),
                      onSubmit: () {
                        Navigator.pop(context);
                        // On iOS the notification app settings page also has
                        // the permission for biometrics
                        if (getPlatform() == PlatformOS.isIOS) {
                          AppSettings.openNotificationSettings();
                        }
                      },
                    );
                  }
                },
                initialValue: appStateSettings["requireAuth"],
                icon: isLocked
                    ? appStateSettings["outlinedIcons"]
                        ? Icons.lock_outlined
                        : Icons.lock_rounded
                    : appStateSettings["outlinedIcons"]
                        ? Icons.lock_open_outlined
                        : Icons.lock_open_rounded,
              )
            : SizedBox.shrink(),
      ],
    );
  }
}

class HeaderHeightSetting extends StatelessWidget {
  const HeaderHeightSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedExpanded(
      // Indicates if it is enabled by default per device height
      expand: MediaQuery.sizeOf(context).height > MIN_HEIGHT_FOR_HEADER &&
          getPlatform() != PlatformOS.isIOS,
      child: SettingsContainerDropdown(
        title: "header-height".tr(),
        icon: appStateSettings["outlinedIcons"]
            ? Icons.subtitles_outlined
            : Icons.subtitles_rounded,
        initial: appStateSettings["forceSmallHeader"].toString(),
        items: ["true", "false"],
        onChanged: (value) async {
          bool boolValue = false;
          if (value == "true") {
            boolValue = true;
          } else if (value == "false") {
            boolValue = false;
          }
          await updateSettings(
            "forceSmallHeader",
            boolValue,
            updateGlobalState: false,
            setStateAllPageFrameworks: true,
            pagesNeedingRefresh: [0],
          );
        },
        getLabel: (item) {
          if (item == "true") return "short".tr();
          if (item == "false") return "tall".tr();
        },
      ),
    );
  }
}

// Changing this setting needs to update the UI, that's not something that happens when setting global state
class OutlinedIconsSetting extends StatelessWidget {
  const OutlinedIconsSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsContainerDropdown(
      items: ["rounded", "outlined"],
      onChanged: (value) async {
        if (value == "rounded") {
          await updateSettings("outlinedIcons", false,
              updateGlobalState: false);
        } else {
          await updateSettings(
            "outlinedIcons",
            true,
            updateGlobalState: false,
          );
        }
        navBarIconsData = getNavBarIconsData();
        RestartApp.restartApp(context);
      },
      getLabel: (value) {
        return value.tr();
      },
      initial:
          appStateSettings["outlinedIcons"] == true ? "outlined" : "rounded",
      title: "icon-style".tr(),
      icon: appStateSettings["outlinedIcons"]
          ? Icons.star_outline
          : Icons.star_rounded,
    );
  }
}

class IncreaseTextContrastSetting extends StatelessWidget {
  const IncreaseTextContrastSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsContainerSwitch(
      title: "increase-text-contrast".tr(),
      description: "increase-text-contrast-description".tr(),
      onSwitched: (value) async {
        await updateSettings("increaseTextContrast", value,
            updateGlobalState: true);
      },
      initialValue: appStateSettings["increaseTextContrast"],
      icon: appStateSettings["outlinedIcons"]
          ? Icons.exposure_outlined
          : Icons.exposure_rounded,
      descriptionColor: appStateSettings["increaseTextContrast"]
          ? getColor(context, "black").withOpacity(0.84)
          : Theme.of(context).colorScheme.secondary.withOpacity(0.45),
    );
  }
}

class FontPickerSetting extends StatelessWidget {
  const FontPickerSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsContainer(
      title: "font".tr().capitalizeFirst,
      icon: appStateSettings["outlinedIcons"]
          ? Icons.font_download_outlined
          : Icons.font_download_rounded,
      afterWidget: Tappable(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: 10,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Builder(builder: (context) {
            String displayFontName =
                fontNameDisplayFilter(appStateSettings["font"].toString());
            return TextFont(
              text: displayFontName,
              fontSize: 14,
            );
          }),
        ),
      ),
      onTap: () {
        openFontPicker(context);
      },
    );
  }
}

void openFontPicker(BuildContext context) {
  openBottomSheet(
    context,
    PopupFramework(
      title: "font".tr(),
      child: RadioItems(
        itemsAreFonts: true,
        items: [
          // These values match that of pubspec font family
          "Avenir",
          "DMSans",
          "Metropolis",
          // SF Pro removed - users on iOS can just select Platform font
          // Inter is the font family fallback
          "RobotoCondensed",
          "(Platform)",
        ],
        initial: appStateSettings["font"].toString(),
        displayFilter: fontNameDisplayFilter,
        onChanged: (value) async {
          updateSettings("font", value, updateGlobalState: true);
          await Future.delayed(Duration(milliseconds: 50));
          Navigator.pop(context);
        },
      ),
    ),
  );
}

String fontNameDisplayFilter(String value) {
  if (value == "Avenir") {
    return "default".tr().capitalizeFirst;
  } else if (value == "(Platform)") {
    return "platform".tr().capitalizeFirst;
  } else if (value == "DMSans") {
    return "DM Sans";
  } else if (value == "RobotoCondensed") {
    return "Roboto Condensed";
  }
  return value.toString();
}

class NumberFormattingSetting extends StatelessWidget {
  const NumberFormattingSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsContainer(
      title: "number-format".tr(),
      icon: appStateSettings["outlinedIcons"]
          ? Icons.one_x_mobiledata_outlined
          : Icons.one_x_mobiledata_rounded,
      afterWidget: IgnorePointer(
        child: Tappable(
          color: Theme.of(context).colorScheme.secondaryContainer,
          borderRadius: 10,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: TextFont(
              text: convertToMoney(
                Provider.of<AllWallets>(context, listen: true),
                1000.23,
              ),
              fontSize: 14,
            ),
          ),
        ),
      ),
      onTap: () async {
        await openBottomSheet(
          context,
          fullSnap: true,
          SetNumberFormatPopup(),
        );
      },
    );
  }
}

class Time24HourFormatSetting extends StatelessWidget {
  const Time24HourFormatSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsContainerDropdown(
      title: "clock-format".tr(),
      icon: appStateSettings["outlinedIcons"]
          ? Icons.history_toggle_off_outlined
          : Icons.history_toggle_off_rounded,
      initial: appStateSettings["use24HourFormat"].toString(),
      items: ["system", "12-hour", "24-hour"],
      onChanged: (value) async {
        await updateSettings("use24HourFormat", value, updateGlobalState: true);
      },
      getLabel: (item) {
        return item.tr();
      },
    );
  }
}

class SetNumberFormatPopup extends StatefulWidget {
  const SetNumberFormatPopup({super.key});

  @override
  State<SetNumberFormatPopup> createState() => _SetNumberFormatPopupState();
}

class _SetNumberFormatPopupState extends State<SetNumberFormatPopup> {
  @override
  Widget build(BuildContext context) {
    // AppData\Local\Pub\Cache\hosted\pub.dev\intl-0.18.1\lib\number_symbols_data.dart
    List<String?> items = [
      null,
      "en",
      "tr",
      "af",
      // "ar", // puts the negative sign at the end, remove this option
      "de",
      "fr",
    ];
    return PopupFramework(
      title: "number-format".tr(),
      child: Column(
        children: [
          RadioItems(
            items: items,
            initial: appStateSettings["numberFormatLocale"],
            displayFilter: (item) {
              if (item == null)
                return "default".tr() +
                    " " +
                    "(" +
                    convertToMoney(
                        Provider.of<AllWallets>(context, listen: true), 1000.23,
                        customLocale: Platform.localeName) +
                    ")";
              return convertToMoney(
                  Provider.of<AllWallets>(context, listen: true), 1000.23,
                  customLocale: item);
            },
            onChanged: (value) {
              updateSettings("numberFormatLocale", value,
                  updateGlobalState: true);
              Navigator.of(context).pop();
            },
          ),
          SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: TextFont(
              text: "decimal-precision-edit-account-info".tr(),
              fontSize: 14,
              maxLines: 5,
              textAlign: TextAlign.center,
              textColor: getColor(context, "textLight"),
            ),
          ),
        ],
      ),
    );
  }
}

class ExtraZerosButtonSetting extends StatelessWidget {
  const ExtraZerosButtonSetting({this.enableBorderRadius = false, super.key});
  final bool enableBorderRadius;
  @override
  Widget build(BuildContext context) {
    return SettingsContainerDropdown(
      enableBorderRadius: enableBorderRadius,
      title: "extra-zeros-button".tr(),
      icon: appStateSettings["outlinedIcons"]
          ? Icons.check_box_outline_blank_outlined
          : Icons.check_box_outline_blank_rounded,
      initial: appStateSettings["extraZerosButton"].toString(),
      items: ["", "00", "000"],
      onChanged: (value) async {
        updateSettings(
          "extraZerosButton",
          value == "" ? null : value,
          updateGlobalState: false,
        );
      },
      getLabel: (item) {
        if (item == "") return "none".tr().capitalizeFirst;
        return item;
      },
    );
  }
}

class NetWorthWidgetSetting extends StatelessWidget {
  const NetWorthWidgetSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsContainer(
      title: "net-worth-total-widget".tr(),
      description: "select-accounts-and-time-period".tr(),
      onTap: () {
        openNetWorthSettings(context);
      },
      icon: appStateSettings["outlinedIcons"]
          ? Icons.area_chart_outlined
          : Icons.area_chart_rounded,
    );
  }
}
