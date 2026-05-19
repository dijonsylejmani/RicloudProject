import 'package:flutter/material.dart';
import '../constants.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(context),
            _buildHeroSection(isMobile),
            _buildMissionSection(isMobile),
            _buildValuesSection(isMobile),
            _buildTeamSection(isMobile),
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

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
            _navItem(context, 'Ballina', '/'),
            _navItem(context, 'Linjat', '/routes'),
            _navItem(context, 'Rezervo', '/booking'),
            _navItem(context, 'Ndiq Live', '/live_track'),
            _navItem(context, 'Rreth Nesh', '/about', active: true),
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
            if (active)
              Container(margin: const EdgeInsets.only(top: 4), height: 2, width: 24, color: AppColors.primaryGold),
          ],
        ),
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
      trailing: const Icon(Icons.chevron_right, color: Color(0x62FFFFFF)),
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, route);
      },
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

  Widget _buildHeroSection(bool isMobile) {
    return Container(
      height: isMobile ? 300 : 400,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage('images/autobusi.png'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black.withValues(alpha: 0.55), BlendMode.darken),
        ),
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(isMobile ? 20 : 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('RRETH NESH', style: TextStyle(color: AppColors.primaryGold, fontSize: 14, letterSpacing: 4, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Text('Ri Travel', style: TextStyle(fontSize: isMobile ? 40 : 52, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 12),
              Text('Shërbimi më i mirë i transportit në Kosovë',
                style: TextStyle(color: Colors.white70, fontSize: isMobile ? 16 : 20),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMissionSection(bool isMobile) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 24 : 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Misioni ynë', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.darkBlue)),
          const SizedBox(height: 20),
          const Text(
            'Ri Travel ofron shërbime cilësore të transportit për udhëtarët në gjithë Kosovën. Me një flotë moderne të autobusëve dhe shërbim klienti 24/7, ne jemi përgjegjës për të bërë udhëtimin tuaj të këndshëm dhe të sigurt.',
            style: TextStyle(fontSize: 16, height: 1.8, color: AppColors.textGrey),
          ),
          const SizedBox(height: 32),
          isMobile
              ? Column(children: [
                  _statBox('120+', 'Autobusë'),
                  const SizedBox(height: 16),
                  _statBox('250+', 'Linja'),
                  const SizedBox(height: 16),
                  _statBox('50K+', 'Udhëtarë'),
                ])
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _statBox('120+', 'Autobusë modernë'),
                    _statBox('250+', 'Linja të disponueshme'),
                    _statBox('50K+', 'Udhëtarë të kënaqur'),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _statBox(String number, String label) {
    return Container(
      width: 200,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
      decoration: BoxDecoration(
        color: AppColors.primaryGold.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primaryGold.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Text(number, style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: AppColors.darkBlue)),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(color: AppColors.textGrey, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildValuesSection(bool isMobile) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 24 : 60),
      color: AppColors.bgLight,
      child: Column(
        children: [
          const Text('Vlerat tona', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.darkBlue)),
          const SizedBox(height: 40),
          isMobile
              ? Column(children: [
                  _valueCard(Icons.shield_outlined, 'Siguria', 'Siguria e pasagjerëve është prioriteti ynë kryesor. Të gjithë autobusët janë të pajisur me teknologjinë më të fundit.'),
                  const SizedBox(height: 16),
                  _valueCard(Icons.access_time, 'Preciziteti', 'Respektojmë oraret dhe garantojmë nisje dhe mbërritje në kohë për të gjitha linjat tona.'),
                  const SizedBox(height: 16),
                  _valueCard(Icons.emoji_emotions_outlined, 'Kënaqësia', 'Pasagjerët tanë janë në qendër të çdo vendimi. Përpiqemi të ofrojmë përvojën më të mirë të udhëtimit.'),
                ])
              : Row(
                  children: [
                    Expanded(child: _valueCard(Icons.shield_outlined, 'Siguria', 'Siguria e pasagjerëve është prioriteti ynë kryesor.')),
                    const SizedBox(width: 20),
                    Expanded(child: _valueCard(Icons.access_time, 'Preciziteti', 'Respektojmë oraret dhe garantojmë nisje dhe mbërritje në kohë.')),
                    const SizedBox(width: 20),
                    Expanded(child: _valueCard(Icons.emoji_emotions_outlined, 'Kënaqësia', 'Ofrojmë përvojën më të mirë të udhëtimit për çdo pasagjer.')),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _valueCard(IconData icon, String title, String desc) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.darkBlue,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: AppColors.primaryGold, size: 32),
          ),
          const SizedBox(height: 20),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColors.darkBlue)),
          const SizedBox(height: 12),
          Text(desc, style: const TextStyle(color: AppColors.textGrey, fontSize: 14, height: 1.5), textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget _buildTeamSection(bool isMobile) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 24 : 60),
      child: Column(
        children: [
          const Text('Na kontaktoni', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.darkBlue)),
          const SizedBox(height: 12),
          const Text('Jemi këtu për t\'ju ndihmuar', style: TextStyle(color: AppColors.textGrey, fontSize: 16)),
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.darkBlue, Color(0xFF1A2744)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            child: isMobile
                ? Column(
                    children: [
                      _contactItem(Icons.email_outlined, 'Email', 'info@ritravel-ks.com'),
                      const SizedBox(height: 20),
                      _contactItem(Icons.phone_outlined, 'Telefon', '+383 44 123 456'),
                      const SizedBox(height: 20),
                      _contactItem(Icons.location_on_outlined, 'Adresa', 'Prishtinë, Kosovë'),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _contactItem(Icons.email_outlined, 'Email', 'info@ritravel-ks.com'),
                      _contactItem(Icons.phone_outlined, 'Telefon', '+383 44 123 456'),
                      _contactItem(Icons.location_on_outlined, 'Adresa', 'Prishtinë, Kosovë'),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _contactItem(IconData icon, String label, String value) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.primaryGold.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: AppColors.primaryGold, size: 28),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: Colors.white54, fontSize: 12)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
      ],
    );
  }

  Widget _buildFooter(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;
    return Container(
      padding: EdgeInsets.all(isMobile ? 24 : 48),
      color: const Color(0xFF070C17),
      child: Column(
        children: [
          isMobile
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _footerColumn('Rreth nesh', ['Ri Travel ofron shërbime cilësore transporti', 'për udhëtarët në gjithë Kosovën.']),
                    const SizedBox(height: 24),
                    _footerColumn('Linjat e shpejta', ['Prishtinë - Prizren', 'Prishtinë - Pejë', 'Prishtinë - Gjakovë']),
                    const SizedBox(height: 24),
                    _footerColumn('Shërbimet', ['Booking Online', 'Live Tracking', 'Support 24/7']),
                    const SizedBox(height: 24),
                    _footerColumn('Kontakt', ['info@ritravel.com', '+383 49 123 456', 'Prishtinë, Kosovë']),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _footerColumn('Rreth nesh', ['Ri Travel ofron shërbime cilësore transporti', 'për udhëtarët në gjithë Kosovën.']),
                    _footerColumn('Linjat e shpejta', ['Prishtinë - Prizren', 'Prishtinë - Pejë', 'Prishtinë - Gjakovë']),
                    _footerColumn('Shërbimet', ['Booking Online', 'Live Tracking', 'Support 24/7']),
                    _footerColumn('Kontakt', ['info@ritravel.com', '+383 49 123 456', 'Prishtinë, Kosovë']),
                  ],
                ),
          const SizedBox(height: 32),
          Divider(color: Colors.white.withValues(alpha: 0.1)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('images/RiTravel.png', height: 24),
              const SizedBox(width: 12),
              Text('© 2025 Ri Travel. Të gjitha të drejtat e rezervuara.', style: TextStyle(color: Color(0x62FFFFFF), fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _footerColumn(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        ...items.map((item) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: Text(item, style: const TextStyle(color: Color(0x8AFFFFFF), fontSize: 14)),
        )),
      ],
    );
  }

  Widget _goldButton(String text, VoidCallback onTap) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryGold,
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
    );
  }
}

class _AuthModal extends StatefulWidget {
  const _AuthModal();

  @override
  State<_AuthModal> createState() => _AuthModalState();
}

class _AuthModalState extends State<_AuthModal> {
  bool _isLogin = true;
  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(width: 50, height: 4, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2))),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(child: _tabButton('Hyr', _isLogin, () => setState(() => _isLogin = true))),
                  const SizedBox(width: 12),
                  Expanded(child: _tabButton('Regjistrohu', !_isLogin, () => setState(() => _isLogin = false))),
                ],
              ),
              const SizedBox(height: 28),
              Text(
                _isLogin ? 'Mirë se vini përsëri!' : 'Krijo llogarinë tënde',
                style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: AppColors.darkBlue),
              ),
              const SizedBox(height: 8),
              Text(
                _isLogin ? 'Hyr në llogarinë tënde për të vazhduar' : 'Plotëso të dhënat për t\'u regjistruar',
                style: const TextStyle(color: AppColors.textGrey, fontSize: 15),
              ),
              const SizedBox(height: 28),
              if (!_isLogin) ...[
                Row(
                  children: [
                    Expanded(child: _inputField('Emri', 'Emri juaj', Icons.person_outline)),
                    const SizedBox(width: 12),
                    Expanded(child: _inputField('Mbiemri', 'Mbiemri juaj', Icons.person_outline)),
                  ],
                ),
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
              if (_isLogin)
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text('Keni harruar fjalëkalimin?', style: TextStyle(color: AppColors.primaryGold, fontWeight: FontWeight.w500)),
                  ),
                ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(_isLogin ? 'U kyçët me sukses!' : 'Llogaria u krijua me sukses!'),
                        backgroundColor: AppColors.success,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryGold,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  child: Text(_isLogin ? 'Hyr' : 'Regjistrohu', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                ),
              ),
              if (!_isLogin) ...[
                const SizedBox(height: 16),
                Row(
                  children: [
                    Checkbox(value: true, onChanged: (_) {}, activeColor: AppColors.primaryGold, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: const TextStyle(color: AppColors.textGrey, fontSize: 13),
                          children: [
                            const TextSpan(text: 'Pranoj '),
                            TextSpan(text: 'Kushtet e përdorimit', style: TextStyle(color: AppColors.primaryGold, fontWeight: FontWeight.bold)),
                            const TextSpan(text: ' dhe '),
                            TextSpan(text: 'Politikën e privatësisë', style: TextStyle(color: AppColors.primaryGold, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 24),
              const Center(child: Text('OSE', style: TextStyle(color: AppColors.textGrey, fontSize: 13, fontWeight: FontWeight.w600))),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(child: _socialBtn('Google', Colors.red)),
                  const SizedBox(width: 12),
                  Expanded(child: _socialBtn('Facebook', Colors.blue)),
                  const SizedBox(width: 12),
                  Expanded(child: _socialBtn('Apple', Colors.black)),
                ],
              ),
              const SizedBox(height: 24),
              Center(
                child: GestureDetector(
                  onTap: () => setState(() => _isLogin = !_isLogin),
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(fontSize: 14, color: AppColors.textGrey),
                      children: [
                        TextSpan(text: _isLogin ? 'Nuk ke llogari? ' : 'Ke tashmë një llogari? '),
                        TextSpan(
                          text: _isLogin ? 'Regjistrohu' : 'Hyr këtu',
                          style: const TextStyle(color: AppColors.primaryGold, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tabButton(String text, bool isActive, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isActive ? AppColors.darkBlue : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(text, style: TextStyle(
            color: isActive ? Colors.white : AppColors.textGrey,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          )),
        ),
      ),
    );
  }

  Widget _inputField(String label, String hint, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: AppColors.textDark)),
        const SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey.shade400),
            prefixIcon: Icon(icon, color: AppColors.textGrey, size: 20),
            filled: true,
            fillColor: AppColors.bgLight,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade200)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade200)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.primaryGold, width: 2)),
            contentPadding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ],
    );
  }

  Widget _passwordField(String label, bool obscure, VoidCallback toggle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: AppColors.textDark)),
        const SizedBox(height: 8),
        TextField(
          obscureText: obscure,
          decoration: InputDecoration(
            hintText: label,
            hintStyle: TextStyle(color: Colors.grey.shade400),
            prefixIcon: const Icon(Icons.lock_outline, color: AppColors.textGrey, size: 20),
            suffixIcon: IconButton(icon: Icon(obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: AppColors.textGrey, size: 20), onPressed: toggle),
            filled: true,
            fillColor: AppColors.bgLight,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade200)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade200)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.primaryGold, width: 2)),
            contentPadding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ],
    );
  }

  Widget _socialBtn(String platform, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.circle, size: 18, color: color),
          const SizedBox(width: 8),
          Text(platform, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
        ],
      ),
    );
  }
}
