import 'package:flutter/material.dart';
import '../constants.dart';

class LinjatScreen extends StatefulWidget {
  const LinjatScreen({super.key});
  @override State<LinjatScreen> createState() => _LinjatScreenState();
}

class _LinjatScreenState extends State<LinjatScreen> {
  List<Map<String, dynamic>> linjat = [
    {"nga": "Prishtinë", "ne": "Prizren", "ora": "08:00", "kohezgjatja": "1 orë 30 min", "ulese": 16, "cmimi": "€6.00"},
    {"nga": "Prishtinë", "ne": "Pejë", "ora": "09:30", "kohezgjatja": "1 orë 45 min", "ulese": 12, "cmimi": "€7.00"},
    {"nga": "Prishtinë", "ne": "Gjakovë", "ora": "10:30", "kohezgjatja": "1 orë 20 min", "ulese": 18, "cmimi": "€6.00"},
    {"nga": "Prishtinë", "ne": "Mitrovicë", "ora": "12:00", "kohezgjatja": "1 orë 15 min", "ulese": 20, "cmimi": "€5.00"},
    {"nga": "Prishtinë", "ne": "Ferizaj", "ora": "13:00", "kohezgjatja": "1 orë 10 min", "ulese": 14, "cmimi": "€5.00"},
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: SingleChildScrollView(child: Column(children: [
        _buildHeader(context),
        _buildHeroBanner(isMobile),
        Padding(padding: EdgeInsets.all(isMobile ? 16 : 40),
          child: Column(children: [
            _buildSearchSection(isMobile),
            const SizedBox(height: 24),
            _buildMainList(isMobile),
          ])),
        _buildFooter(context),
      ])),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;
    return Container(color: AppColors.darkBlue, padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 40, vertical: 16),
      child: Row(children: [
        Image.asset('images/RiTravel.png', height: isMobile ? 30 : 40),
        if (!isMobile) const Spacer(),
        if (!isMobile) ...[
          _navItem(context, 'Ballina', '/'), _navItem(context, 'Linjat', '/routes', active: true),
          _navItem(context, 'Rezervo', '/booking'), _navItem(context, 'Ndiq Live', '/live_track'),
          _navItem(context, 'Rreth Nesh', '/about'), _navItem(context, 'Kontakt', '/contact'),
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
      builder: (ctx) => SafeArea(child: Padding(padding: const EdgeInsets.all(24), child: Column(mainAxisSize: MainAxisSize.min, children: [
        Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(2))), const SizedBox(height: 24),
        _mobileNavItem(ctx, Icons.home_rounded, 'Ballina', '/'), _mobileNavItem(ctx, Icons.map_rounded, 'Linjat', '/routes'),
        _mobileNavItem(ctx, Icons.confirmation_number_rounded, 'Rezervo', '/booking'), _mobileNavItem(ctx, Icons.near_me_rounded, 'Ndiq Live', '/live_track'),
        _mobileNavItem(ctx, Icons.info_rounded, 'Rreth Nesh', '/about'), _mobileNavItem(ctx, Icons.phone_rounded, 'Kontakt', '/contact'),
      ]))));
  }

