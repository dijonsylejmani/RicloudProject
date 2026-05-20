import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(context),
            _buildHeroSection(context),
            _buildStatsSection(context),
            _buildBookingWidget(context),
            _buildPopularRoutes(context),
            _buildHowItWorks(context),
            _buildLiveMapSection(context),
            _buildTestimonials(context),
            _buildFeaturesBar(),
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  // ─── HEADER ────────────────────────────────────────────────
  Widget _buildHeader(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;
    return Container(
      color: AppColors.darkBlue,
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 40, vertical: 16),
      child: Row(
        children: [
          Image.asset('images/RiTravel.png', height: isMobile ? 30 : 40),
          if (!isMobile) const Spacer(),
          if (!isMobile) ...[
            _navItem(context, 'Ballina', '/', active: true),
            _navItem(context, 'Linjat', '/routes'),
            _navItem(context, 'Rezervo', '/booking'),
            _navItem(context, 'Ndiq Live', '/live_track'),
            _navItem(context, 'Rreth Nesh', '/about'),
            _navItem(context, 'Kontakt', '/contact'),
          ],
          const Spacer(),
          if (!isMobile) ...[
            GestureDetector(
              onTap: () => _showAuthModal(context),
              child: const Row(
                children: [
                  Icon(Icons.account_circle_outlined, color: Colors.white, size: 22),
                  SizedBox(width: 8),
                  Text('Hyr / Regjistrohu', style: TextStyle(color: Colors.white, fontSize: 14)),
                ],
              ),
            ),
            const SizedBox(width: 20),
            _goldButton('Rezervo Tani', () => Navigator.pushNamed(context, '/booking')),
          ],
          if (isMobile)
            IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () => _showMobileMenu(context),
            ),
        ],
      ),
    );
  }

  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.darkBlue,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(2))),
              const SizedBox(height: 24),
              _mobileNavItem(ctx, Icons.home_rounded, 'Ballina', '/'),
              _mobileNavItem(ctx, Icons.map_rounded, 'Linjat', '/routes'),
              _mobileNavItem(ctx, Icons.confirmation_number_rounded, 'Rezervo', '/booking'),
              _mobileNavItem(ctx, Icons.near_me_rounded, 'Ndiq Live', '/live_track'),
              _mobileNavItem(ctx, Icons.info_rounded, 'Rreth Nesh', '/about'),
              _mobileNavItem(ctx, Icons.phone_rounded, 'Kontakt', '/contact'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(ctx);
                  Navigator.pushNamed(ctx, '/booking');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryGold,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Rezervo Tani', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _mobileNavItem(BuildContext context, IconData icon, String title, String route) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primaryGold, size: 26),
      title: Text(title, style: const TextStyle(color: Colors.white, fontSize: 18)),
      trailing: const Icon(Icons.chevron_right, color: Colors.white38),
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, route);
      },
    );
  }

  Widget _navItem(BuildContext context, String title, String route, {bool active = false}) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, route),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title, style: TextStyle(
              color: active ? AppColors.primaryGold : Colors.white,
              fontWeight: active ? FontWeight.bold : FontWeight.w500,
              fontSize: 15,
            )),
            if (active) Container(margin: const EdgeInsets.only(top: 4), height: 2, width: 24, color: AppColors.primaryGold),
          ],
        ),
      ),
    );
  }

  void _showAuthModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => const _AuthModal(),
    );
  }

  // ─── HERO ──────────────────────────────────────────────────
  Widget _buildHeroSection(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;
    return Container(
      height: isMobile ? 450 : 580,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage('images/autobusi.png'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black.withValues(alpha: 0.55), BlendMode.darken),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(isMobile ? 20 : 60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.primaryGold.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.primaryGold.withValues(alpha: 0.5)),
              ),
              child: const Text('TRANSPORTI NË KOSOVË', style: TextStyle(color: AppColors.primaryGold, fontSize: 12, letterSpacing: 2, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 24),
            Text('Udhëto me\nRi Travel',
              style: TextStyle(color: Colors.white, fontSize: isMobile ? 42 : 60, fontWeight: FontWeight.bold, height: 1.1)),
            const SizedBox(height: 16),
            Text('Bileta autobusi në të gjithë Kosovën.\nShpejt, sigurt dhe komod.',
              style: TextStyle(color: Colors.white.withValues(alpha: 0.85), fontSize: isMobile ? 16 : 20, height: 1.5)),
            const SizedBox(height: 32),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/booking'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryGold, foregroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: isMobile ? 28 : 40, vertical: 18),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 8, shadowColor: AppColors.primaryGold.withValues(alpha: 0.5),
                  ),
                  child: Text('Rezervo Biletë', style: TextStyle(fontSize: isMobile ? 16 : 18, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(width: 16),
                OutlinedButton(
                  onPressed: () => Navigator.pushNamed(context, '/routes'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white, side: const BorderSide(color: Colors.white38),
                    padding: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 32, vertical: 18),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Shiko Linjat', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ─── STATS ─────────────────────────────────────────────────
  Widget _buildStatsSection(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;
    return Container(
      color: AppColors.bgLight,
      padding: EdgeInsets.symmetric(vertical: isMobile ? 32 : 48, horizontal: isMobile ? 16 : 60),
      child: isMobile
          ? Column(children: [
              _statItem(Icons.directions_bus_outlined, '120+', 'Autobusë modernë'),
              _statItem(Icons.map_outlined, '250+', 'Linja të disponueshme'),
              _statItem(Icons.people_outline, '50K+', 'Udhëtarë të kënaqur'),
              _statItem(Icons.verified_user_outlined, '100%', 'Udhëtim i sigurt'),
            ].expand((w) => [w, const SizedBox(height: 20)]).toList()..removeLast())
          : Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              _statItem(Icons.directions_bus_outlined, '120+', 'Autobusë modernë'),
              _statItem(Icons.map_outlined, '250+', 'Linja të disponueshme'),
              _statItem(Icons.people_outline, '50K+', 'Udhëtarë të kënaqur'),
              _statItem(Icons.verified_user_outlined, '100%', 'Udhëtim i sigurt'),
            ]),
    );
  }

  Widget _statItem(IconData icon, String number, String label) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Container(padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: AppTheme.cardShadow),
        child: Icon(icon, color: AppColors.primaryGold, size: 28)),
      const SizedBox(width: 16),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(number, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.darkBlue)),
        Text(label, style: const TextStyle(color: AppColors.textGrey, fontSize: 14)),
      ]),
    ]);
  }

  // ─── BOOKING ───────────────────────────────────────────────
  Widget _buildBookingWidget(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;
    return Container(
      padding: EdgeInsets.all(isMobile ? 16 : 60),
      child: Column(children: [
        _sectionHeader('Rezervo udhëtimin tënd'),
        const SizedBox(height: 24),
        Container(
          width: isMobile ? double.infinity : 800,
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.shade100), boxShadow: AppTheme.elevatedShadow),
          child: Column(children: [
            Row(children: [
              _tabItem('Biletë një drejtim', active: true),
              const SizedBox(width: 30),
              _tabItem('Biletë vajtje-ardhje'),
            ]),
            const SizedBox(height: 20),
            const Divider(height: 1),
            const SizedBox(height: 20),
            Row(children: [
              Expanded(child: _miniField('Nga', 'Prishtina', Icons.location_on_outlined)),
              const SizedBox(width: 10),
              Expanded(child: _miniField('Ku', 'Zgjidh destinacionin', Icons.location_on_outlined)),
              const SizedBox(width: 10),
              Expanded(child: _miniField('Data', '25 Maj 2025', Icons.calendar_today)),
              if (!isMobile) ...[const SizedBox(width: 10), Expanded(child: _miniField('Pasagjerë', '1 Person', Icons.person_outline))],
            ]),
            const SizedBox(height: 24),
            SizedBox(width: double.infinity, height: 52,
              child: ElevatedButton.icon(
                onPressed: () => Navigator.pushNamed(context, '/booking'),
                icon: const Icon(Icons.search, color: Colors.black),
                label: const Text('Kërko Linja', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryGold,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)))),
            ),
          ]),
        ),
      ]),
    );
  }

  Widget _tabItem(String text, {bool active = false}) {
    return Row(children: [
      Icon(Icons.directions_bus, size: 18, color: active ? AppColors.primaryGold : Colors.grey),
      const SizedBox(width: 8),
      Text(text, style: TextStyle(color: active ? AppColors.textDark : Colors.grey, fontSize: 14, fontWeight: active ? FontWeight.bold : FontWeight.normal)),
    ]);
  }

  Widget _miniField(String label, String value, IconData icon) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: const TextStyle(color: AppColors.textGrey, fontSize: 12)),
      const SizedBox(height: 8),
      Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(10)),
        child: Row(children: [
          Expanded(child: Text(value, style: const TextStyle(color: AppColors.textDark, fontSize: 14))),
          Icon(icon, color: AppColors.textGrey, size: 18),
        ])),
    ]);
  }

  // ─── POPULAR ROUTES ────────────────────────────────────────
  Widget _buildPopularRoutes(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;
    return Container(
      color: AppColors.bgLight,
      padding: EdgeInsets.all(isMobile ? 16 : 60),
      child: Column(children: [
        _sectionHeader('Linjat më të njohura'),
        const SizedBox(height: 24),
        isMobile
          ? Column(children: [  _routeCard(context, 'Prishtinë', 'Pejë', '08:00', '1 orë 20 min', '€7.00'), _routeCard(context, 'Prishtinë', 'Gjakovë', '09:30', '1 orë 45 min', '€8.00'), _routeCard(context, 'Prishtinë', 'Prizren', '10:30', '1 orë 30 min', '€6.00')])
          : Row(children: [
              Expanded(child: _routeCard(context, 'Prishtinë', 'Pejë', '08:00', '1 orë 20 min', '€7.00')),
              const SizedBox(width: 16),
              Expanded(child: _routeCard(context, 'Prishtinë', 'Gjakovë', '09:30', '1 orë 45 min', '€8.00')),
              const SizedBox(width: 16),
              Expanded(child: _routeCard(context, 'Prishtinë', 'Prizren', '10:30', '1 orë 30 min', '€6.00')),
            ]),
        const SizedBox(height: 24),
        Center(
          child: TextButton.icon(
            onPressed: () => Navigator.pushNamed(context, '/routes'),
            icon: const Text('Shiko të gjitha linjat', style: TextStyle(fontSize: 16)),
            label: const Icon(Icons.arrow_forward, size: 18),
            style: TextButton.styleFrom(foregroundColor: AppColors.primaryGold)),
        ),
      ]),
    );
  }

  Widget _routeCard(BuildContext context, String from, String to, String time, String duration, String price) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100), boxShadow: AppTheme.cardShadow),
      child: Row(children: [
        Container(padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: AppColors.darkBlue, borderRadius: BorderRadius.circular(12)),
          child: const Icon(Icons.directions_bus, color: Colors.white, size: 24)),
        const SizedBox(width: 16),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('$from → $to', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.textDark)),
          const SizedBox(height: 6),
          Row(children: [
            const Icon(Icons.access_time, size: 14, color: AppColors.textGrey), const SizedBox(width: 4),
            Text('$time  |  $duration', style: const TextStyle(fontSize: 13, color: AppColors.textGrey)),
          ]),
        ])),
        Column(children: [
          Text(price, style: const TextStyle(color: AppColors.primaryGold, fontWeight: FontWeight.bold, fontSize: 20)),
          const SizedBox(height: 4),
          ElevatedButton(onPressed: () => Navigator.pushNamed(context, '/booking'),
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.darkBlue, foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
            child: const Text('Detajet', style: TextStyle(fontSize: 12))),
        ]),
      ]),
    );
  }

  // ─── HOW IT WORKS ──────────────────────────────────────────
  Widget _buildHowItWorks(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;
    return Container(
      padding: EdgeInsets.all(isMobile ? 16 : 60),
      child: Column(children: [
        _sectionHeader('Si funksionon?'),
        const SizedBox(height: 32),
        isMobile
          ? Column(children: [
              _stepItem('1', 'Kërko linjën', 'Zgjidh qytetin e nisjes, destinacionin dhe datën e udhëtimit.'),
              _stepItem('2', 'Zgjidh ulësen', 'Shiko disponueshmërinë dhe zgjidh ulësen tënde të preferuar në autobus.'),
              _stepItem('3', 'Paguaj & Udhëto', 'Paguaj online në mënyrë të sigurt dhe merr biletën tënde digitale.'),
            ])
          : Row(children: [
              Expanded(child: _stepItem('1', 'Kërko linjën', 'Zgjidh qytetin e nisjes, destinacionin dhe datën e udhëtimit.')),
              const SizedBox(width: 20),
              Expanded(child: _stepItem('2', 'Zgjidh ulësen', 'Shiko disponueshmërinë dhe zgjidh ulësen tënde të preferuar në autobus.')),
              const SizedBox(width: 20),
              Expanded(child: _stepItem('3', 'Paguaj & Udhëto', 'Paguaj online në mënyrë të sigurt dhe merr biletën tënde digitale.')),
            ]),
      ]),
    );
  }

  Widget _stepItem(String nr, String title, String desc) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100), boxShadow: AppTheme.cardShadow),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(width: 48, height: 48,
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [AppColors.darkBlue, Color(0xFF1A2744)], begin: Alignment.topLeft, end: Alignment.bottomRight),
            borderRadius: BorderRadius.circular(14)),
          child: Center(child: Text(nr, style: const TextStyle(color: AppColors.primaryGold, fontWeight: FontWeight.bold, fontSize: 20)))),
        const SizedBox(width: 16),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColors.textDark)),
          const SizedBox(height: 6),
          Text(desc, style: const TextStyle(color: AppColors.textGrey, fontSize: 14, height: 1.5)),
        ])),
      ]),
    );
  }

  // ─── LIVE MAP ──────────────────────────────────────────────
  Widget _buildLiveMapSection(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;
    return Container(
      color: AppColors.bgLight,
      padding: EdgeInsets.all(isMobile ? 16 : 60),
      child: Column(children: [
        Row(children: [
          Container(padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: Colors.green.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
            child: const Icon(Icons.near_me, color: Colors.green, size: 24)),
          const SizedBox(width: 16),
          const Expanded(child: Text('Ndiq autobusin tënd live', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textDark))),
          TextButton(onPressed: () => Navigator.pushNamed(context, '/live_track'), child: const Text('Shiko më shumë →', style: TextStyle(color: AppColors.primaryGold))),
        ]),
        const SizedBox(height: 24),
        Container(
          height: isMobile ? 300 : 400,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), boxShadow: AppTheme.elevatedShadow),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(children: [
              FlutterMap(
                options: const MapOptions(initialCenter: LatLng(42.6629, 21.1655), initialZoom: 12),
                children: [
                  TileLayer(urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', subdomains: const ['a', 'b', 'c']),
                  MarkerLayer(markers: [
                    Marker(point: const LatLng(42.6629, 21.1655), width: 80, height: 80,
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        Container(padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(color: AppColors.darkBlue, borderRadius: BorderRadius.circular(12),
                            boxShadow: [BoxShadow(color: AppColors.darkBlue.withValues(alpha: 0.4), blurRadius: 10, offset: const Offset(0, 4))]),
                          child: const Icon(Icons.directions_bus, color: Colors.white, size: 24)),
                        const SizedBox(height: 4),
                        Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8),
                            boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 4)]),
                          child: const Text('Ri Travel', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold))),
                      ])),
                  ]),
                ],
              ),
              Positioned(right: 16, top: 16,
                child: GestureDetector(
                  onTap: () => _openGoogleMaps(),
                  child: Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10),
                      boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 6)]),
                    child: const Row(mainAxisSize: MainAxisSize.min, children: [
                      Icon(Icons.open_in_new, color: AppColors.darkBlue, size: 16),
                      SizedBox(width: 6),
                      Text('Hap në Google Maps', style: TextStyle(color: AppColors.darkBlue, fontWeight: FontWeight.bold, fontSize: 12)),
                    ]))),
              ),
            ]),
          ),
        ),
      ]),
    );
  }

  Future<void> _openGoogleMaps() async {
    final uri = Uri.parse('https://maps.google.com/?q=Prishtin%C3%AB,Kosovo');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  // ─── TESTIMONIALS ──────────────────────────────────────────
  Widget _buildTestimonials(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;
    return Container(
      padding: EdgeInsets.all(isMobile ? 16 : 60),
      child: Column(children: [
        _sectionHeader('Çfarë thonë udhëtarët'),
        const SizedBox(height: 24),
        isMobile
          ? Column(children: [
              _testimonialCard('Besnik Krasniqi', 'Prishtinë', 'Shërbim i shkëlqyeshëm! Autobusët janë shumë të rehatshëm dhe në kohë.'),
              _testimonialCard('Ardita Gashi', 'Prizren', 'Rezervimi ishte shumë i lehtë dhe mbërrita në kohë pa asnjë problem.'),
            ])
          : Row(children: [
              Expanded(child: _testimonialCard('Besnik Krasniqi', 'Prishtinë', 'Shërbim i shkëlqyeshëm! Autobusët janë shumë të rehatshëm dhe në kohë. Rekomandoj 100%.')),
              const SizedBox(width: 20),
              Expanded(child: _testimonialCard('Ardita Gashi', 'Prizren', 'Rezervimi ishte shumë i lehtë dhe mbërrita në kohë pa asnjë problem.')),
              const SizedBox(width: 20),
              Expanded(child: _testimonialCard('Faton Mehmeti', 'Pejë', 'Udhëtoj çdo javë me Ri Travel. Profesionalizëm dhe siguri në çdo udhëtim.')),
            ]),
      ]),
    );
  }

  Widget _testimonialCard(String name, String city, String text) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100), boxShadow: AppTheme.cardShadow),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Icon(Icons.format_quote, color: AppColors.primaryGold, size: 36),
        const SizedBox(height: 12),
        Text(text, style: const TextStyle(color: AppColors.textGrey, fontSize: 14, height: 1.6)),
        const SizedBox(height: 16),
        Row(children: [
          CircleAvatar(backgroundColor: AppColors.darkBlue, radius: 20,
            child: Text(name[0], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
          const SizedBox(width: 12),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.textDark)),
            Text(city, style: const TextStyle(color: AppColors.textGrey, fontSize: 12)),
          ]),
        ]),
      ]),
    );
  }

  // ─── FEATURES ──────────────────────────────────────────────
  Widget _buildFeaturesBar() {
    return Container(
      color: AppColors.darkBlue,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 60),
      child: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return Column(children: [
            _featureItem(Icons.event_seat, 'Zgjidh ulësen'),
            _featureItem(Icons.payments_outlined, 'Pagesa fleksibile'),
            _featureItem(Icons.notifications_active_outlined, 'Njoftime reale'),
            _featureItem(Icons.security, 'Udhëtim i sigurt'),
          ].expand((w) => [w, const SizedBox(height: 16)]).toList()..removeLast());
        }
        return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          _featureItem(Icons.event_seat, 'Zgjidh ulësen tënde'),
          _featureItem(Icons.payments_outlined, 'Pagesa fleksibile'),
          _featureItem(Icons.notifications_active_outlined, 'Njoftime në kohë reale'),
          _featureItem(Icons.security, 'Udhëtim i sigurt'),
        ]);
      }),
    );
  }

  Widget _featureItem(IconData icon, String text) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Icon(icon, color: AppColors.primaryGold, size: 24),
      const SizedBox(width: 12),
      Text(text, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500)),
    ]);
  }

  // ─── FOOTER ────────────────────────────────────────────────
  Widget _buildFooter(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;
    return Container(
      padding: EdgeInsets.all(isMobile ? 24 : 48),
      color: const Color(0xFF070C17),
      child: Column(children: [
        isMobile
          ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _footerColumn('Rreth nesh', ['Ri Travel ofron shërbime cilësore transporti për udhëtarët në gjithë Kosovën.']),
              _footerColumn('Linjat e shpejta', ['Prishtinë - Prizren', 'Prishtinë - Pejë', 'Prishtinë - Gjakovë']),
              _footerColumn('Shërbimet', ['Booking Online', 'Live Tracking', 'Support 24/7']),
              _footerColumn('Kontakt', ['info@ritravel.com', '+383 49 123 456', 'Prishtinë, Kosovë']),
            ].expand((w) => [w, const SizedBox(height: 24)]).toList()..removeLast())
          : Row(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              _footerColumn('Rreth nesh', ['Ri Travel ofron shërbime cilësore transporti për udhëtarët në gjithë Kosovën.']),
              _footerColumn('Linjat e shpejta', ['Prishtinë - Prizren', 'Prishtinë - Pejë', 'Prishtinë - Gjakovë']),
              _footerColumn('Shërbimet', ['Booking Online', 'Live Tracking', 'Support 24/7']),
              _footerColumn('Kontakt', ['info@ritravel.com', '+383 49 123 456', 'Prishtinë, Kosovë']),
            ]),
        const SizedBox(height: 32),
        Divider(color: Colors.white.withValues(alpha: 0.1)),
        const SizedBox(height: 20),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset('images/RiTravel.png', height: 24),
          const SizedBox(width: 12),            Text('© 2025 Ri Travel. Të gjitha të drejtat e rezervuara.', style: TextStyle(color: Color(0x62FFFFFF), fontSize: 12)),
        ]),
      ]),
    );
  }

  Widget _footerColumn(String title, List<String> items) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
      const SizedBox(height: 12),
      ...items.map((item) => Padding(padding: const EdgeInsets.symmetric(vertical: 3),
        child: Text(item, style: const TextStyle(color: Color(0x8AFFFFFF), fontSize: 14)))),
    ]);
  }

  Widget _sectionHeader(String title) {
    return Row(children: [
      Text(title, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: AppColors.textDark)),
    ]);
  }

  Widget _goldButton(String text, VoidCallback onTap) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryGold, foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
    );
  }
}

