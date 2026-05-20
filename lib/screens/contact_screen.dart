import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: SingleChildScrollView(child: Column(children: [
        _buildHeader(context), _buildHeroBanner(isMobile),
        Padding(padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 60, vertical: isMobile ? 16 : 40),
          child: isMobile
            ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                _buildContactInfo(), const SizedBox(height: 20), _buildContactForm(context), const SizedBox(height: 20), _buildMapAndHelp(), const SizedBox(height: 20), _buildFaq(context),
              ])
            : Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Expanded(flex: 1, child: Column(children: [_buildContactInfo(), const SizedBox(height: 20), _buildFaq(context)])),
                const SizedBox(width: 30),
                Expanded(flex: 2, child: _buildContactForm(context)),
                const SizedBox(width: 30),
                Expanded(flex: 1, child: _buildMapAndHelp()),
              ])),
        _buildFooter(context),
      ])),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;
    return Container(color: AppColors.darkBlue,
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 40, vertical: 16),
      child: Row(children: [
        Image.asset('images/RiTravel.png', height: isMobile ? 30 : 40),
        if (!isMobile) const Spacer(),
        if (!isMobile) ...[
          _navItem(context, 'Ballina', '/'), _navItem(context, 'Linjat', '/routes'), _navItem(context, 'Rezervo', '/booking'),
          _navItem(context, 'Ndiq Live', '/live_track'), _navItem(context, 'Rreth Nesh', '/about'), _navItem(context, 'Kontakt', '/contact', active: true),
        ],
        const Spacer(),
        if (!isMobile) ...[
          GestureDetector(onTap: () => _showAuthModal(context), child: const Row(children: [
            Icon(Icons.account_circle_outlined, color: Colors.white, size: 22), SizedBox(width: 8),
            Text('Hyr / Regjistrohu', style: TextStyle(color: Colors.white, fontSize: 14)),
          ])),
          const SizedBox(width: 20),
          _goldButton('Rezervo Tani', () => Navigator.pushNamed(context, '/booking')),
        ],
        if (isMobile) IconButton(icon: const Icon(Icons.menu, color: Colors.white), onPressed: () => _showMobileMenu(context)),
      ]),
    );
  }

  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet(context: context, backgroundColor: AppColors.darkBlue,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) => SafeArea(child: Padding(padding: const EdgeInsets.all(24),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(2))),
          const SizedBox(height: 24),
          _mobileNavItem(ctx, Icons.home_rounded, 'Ballina', '/'), _mobileNavItem(ctx, Icons.map_rounded, 'Linjat', '/routes'),
          _mobileNavItem(ctx, Icons.confirmation_number_rounded, 'Rezervo', '/booking'), _mobileNavItem(ctx, Icons.near_me_rounded, 'Ndiq Live', '/live_track'),
          _mobileNavItem(ctx, Icons.info_rounded, 'Rreth Nesh', '/about'), _mobileNavItem(ctx, Icons.phone_rounded, 'Kontakt', '/contact'),
      ]))));
  }

  Widget _mobileNavItem(BuildContext context, IconData icon, String title, String route) {
    return ListTile(leading: Icon(icon, color: AppColors.primaryGold, size: 26), title: Text(title, style: const TextStyle(color: Colors.white, fontSize: 18)),
      trailing: const Icon(Icons.chevron_right, color: Color(0x62FFFFFF)), onTap: () { Navigator.pop(context); Navigator.pushNamed(context, route); });
  }

  Widget _navItem(BuildContext context, String title, String route, {bool active = false}) {
    return GestureDetector(onTap: () => Navigator.pushNamed(context, route),
      child: Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: Column(mainAxisSize: MainAxisSize.min, children: [
        Text(title, style: TextStyle(color: active ? AppColors.primaryGold : Colors.white, fontWeight: active ? FontWeight.bold : FontWeight.w500, fontSize: 15)),
        if (active) Container(margin: const EdgeInsets.only(top: 4), height: 2, width: 24, color: AppColors.primaryGold),
      ])));
  }

  void _showAuthModal(BuildContext context) {
    showModalBottomSheet(context: context, isScrollControlled: true, backgroundColor: Colors.transparent, builder: (ctx) => const _AuthModal());
  }

  Widget _buildHeroBanner(bool isMobile) {
    return Container(
      height: isMobile ? 200 : 250, width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage('images/autobusi.png'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black.withValues(alpha: 0.55), BlendMode.darken),
        ),
      ),
      child: Padding(padding: EdgeInsets.all(isMobile ? 24 : 60),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text('KONTAKTONI', style: TextStyle(color: Colors.white54, fontSize: 14, letterSpacing: 2, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text.rich(TextSpan(style: TextStyle(fontSize: isMobile ? 28 : 40, fontWeight: FontWeight.bold), children: [
            TextSpan(text: 'Jemi këtu ', style: TextStyle(color: Colors.white)),
            TextSpan(text: "për t'ju ndihmuar!", style: TextStyle(color: AppColors.primaryGold)),
          ])),
          const SizedBox(height: 12),
          Text("Keni pyetje apo nevojë për ndihmë? Na kontaktoni.", style: TextStyle(color: Colors.white60, fontSize: isMobile ? 14 : 16)),
        ])),
    );
  }

  Widget _buildContactInfo() {
    return Container(padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade100), boxShadow: AppTheme.cardShadow),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Informacioni i kontaktit', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textDark)),
        const SizedBox(height: 24),
        _infoItem(Icons.phone_rounded, 'Na telefononi', '+383 44 123 456', 'E Hënë - E Dielë: 08:00 - 20:00'),
        const Divider(height: 32),
        _infoItem(Icons.email_rounded, 'Na shkruani', 'info@ritravel-ks.com', 'Përgjigjemi brenda 24 orëve'),
        const Divider(height: 32),
        _infoItem(Icons.location_on_rounded, 'Adresa jonë', 'Rr. Nëna Terezë, Nr. 45', '10000 Prishtinë, Kosovë'),
      ]),
    );
  }

  Widget _infoItem(IconData icon, String title, String val1, String val2) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: AppColors.darkBlue, borderRadius: BorderRadius.circular(12)),
        child: Icon(icon, color: AppColors.primaryGold, size: 22)),
      const SizedBox(width: 16),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.textDark)),
        const SizedBox(height: 4), Text(val1, style: const TextStyle(fontSize: 14, color: AppColors.textDark)),
        const SizedBox(height: 2), Text(val2, style: const TextStyle(color: AppColors.textGrey, fontSize: 12)),
      ])),
    ]);
  }

  Widget _buildContactForm(BuildContext context) {
    return Container(padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade100), boxShadow: AppTheme.cardShadow),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text("Na dërgoni një mesazh", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textDark)),
        const SizedBox(height: 24),
        Row(children: [Expanded(child: _textField('Emri juaj', Icons.person_outline)), const SizedBox(width: 16), Expanded(child: _textField('Email juaj', Icons.email_outlined))]),
        const SizedBox(height: 16),
        _textField('Subjekti', Icons.subject),
        const SizedBox(height: 16),
        TextField(maxLines: 5,
          decoration: InputDecoration(hintText: 'Mesazhi juaj...', hintStyle: TextStyle(color: Colors.grey.shade400),
            prefixIcon: const Padding(padding: EdgeInsets.only(bottom: 80), child: Icon(Icons.edit_outlined, color: AppColors.textGrey)),
            filled: true, fillColor: AppColors.bgLight,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade200)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.primaryGold, width: 2)))),
        const SizedBox(height: 24),
        SizedBox(width: double.infinity, child: ElevatedButton.icon(
          onPressed: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text('Mesazhi u dërgua me sukses!'), backgroundColor: AppColors.success, behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)))),
          icon: const Icon(Icons.send_rounded, color: Colors.black),
          label: const Text('Dërgo mesazhin', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryGold, padding: const EdgeInsets.symmetric(vertical: 18),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))))),
      ]),
    );
  }

  Widget _textField(String hint, IconData icon) {
    return TextField(decoration: InputDecoration(hintText: hint, hintStyle: TextStyle(color: Colors.grey.shade400),
      prefixIcon: Icon(icon, color: AppColors.textGrey, size: 20), filled: true, fillColor: AppColors.bgLight,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade200)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade200)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.primaryGold, width: 2))));
  }

  Widget _buildMapAndHelp() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        const Text('Harta Interaktive', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textDark)),
        const Spacer(),
        GestureDetector(onTap: () => _openGoogleMaps(),
          child: Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5), decoration: BoxDecoration(color: AppColors.primaryGold, borderRadius: BorderRadius.circular(8)),
            child: const Row(mainAxisSize: MainAxisSize.min, children: [
              Icon(Icons.open_in_new, color: Colors.black, size: 14), SizedBox(width: 4),
              Text('Hap Map', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12)),
            ]))),
      ]),
      const SizedBox(height: 16),
      Container(height: 280, decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), boxShadow: AppTheme.cardShadow),
        child: ClipRRect(borderRadius: BorderRadius.circular(16),
          child: FlutterMap(
            options: const MapOptions(initialCenter: LatLng(42.6629, 21.1655), initialZoom: 13),
            children: [
              TileLayer(urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', subdomains: const ['a', 'b', 'c']),
              MarkerLayer(markers: [
                Marker(point: const LatLng(42.6629, 21.1655), width: 80, height: 80,
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Icon(Icons.location_on, color: AppColors.primaryGold, size: 40),
                    Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)), child: const Text('Ri Travel', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold))),
                  ])),
              ]),
            ],
          )),
      ),
      const SizedBox(height: 16),
    ]);
  }

  Widget _buildFaq(BuildContext context) {
    return Container(padding: const EdgeInsets.all(24), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100), boxShadow: AppTheme.cardShadow),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Pyetje të shpeshta', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textDark)),
        const SizedBox(height: 20),
        _faqItem('Si mund të rezervoj biletë?', 'Zgjidh linjën, datën dhe ulësen, pastaj vazhdo me pagesën.'),
        const SizedBox(height: 16),
        _faqItem('Cilat janë mënyrat e pagesës?', 'Pagesa me kartë krediti, PayPal ose në pikëshitje.'),
        const SizedBox(height: 16),
        _faqItem('Si mund të anuloj rezervimin?', 'Na kontaktoni në email për anulime dhe rimbursime.'),
      ]),
    );
  }

  Widget _faqItem(String q, String a) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(margin: const EdgeInsets.only(top: 3), width: 6, height: 6, decoration: const BoxDecoration(color: AppColors.primaryGold, shape: BoxShape.circle)),
        const SizedBox(width: 12),
        Expanded(child: Text(q, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.textDark))),
      ]),
      const SizedBox(height: 6),
      Text(a, style: const TextStyle(color: AppColors.textGrey, fontSize: 13, height: 1.4)),
    ]);
  }

  Future<void> _openGoogleMaps() async {
    final uri = Uri.parse('https://maps.google.com/?q=Prishtin%C3%AB,Kosovo');
    if (await canLaunchUrl(uri)) await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  Widget _buildFooter(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;
    return Container(padding: EdgeInsets.all(isMobile ? 24 : 48), color: const Color(0xFF070C17), child: Column(children: [
      isMobile
        ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            _footerColumn('Rreth nesh', ['Ri Travel ofron shërbime cilësore transporti.']),
            _footerColumn('Linjat', ['Prishtinë - Prizren', 'Prishtinë - Pejë', 'Prishtinë - Gjakovë']),
            _footerColumn('Shërbimet', ['Booking Online', 'Live Tracking', 'Support 24/7']),
            _footerColumn('Kontakt', ['info@ritravel.com', '+383 49 123 456', 'Prishtinë, Kosovë']),
          ].expand((w) => [w, const SizedBox(height: 24)]).toList()..removeLast())
        : Row(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            _footerColumn('Rreth nesh', ['Ri Travel ofron shërbime cilësore transporti.']),
            _footerColumn('Linjat', ['Prishtinë - Prizren', 'Prishtinë - Pejë', 'Prishtinë - Gjakovë']),
            _footerColumn('Shërbimet', ['Booking Online', 'Live Tracking', 'Support 24/7']),
            _footerColumn('Kontakt', ['info@ritravel.com', '+383 49 123 456', 'Prishtinë, Kosovë']),
          ]),
      const SizedBox(height: 32), Divider(color: Colors.white.withValues(alpha: 0.1)), const SizedBox(height: 20),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image.asset('images/RiTravel.png', height: 24), const SizedBox(width: 12),
        Text('© 2025 Ri Travel. Të gjitha të drejtat e rezervuara.', style: TextStyle(color: Color(0x62FFFFFF), fontSize: 12)),
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
    return ElevatedButton(onPressed: onTap, style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryGold, foregroundColor: Colors.black,
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
    return Container(height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      child: SingleChildScrollView(child: Padding(padding: const EdgeInsets.all(28), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Center(child: Container(width: 50, height: 4, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2)))),
        const SizedBox(height: 24),
        Row(children: [Expanded(child: _tab('Hyr', _isLogin, () => setState(() => _isLogin = true))), const SizedBox(width: 12), Expanded(child: _tab('Regjistrohu', !_isLogin, () => setState(() => _isLogin = false)))]),
        const SizedBox(height: 28),
        Text(_isLogin ? 'Mirë se vini!' : 'Krijo llogari', style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: AppColors.darkBlue)),
        const SizedBox(height: 20),
        if (!_isLogin) ...[Row(children: [Expanded(child: _inp('Emri', Icons.person_outline)), const SizedBox(width: 12), Expanded(child: _inp('Mbiemri', Icons.person_outline))]), const SizedBox(height: 16)],
        _inp('Email', Icons.email_outlined), const SizedBox(height: 16),
        _pw('Fjalëkalimi', _obscurePassword, () => setState(() => _obscurePassword = !_obscurePassword)),
        if (!_isLogin) ...[const SizedBox(height: 16), _pw('Konfirmo', _obscureConfirm, () => setState(() => _obscureConfirm = !_obscureConfirm))],
        const SizedBox(height: 24),
        SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(_isLogin ? 'U kyçët!' : 'Llogaria u krijua!'), backgroundColor: AppColors.success, behavior: SnackBarBehavior.floating, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))));
        }, style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryGold, foregroundColor: Colors.black, padding: const EdgeInsets.symmetric(vertical: 18), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
          child: Text(_isLogin ? 'Hyr' : 'Regjistrohu', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)))),
        const SizedBox(height: 24),
        Center(child: GestureDetector(onTap: () => setState(() => _isLogin = !_isLogin),
          child: RichText(text: TextSpan(style: const TextStyle(fontSize: 14, color: AppColors.textGrey), children: [
            TextSpan(text: _isLogin ? 'Nuk ke llogari? ' : 'Ke llogari? '),
            TextSpan(text: _isLogin ? 'Regjistrohu' : 'Hyr', style: const TextStyle(color: AppColors.primaryGold, fontWeight: FontWeight.bold)),
          ])))),
      ]))));
  }

  Widget _tab(String t, bool a, VoidCallback o) => GestureDetector(onTap: o, child: Container(padding: const EdgeInsets.symmetric(vertical: 14),
    decoration: BoxDecoration(color: a ? AppColors.darkBlue : Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
    child: Center(child: Text(t, style: TextStyle(color: a ? Colors.white : AppColors.textGrey, fontWeight: FontWeight.bold, fontSize: 16)))));

  Widget _inp(String h, IconData i) => TextField(decoration: InputDecoration(hintText: h, prefixIcon: Icon(i, color: AppColors.textGrey, size: 20), filled: true, fillColor: AppColors.bgLight,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade200)),
    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.primaryGold, width: 2))));

  Widget _pw(String h, bool o, VoidCallback t) => TextField(obscureText: o, decoration: InputDecoration(hintText: h, prefixIcon: const Icon(Icons.lock_outline, color: AppColors.textGrey, size: 20),
    suffixIcon: IconButton(icon: Icon(o ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: AppColors.textGrey, size: 20), onPressed: t),
    filled: true, fillColor: AppColors.bgLight, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade200)),
    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.primaryGold, width: 2))));
}