  Widget _mobileNavItem(BuildContext context, IconData icon, String title, String route) {
    return ListTile(leading: Icon(icon, color: AppColors.primaryGold, size: 26), title: Text(title, style: const TextStyle(color: Colors.white, fontSize: 18)),
      trailing: const Icon(Icons.chevron_right, color: Colors.white38), onTap: () { Navigator.pop(context); Navigator.pushNamed(context, route); });
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
    return Container(height: isMobile ? 160 : 200, width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage('images/autobusi.png'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black.withValues(alpha: 0.55), BlendMode.darken),
        ),
      ),
      child: Padding(padding: EdgeInsets.all(isMobile ? 20 : 60),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('Linjat e autobusave', style: TextStyle(color: Colors.white, fontSize: isMobile ? 28 : 36, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Row(children: [Text('Ballina', style: TextStyle(color: AppColors.primaryGold, fontSize: 13)), const Icon(Icons.chevron_right, color: Colors.white54, size: 16), const Text('Linjat', style: TextStyle(color: Colors.white54, fontSize: 13))]),
        ])),
    );
  }

  Widget _buildSearchSection(bool isMobile) {
    return Container(padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade100), boxShadow: AppTheme.cardShadow),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Kërko linja', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textDark)),
        const SizedBox(height: 16),
        isMobile
          ? Column(children: [
              _searchField('Nga', Icons.location_on_outlined),
              const SizedBox(height: 12),
              _searchField('Në', Icons.location_on_outlined),
              const SizedBox(height: 12),
              _searchField('Data', Icons.calendar_today),
            ])
          : Row(children: [
              Expanded(child: _searchField('Nga', Icons.location_on_outlined)),
              const SizedBox(width: 12),
              Expanded(child: _searchField('Në', Icons.location_on_outlined)),
              const SizedBox(width: 12),
              Expanded(child: _searchField('Data e udhëtimit', Icons.calendar_today)),
              const SizedBox(width: 12),
              Expanded(child: _searchField('Pasagjerë', Icons.person_outline)),
            ]),
        const SizedBox(height: 16),
        SizedBox(width: double.infinity, child: ElevatedButton.icon(
          onPressed: () {}, icon: const Icon(Icons.search, color: Colors.white),
          label: const Text('Kërko Linja', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.darkBlue, padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))))),
      ]),
    );
  }

  Widget _searchField(String placeholder, IconData icon) {
    return Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(10)),
      child: Row(children: [
        Icon(icon, color: AppColors.textGrey, size: 18), const SizedBox(width: 8),
        Text(placeholder, style: const TextStyle(color: AppColors.textGrey, fontWeight: FontWeight.w500)),
        const Spacer(), const Icon(Icons.keyboard_arrow_down, color: AppColors.textGrey, size: 18),
      ]));
  }

  Widget _buildMainList(bool isMobile) {
    return Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(children: [
          const Text('Linjat e Disponueshme', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textDark)),
          const SizedBox(width: 12),
          Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(color: AppColors.primaryGold.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(12)),
            child: Text('24 Linja', style: TextStyle(color: AppColors.primaryGold, fontWeight: FontWeight.bold, fontSize: 12))),
        ]),
        if (!isMobile)
          Row(children: [
            const Text('Rendit sipas ', style: TextStyle(color: AppColors.textGrey, fontSize: 13)),
            Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(8), color: Colors.white),
              child: Row(children: const [Text('Ora e nisjes', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)), SizedBox(width: 8), Icon(Icons.keyboard_arrow_down, size: 16)])),
          ]),
      ]),
      const SizedBox(height: 20),
      ...linjat.map((linja) => _buildBusCard(linja, isMobile)),
      const SizedBox(height: 24),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        _pageBtn(Icons.chevron_left, false), const SizedBox(width: 4),
        _pageNr('1', true), _pageNr('2', false), _pageNr('3', false),
        const Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: Text('...', style: TextStyle(color: AppColors.textGrey))),
        _pageNr('5', false), const SizedBox(width: 4), _pageBtn(Icons.chevron_right, false),
      ]),
    ]);
  }

  Widget _buildBusCard(Map<String, dynamic> data, bool isMobile) {
    return Container(margin: const EdgeInsets.only(bottom: 12), padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade100), boxShadow: AppTheme.cardShadow),
      child: Column(children: [
        Row(children: [
          Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: AppColors.darkBlue, borderRadius: BorderRadius.circular(12)),
            child: const Icon(Icons.directions_bus, color: Colors.white, size: 24)),
          const SizedBox(width: 16),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Text(data['nga'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.textDark)),
              const Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: Icon(Icons.arrow_forward, color: AppColors.textGrey, size: 16)),
              Text(data['ne'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.textDark)),
            ]),
            const SizedBox(height: 8),
            isMobile
              ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [const Icon(Icons.access_time, size: 14, color: AppColors.textGrey), const SizedBox(width: 4), Text('${data['ora']}  |  ${data['kohezgjatja']}', style: const TextStyle(color: AppColors.textGrey, fontSize: 13))]),
                  const SizedBox(height: 4),
                  Row(children: [const Icon(Icons.event_seat, size: 14, color: Colors.green), const SizedBox(width: 4), Text('${data['ulese']} vende të lira', style: const TextStyle(color: Colors.green, fontSize: 13, fontWeight: FontWeight.bold))]),
                ])
              : Row(children: [
                  Row(children: [const Icon(Icons.access_time, size: 14, color: AppColors.textGrey), const SizedBox(width: 4), Text(data['ora'], style: const TextStyle(color: AppColors.textGrey, fontSize: 13))]),
                  Padding(padding: const EdgeInsets.symmetric(horizontal: 12), child: Text('|', style: TextStyle(color: Colors.grey.shade300))),
                  Row(children: [const Icon(Icons.timer_outlined, size: 14, color: AppColors.textGrey), const SizedBox(width: 4), Text(data['kohezgjatja'], style: const TextStyle(color: AppColors.textGrey, fontSize: 13))]),
                  Padding(padding: const EdgeInsets.symmetric(horizontal: 12), child: Text('|', style: TextStyle(color: Colors.grey.shade300))),
                  Row(children: [const Icon(Icons.event_seat, size: 14, color: Colors.green), const SizedBox(width: 4), Text('${data['ulese']} vende', style: const TextStyle(color: Colors.green, fontSize: 13, fontWeight: FontWeight.bold))]),
                ]),
          ])),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text(data['cmimi'], style: TextStyle(color: AppColors.primaryGold, fontSize: isMobile ? 20 : 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            SizedBox(
              child: ElevatedButton(onPressed: () => Navigator.pushNamed(context, '/booking'),
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.darkBlue, foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: isMobile ? 10 : 16, vertical: isMobile ? 8 : 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                child: Text(isMobile ? 'Detajet' : 'Detajet e Linjës', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600))),
            ),
          ]),
        ]),
      ]),
    );
  }

  Widget _pageBtn(IconData icon, bool active) {
    return Container(margin: const EdgeInsets.symmetric(horizontal: 2), padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(8), color: Colors.white),
      child: Icon(icon, size: 16, color: AppColors.textGrey));
  }

  Widget _pageNr(String nr, bool active) {
    return Container(margin: const EdgeInsets.symmetric(horizontal: 2), padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(border: Border.all(color: active ? AppColors.darkBlue : Colors.grey.shade300), borderRadius: BorderRadius.circular(8), color: active ? AppColors.darkBlue : Colors.white),
      child: Text(nr, style: TextStyle(color: active ? Colors.white : AppColors.textGrey, fontWeight: active ? FontWeight.bold : FontWeight.normal, fontSize: 13)));
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
        Text('© 2025 Ri Travel. Të gjitha të drejtat e rezervuara.', style: TextStyle(color: Colors.white38, fontSize: 12)),
      ]),
    ]));
  }

  Widget _footerColumn(String title, List<String> items) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
      const SizedBox(height: 12),
      ...items.map((item) => Padding(padding: const EdgeInsets.symmetric(vertical: 3), child: Text(item, style: const TextStyle(color: Colors.white54, fontSize: 14)))),
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
        Text(_isLogin ? 'Mirë se vini!' : 'Krijo llogari', style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: AppColors.darkBlue)), const SizedBox(height: 20),
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
