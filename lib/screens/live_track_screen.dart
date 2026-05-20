import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants.dart';

class LiveTrackScreen extends StatefulWidget {
  const LiveTrackScreen({super.key});
  @override State<LiveTrackScreen> createState() => _LiveTrackScreenState();
}

class _LiveTrackScreenState extends State<LiveTrackScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: SingleChildScrollView(
        child: Column(children: [
          _buildHeader(context),
          _buildHeroBanner(),
          _buildMapSection(),
          _buildRouteInfo(),
          _buildFooter(context),
        ]),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;
    return Container(
      color: AppColors.darkBlue,
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 40, vertical: 16),
      child: Row(children: [
        Image.asset('images/RiTravel.png', height: isMobile ? 30 : 40),
        if (!isMobile) const Spacer(),
        if (!isMobile) ...[
          _navItem(context, 'Ballina', '/'),
          _navItem(context, 'Linjat', '/routes'),
          _navItem(context, 'Rezervo', '/booking'),
          _navItem(context, 'Ndiq Live', '/live_track', active: true),
          _navItem(context, 'Rreth Nesh', '/about'),
          _navItem(context, 'Kontakt', '/contact'),
        ],
        const Spacer(),
        if (!isMobile) ...[
          GestureDetector(
            onTap: () => _showAuthModal(context),
            child: const Row(children: [
              Icon(Icons.account_circle_outlined, color: Colors.white, size: 22),
              SizedBox(width: 8),
              Text('Hyr / Regjistrohu', style: TextStyle(color: Colors.white, fontSize: 14)),
            ]),
          ),
          const SizedBox(width: 20),
          _goldButton('Rezervo Tani', () => Navigator.pushNamed(context, '/booking')),
        ],
        if (isMobile) IconButton(icon: const Icon(Icons.menu, color: Colors.white), onPressed: () => _showMobileMenu(context)),
      ]),
    );
  }

  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context, backgroundColor: AppColors.darkBlue,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) => SafeArea(child: Padding(padding: const EdgeInsets.all(24),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(2))),
          const SizedBox(height: 24),
          _mobileNavItem(ctx, Icons.home_rounded, 'Ballina', '/'),
          _mobileNavItem(ctx, Icons.map_rounded, 'Linjat', '/routes'),
          _mobileNavItem(ctx, Icons.confirmation_number_rounded, 'Rezervo', '/booking'),
          _mobileNavItem(ctx, Icons.near_me_rounded, 'Ndiq Live', '/live_track'),
          _mobileNavItem(ctx, Icons.info_rounded, 'Rreth Nesh', '/about'),
          _mobileNavItem(ctx, Icons.phone_rounded, 'Kontakt', '/contact'),
      ]))));
  }

  Widget _mobileNavItem(BuildContext context, IconData icon, String title, String route) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primaryGold, size: 26),
      title: Text(title, style: const TextStyle(color: Colors.white, fontSize: 18)),
      trailing: const Icon(Icons.chevron_right, color: Color(0x62FFFFFF)),
      onTap: () { Navigator.pop(context); Navigator.pushNamed(context, route); });
  }

  Widget _navItem(BuildContext context, String title, String route, {bool active = false}) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, route),
      child: Padding(padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text(title, style: TextStyle(color: active ? AppColors.primaryGold : Colors.white, fontWeight: active ? FontWeight.bold : FontWeight.w500, fontSize: 15)),
          if (active) Container(margin: const EdgeInsets.only(top: 4), height: 2, width: 24, color: AppColors.primaryGold),
      ])));
  }

  void _showAuthModal(BuildContext context) {
    showModalBottomSheet(context: context, isScrollControlled: true, backgroundColor: Colors.transparent, builder: (ctx) => const _AuthModal());
  }

  Widget _buildHeroBanner() {
    final isMobile = MediaQuery.of(context).size.width < 800;
    return Container(
      height: isMobile ? 180 : 220,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage('images/autobusi.png'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black.withValues(alpha: 0.55), BlendMode.darken),
        ),
      ),
      child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text('NDIQ AUTOBUSIN LIVE', style: TextStyle(color: Colors.white, fontSize: isMobile ? 24 : 36, fontWeight: FontWeight.bold, letterSpacing: 2)),
        const SizedBox(height: 12),
        Text('Shiko pozitën e autobusit në kohë reale', style: TextStyle(color: AppColors.primaryGold, fontSize: isMobile ? 14 : 18)),
      ])),
    );
  }

  Widget _buildMapSection() {
    final isMobile = MediaQuery.of(context).size.width < 800;
    return Padding(
      padding: EdgeInsets.all(isMobile ? 16 : 40),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.green.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
            child: const Icon(Icons.my_location, color: Colors.green, size: 24)),
          const SizedBox(width: 12),
          const Text('Pozita aktuale e autobusit', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textDark)),
        ]),
        const SizedBox(height: 20),
        Container(
          height: isMobile ? 350 : 450,
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
                          decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(12),
                            boxShadow: [BoxShadow(color: Colors.green.withValues(alpha: 0.4), blurRadius: 10, offset: const Offset(0, 4))]),
                          child: const Icon(Icons.directions_bus, color: Colors.white, size: 24)),
                        Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                          child: const Text('Autobusi #1', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                        ),
                      ])),
                    Marker(point: const LatLng(42.6180, 21.1300), width: 80, height: 80,
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        Container(padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(12),
                            boxShadow: [BoxShadow(color: Colors.orange.withValues(alpha: 0.4), blurRadius: 8)]),
                          child: const Icon(Icons.directions_bus, color: Colors.white, size: 20)),
                        Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6)),
                          child: const Text('Autobusi #2', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold))),
                      ])),
                  ]),
                ],
              ),
              Positioned(right: 16, top: 16,
                child: GestureDetector(
                  onTap: () => _openGoogleMaps(),
                  child: Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                    child: const Row(mainAxisSize: MainAxisSize.min, children: [
                      Icon(Icons.open_in_new, color: AppColors.darkBlue, size: 16),
                      SizedBox(width: 6),
                      Text('Hap në Google Maps', style: TextStyle(color: AppColors.darkBlue, fontWeight: FontWeight.bold, fontSize: 12)),
                    ]))),
              ),
              Positioned(left: 16, bottom: 16,
                child: Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle)),
                    const SizedBox(width: 6),
                    const Text('Në lëvizje', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                    const SizedBox(width: 16),
                    Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.orange, shape: BoxShape.circle)),
                    const SizedBox(width: 6),
                    const Text('Në stacion', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                  ]))),
            ])),
        ),
      ]),
    );
  }

  Future<void> _openGoogleMaps() async {
    final uri = Uri.parse('https://maps.google.com/?q=Prishtin%C3%AB,Kosovo');
    if (await canLaunchUrl(uri)) await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  Widget _buildRouteInfo() {
    final isMobile = MediaQuery.of(context).size.width < 800;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 60),
      child: Column(children: [
        Row(children: [
          const Text('Autobusët aktivë', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textDark)),
          const SizedBox(width: 12),
          Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(color: Colors.green.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(12)),
            child: const Text('3 aktivë', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold))),
        ]),
        const SizedBox(height: 20),
        isMobile
          ? Column(children: [_busInfoCard('Prishtinë → Prizren', '08:00', 'Duke udhëtuar', '45% e rrugës', Colors.green), _busInfoCard('Prishtinë → Pejë', '09:30', 'Duke udhëtuar', '30% e rrugës', Colors.orange), _busInfoCard('Prishtinë → Gjakovë', '10:30', 'Në stacion', 'Gati për nisje', Colors.blue)])
          : Row(children: [
              Expanded(child: _busInfoCard('Prishtinë → Prizren', '08:00', 'Duke udhëtuar', '45% e rrugës', Colors.green)),
              const SizedBox(width: 16),
              Expanded(child: _busInfoCard('Prishtinë → Pejë', '09:30', 'Duke udhëtuar', '30% e rrugës', Colors.orange)),
              const SizedBox(width: 16),
              Expanded(child: _busInfoCard('Prishtinë → Gjakovë', '10:30', 'Në stacion', 'Gati për nisje', Colors.blue)),
            ]),
        const SizedBox(height: 40),
      ]),
    );
  }

  Widget _busInfoCard(String route, String time, String status, String detail, Color statusColor) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100), boxShadow: AppTheme.cardShadow),
      child: Row(children: [
        Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: AppColors.darkBlue, borderRadius: BorderRadius.circular(12)),
          child: const Icon(Icons.directions_bus, color: Colors.white, size: 28)),
        const SizedBox(width: 16),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(route, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.textDark)),
          const SizedBox(height: 4),
          Row(children: [const Icon(Icons.access_time, size: 14, color: AppColors.textGrey), const SizedBox(width: 4), Text(time, style: const TextStyle(color: AppColors.textGrey))]),
        ])),
        Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(color: statusColor.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(8)),
            child: Text(status, style: TextStyle(color: statusColor, fontWeight: FontWeight.bold, fontSize: 12))),
          const SizedBox(height: 4),
          Text(detail, style: const TextStyle(color: AppColors.textGrey, fontSize: 12)),
        ]),
      ]),
    );
  }

  Widget _buildFooter(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;
    return Container(padding: EdgeInsets.all(isMobile ? 24 : 48), color: const Color(0xFF070C17),
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
        const SizedBox(height: 32), Divider(color: Colors.white.withValues(alpha: 0.1)), const SizedBox(height: 20),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset('images/RiTravel.png', height: 24), const SizedBox(width: 12),
          Text('© 2025 Ri Travel. Të gjitha të drejtat e rezervuara.', style: TextStyle(color: Colors.white38, fontSize: 12)),
        ]),
      ]));
  }

  Widget _footerColumn(String title, List<String> items) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
      const SizedBox(height: 12),
      ...items.map((item) => Padding(padding: const EdgeInsets.symmetric(vertical: 3), child: Text(item, style: const TextStyle(color: Color(0x8AFFFFFF), fontSize: 14)))),
    ]);
  }

  Widget _goldButton(String text, VoidCallback onTap) {
    return ElevatedButton(onPressed: onTap,
      style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryGold, foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)));
  }
}