// ─── AUTH MODAL ──────────────────────────────────────────────
class _AuthModal extends StatefulWidget {
  const _AuthModal();
  @override State<_AuthModal> createState() => _AuthModalState();
}

class _AuthModalState extends State<_AuthModal> {
  bool _isLogin = true;
  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Center(child: Container(width: 50, height: 4, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2)))),
            const SizedBox(height: 24),
            Row(children: [
              Expanded(child: _tabButton('Hyr', _isLogin, () => setState(() => _isLogin = true))),
              const SizedBox(width: 12),
              Expanded(child: _tabButton('Regjistrohu', !_isLogin, () => setState(() => _isLogin = false))),
            ]),
            const SizedBox(height: 28),
            Text(_isLogin ? 'Mirë se vini përsëri!' : 'Krijo llogarinë tënde', style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: AppColors.darkBlue)),
            const SizedBox(height: 8),
            Text(_isLogin ? 'Hyr në llogarinë tënde për të vazhduar' : "Plotëso të dhënat për t'u regjistruar", style: const TextStyle(color: AppColors.textGrey, fontSize: 15)),
            const SizedBox(height: 28),
            if (!_isLogin) ...[
              Row(children: [Expanded(child: _inputField('Emri', 'Emri juaj', Icons.person_outline)), const SizedBox(width: 12), Expanded(child: _inputField('Mbiemri', 'Mbiemri juaj', Icons.person_outline))]),
              const SizedBox(height: 16),
            ],
            _inputField('Email', 'email@example.com', Icons.email_outlined),
            const SizedBox(height: 16),
            _passwordField('Fjalëkalimi', _obscurePassword, () => setState(() => _obscurePassword = !_obscurePassword)),
            const SizedBox(height: 16),
            if (!_isLogin) ...[
              _passwordField('Konfirmo fjalëkalimin', _obscureConfirm, () => setState(() => _obscureConfirm = !_obscureConfirm)),
              const SizedBox(height: 16),
            ],
            if (_isLogin) Align(alignment: Alignment.centerRight, child: TextButton(onPressed: () {}, child: const Text('Keni harruar fjalëkalimin?', style: TextStyle(color: AppColors.primaryGold, fontWeight: FontWeight.w500)))),
            const SizedBox(height: 12),
            SizedBox(width: double.infinity, child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(_isLogin ? 'U kyçët me sukses!' : 'Llogaria u krijua me sukses!'),
                  backgroundColor: AppColors.success, behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))));
              },
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryGold, foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 18), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
              child: Text(_isLogin ? 'Hyr' : 'Regjistrohu', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)))),
            if (!_isLogin) ...[
              const SizedBox(height: 16),
              Row(children: [
                Checkbox(value: true, onChanged: (_) {}, activeColor: AppColors.primaryGold, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
                Expanded(child: RichText(text: TextSpan(style: const TextStyle(color: AppColors.textGrey, fontSize: 13), children: [
                  const TextSpan(text: 'Pranoj '),
                  TextSpan(text: 'Kushtet e përdorimit', style: const TextStyle(color: AppColors.primaryGold, fontWeight: FontWeight.bold)),
                  const TextSpan(text: ' dhe '),
                  TextSpan(text: 'Politikën e privatësisë', style: const TextStyle(color: AppColors.primaryGold, fontWeight: FontWeight.bold)),
                ]))),
              ]),
            ],
            const SizedBox(height: 24),
            const Center(child: Text('OSE', style: TextStyle(color: AppColors.textGrey, fontSize: 13, fontWeight: FontWeight.w600))),
            const SizedBox(height: 20),
            Row(children: [
              Expanded(child: _socialBtn('Google', Colors.red)), const SizedBox(width: 12),
              Expanded(child: _socialBtn('Facebook', Colors.blue)), const SizedBox(width: 12),
              Expanded(child: _socialBtn('Apple', Colors.black)),
            ]),
            const SizedBox(height: 24),
            Center(child: GestureDetector(
              onTap: () => setState(() => _isLogin = !_isLogin),
              child: RichText(text: TextSpan(style: const TextStyle(fontSize: 14, color: AppColors.textGrey), children: [
                TextSpan(text: _isLogin ? 'Nuk ke llogari? ' : 'Ke tashmë një llogari? '),
                TextSpan(text: _isLogin ? 'Regjistrohu' : 'Hyr këtu', style: const TextStyle(color: AppColors.primaryGold, fontWeight: FontWeight.bold)),
              ])))),
            const SizedBox(height: 20),
          ]),
        ),
      ),
    );
  }

  Widget _tabButton(String text, bool isActive, VoidCallback onTap) {
    return GestureDetector(onTap: onTap, child: Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(color: isActive ? AppColors.darkBlue : Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
      child: Center(child: Text(text, style: TextStyle(color: isActive ? Colors.white : AppColors.textGrey, fontWeight: FontWeight.bold, fontSize: 16)))));
  }

  Widget _inputField(String label, String hint, IconData icon) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: AppColors.textDark)),
      const SizedBox(height: 8),
      TextField(decoration: InputDecoration(
        hintText: hint, hintStyle: TextStyle(color: Colors.grey.shade400),
        prefixIcon: Icon(icon, color: AppColors.textGrey, size: 20),
        filled: true, fillColor: AppColors.bgLight,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade200)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade200)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.primaryGold, width: 2)),
        contentPadding: const EdgeInsets.symmetric(vertical: 16))),
    ]);
  }

  Widget _passwordField(String label, bool obscure, VoidCallback toggle) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: AppColors.textDark)),
      const SizedBox(height: 8),
      TextField(obscureText: obscure, decoration: InputDecoration(
        hintText: label, hintStyle: TextStyle(color: Colors.grey.shade400),
        prefixIcon: const Icon(Icons.lock_outline, color: AppColors.textGrey, size: 20),
        suffixIcon: IconButton(icon: Icon(obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: AppColors.textGrey, size: 20), onPressed: toggle),
        filled: true, fillColor: AppColors.bgLight,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade200)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade200)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.primaryGold, width: 2)),
        contentPadding: const EdgeInsets.symmetric(vertical: 16))),
    ]);
  }

  Widget _socialBtn(String platform, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(12)),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(Icons.circle, size: 18, color: color),
        const SizedBox(width: 8),
        Text(platform, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
      ]));
  }
}