class _AuthModal extends StatefulWidget {
  const _AuthModal();
  @override State<_AuthModal> createState() => _AuthModalState();
}

class _AuthModalState extends State<_AuthModal> {
  bool _isLogin = true, _obscurePassword = true, _obscureConfirm = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      child: SingleChildScrollView(child: Padding(padding: const EdgeInsets.all(28),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Center(child: Container(width: 50, height: 4, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2)))),
          const SizedBox(height: 24),
          Row(children: [Expanded(child: _tabBtn('Hyr', _isLogin, () => setState(() => _isLogin = true))), const SizedBox(width: 12), Expanded(child: _tabBtn('Regjistrohu', !_isLogin, () => setState(() => _isLogin = false)))]),
          const SizedBox(height: 28),
          Text(_isLogin ? 'Mirë se vini përsëri!' : 'Krijo llogarinë tënde', style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: AppColors.darkBlue)),
          const SizedBox(height: 8),
          Text(_isLogin ? 'Hyr në llogarinë tënde' : "Plotëso të dhënat", style: const TextStyle(color: AppColors.textGrey, fontSize: 15)),
          const SizedBox(height: 28),
          if (!_isLogin) ...[
            Row(children: [Expanded(child: _inp('Emri', 'Emri', Icons.person_outline)), const SizedBox(width: 12), Expanded(child: _inp('Mbiemri', 'Mbiemri', Icons.person_outline))]),
            const SizedBox(height: 16),
          ],
          _inp('Email', 'email@example.com', Icons.email_outlined),
          const SizedBox(height: 16),
          _pwField('Fjalëkalimi', _obscurePassword, () => setState(() => _obscurePassword = !_obscurePassword)),
          if (!_isLogin) ...[const SizedBox(height: 16), _pwField('Konfirmo', _obscureConfirm, () => setState(() => _obscureConfirm = !_obscureConfirm))],
          if (_isLogin) Align(alignment: Alignment.centerRight, child: TextButton(onPressed: () {}, child: const Text('Keni harruar fjalëkalimin?', style: TextStyle(color: AppColors.primaryGold)))),
          const SizedBox(height: 20),
          SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(_isLogin ? 'U kyçët!' : 'Llogaria u krijua!'), backgroundColor: AppColors.success, behavior: SnackBarBehavior.floating, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))));
          }, style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryGold, foregroundColor: Colors.black, padding: const EdgeInsets.symmetric(vertical: 18), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
            child: Text(_isLogin ? 'Hyr' : 'Regjistrohu', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)))),
          const SizedBox(height: 24), const Center(child: Text('OSE', style: TextStyle(color: AppColors.textGrey, fontSize: 13))),
          const SizedBox(height: 20),
          Row(children: [Expanded(child: _social('Google', Colors.red)), const SizedBox(width: 12), Expanded(child: _social('Facebook', Colors.blue)), const SizedBox(width: 12), Expanded(child: _social('Apple', Colors.black))]),
          Center(child: GestureDetector(onTap: () => setState(() => _isLogin = !_isLogin),
            child: RichText(text: TextSpan(style: const TextStyle(fontSize: 14, color: AppColors.textGrey), children: [
              TextSpan(text: _isLogin ? 'Nuk ke llogari? ' : 'Ke llogari? '),
              TextSpan(text: _isLogin ? 'Regjistrohu' : 'Hyr këtu', style: const TextStyle(color: AppColors.primaryGold, fontWeight: FontWeight.bold)),
            ])))),
      ]))),
    );
  }

  Widget _tabBtn(String t, bool a, VoidCallback o) => GestureDetector(onTap: o, child: Container(padding: const EdgeInsets.symmetric(vertical: 14),
    decoration: BoxDecoration(color: a ? AppColors.darkBlue : Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
    child: Center(child: Text(t, style: TextStyle(color: a ? Colors.white : AppColors.textGrey, fontWeight: FontWeight.bold, fontSize: 16)))));

  Widget _inp(String l, String h, IconData i) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(l, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: AppColors.textDark)),
    const SizedBox(height: 8),
    TextField(decoration: InputDecoration(hintText: h, prefixIcon: Icon(i, color: AppColors.textGrey, size: 20), filled: true, fillColor: AppColors.bgLight,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade200)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.primaryGold, width: 2))))]);

  Widget _pwField(String l, bool o, VoidCallback t) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(l, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: AppColors.textDark)),
    const SizedBox(height: 8),
    TextField(obscureText: o, decoration: InputDecoration(hintText: l, prefixIcon: const Icon(Icons.lock_outline, color: AppColors.textGrey, size: 20),
      suffixIcon: IconButton(icon: Icon(o ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: AppColors.textGrey, size: 20), onPressed: t),
      filled: true, fillColor: AppColors.bgLight, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade200)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.primaryGold, width: 2))))]);

  Widget _social(String p, Color c) => Container(padding: const EdgeInsets.symmetric(vertical: 14),
    decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(12)),
    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.circle, size: 18, color: c), const SizedBox(width: 8), Text(p, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13))]));
}
