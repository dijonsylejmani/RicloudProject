import 'package:flutter/material.dart';
import '../constants.dart';

class RezervoScreen extends StatefulWidget {
  const RezervoScreen({super.key});

  @override
  State<RezervoScreen> createState() => _RezervoScreenState();
}

class _RezervoScreenState extends State<RezervoScreen> {
  List<int> selectedSeats = [14];
  List<int> bookedSeats = [32, 43];

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(context),
            _buildHeroBanner(),
            _buildStepper(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 60, vertical: 20),
              child: isMobile
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLinjaDetails(),
                      const SizedBox(height: 20),
                      _buildSeatSelection(),
                      const SizedBox(height: 20),
                      _buildSummaryAndPayment(),
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 1, child: _buildLinjaDetails()),
                      const SizedBox(width: 30),
                      Expanded(flex: 2, child: _buildSeatSelection()),
                      const SizedBox(width: 30),
                      Expanded(flex: 1, child: _buildSummaryAndPayment()),
                    ],
                  ),
            ),
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
          Image.asset('images/RiTravel.png', height: isMobile ? 30 : 40, errorBuilder: (c,e,s) => const Text('RI TRAVEL', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))), 
          if (!isMobile) const Spacer(),
          if (!isMobile) ...[
            _navItem(context, 'Ballina', '/'),
            _navItem(context, 'Linjat', '/routes'),
            _navItem(context, 'Rezervo', '/booking', active: true),
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
            _goldButton('Rezervo Tani', () {}),
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
            Text(title, style: TextStyle(color: active ? AppColors.primaryGold : Colors.white, fontWeight: active ? FontWeight.bold : FontWeight.w500, fontSize: 15)),
            if(active) Container(margin: const EdgeInsets.only(top: 4), height: 2, width: 24, color: AppColors.primaryGold),
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

  Widget _buildHeroBanner() {
    final isMobile = MediaQuery.of(context).size.width < 800;
    return Container(
      height: isMobile ? 120 : 150,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage('images/autobusi.png'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black.withValues(alpha: 0.55), BlendMode.darken),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: isMobile ? 20 : 60, top: isMobile ? 20 : 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('Rezervo ', style: TextStyle(color: Colors.white, fontSize: isMobile ? 24 : 36, fontWeight: FontWeight.bold)),
                Text('udhëtimin tënd', style: TextStyle(color: AppColors.primaryGold, fontSize: isMobile ? 24 : 36, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 8),
            Text('Zgjidh linjën, ulësen dhe përfundo rezervimin në pak hapa të thjeshtë.', style: TextStyle(color: Colors.white70, fontSize: isMobile ? 12 : 16)),
          ],
        ),
      ),
    );
  }

  Widget _buildStepper() {
    final isMobile = MediaQuery.of(context).size.width < 800;
    return Container(
      padding: EdgeInsets.symmetric(vertical: isMobile ? 16 : 30, horizontal: isMobile ? 8 : 60),
      color: Colors.white,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _stepIndicator(1, 'Linja', isCompleted: true),
            _stepConnector(isMobile),
            _stepIndicator(2, 'Ulësja', isActive: true),
            _stepConnector(isMobile),
            _stepIndicator(3, 'Të dhënat'),
            _stepConnector(isMobile),
            _stepIndicator(4, 'Pagesa'),
            _stepConnector(isMobile),
            _stepIndicator(5, 'Konfirmimi'),
          ],
        ),
      ),
    );
  }

  Widget _stepConnector(bool isMobile) {
    return Container(
      width: isMobile ? 20 : 40,
      child: Divider(color: Colors.grey.shade300, thickness: 2),
    );
  }

  Widget _stepIndicator(int step, String title, {bool isCompleted = false, bool isActive = false}) {
    return Row(
      children: [
        Container(
          width: 30, height: 30,
          decoration: BoxDecoration(
            color: isCompleted ? AppColors.darkBlue : (isActive ? AppColors.primaryGold : Colors.grey.shade200),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: isCompleted ? const Icon(Icons.check, color: Colors.white, size: 18) : Text('$step', style: TextStyle(color: isActive ? Colors.white : Colors.grey, fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(width: 10),
        Text(title, style: TextStyle(fontWeight: isActive || isCompleted ? FontWeight.bold : FontWeight.normal, color: isActive || isCompleted ? Colors.black : Colors.grey)),
      ],
    );
  }

  Widget _buildLinjaDetails() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade100), boxShadow: AppTheme.cardShadow),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Detajet e linjës', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: AppColors.darkBlue, borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const Text('PRISHTINË', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                      const SizedBox(height: 4),
                      const Text('Nisja', style: TextStyle(color: Colors.white54, fontSize: 12)),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Icon(Icons.arrow_forward, color: AppColors.primaryGold, size: 28),
                    const SizedBox(height: 4),
                    const Text('08:00', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ],
                ),
                Expanded(
                  child: Column(
                    children: [
                      const Text('PRIZREN', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                      const SizedBox(height: 4),
                      const Text('Mbërritja', style: TextStyle(color: Colors.white54, fontSize: 12)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _infoRow(Icons.calendar_today, 'Data', '25 Maj 2025'),
          _infoRow(Icons.access_time, 'Ora', '08:00'),
          _infoRow(Icons.timer_outlined, 'Kohëzgjatja', '1 orë 30 min'),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              'https://images.unsplash.com/photo-1612985452015-0e3e2b8c6f9c?w=400&q=80',
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (c, e, s) => Container(
                height: 120,
                color: AppColors.darkBlue,
                child: const Center(child: Icon(Icons.confirmation_number, color: Colors.white38, size: 48)),
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text('Informacioni i autobusit', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 16),
          _detailRow('Kompania', 'RI TRAVEL'),
          _detailRow('Lloji', 'Setra S 515 HD'),
          _detailRow('Kapaciteti', '49 ulëse'),
          const SizedBox(height: 16),
          const Text('Facilitetet', style: TextStyle(color: AppColors.textGrey, fontSize: 12)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 12,
            runSpacing: 8,
            children: [
              _facilityChip(Icons.wifi, 'Wi-Fi'),
              _facilityChip(Icons.ac_unit, 'AC'),
              _facilityChip(Icons.electrical_services, 'Prizë'),
              _facilityChip(Icons.wc, 'WC'),
            ],
          )
        ],
      ),
    );
  }

  Widget _facilityChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.bgLight,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.textGrey),
          const SizedBox(width: 4),
          Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textGrey)),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(color: AppColors.bgLight, borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, size: 16, color: AppColors.primaryGold),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(color: AppColors.textGrey, fontSize: 11)),
              Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: AppColors.textGrey, fontSize: 13)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildSeatSelection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade100), boxShadow: AppTheme.cardShadow),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Zgjidh ulësen tënde', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Row(
                children: [
                  _seatLegend(Colors.white, AppColors.success, 'E lirë'),
                  const SizedBox(width: 12),
                  _seatLegend(Colors.grey.shade300, Colors.grey, 'E zënë'),
                  const SizedBox(width: 12),
                  _seatLegend(AppColors.primaryGold, AppColors.primaryGold, 'E zgjedhur'),
                ],
              )
            ],
          ),
          const SizedBox(height: 30),
          Center(child: _buildBusLayout()),
          const SizedBox(height: 20),
          Center(
            child: OutlinedButton.icon(
              onPressed: (){},
              icon: const Icon(Icons.remove_red_eye_outlined),
              label: const Text('Pamje alternative'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.darkBlue,
                side: BorderSide(color: AppColors.primaryGold),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _seatLegend(Color fill, Color border, String label) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(width: 14, height: 14, decoration: BoxDecoration(color: fill, border: Border.all(color: border), borderRadius: BorderRadius.circular(3))),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textGrey)),
      ],
    );
  }

  Widget _buildBusLayout() {
    return Container(
      width: 300,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: Colors.grey.shade200, width: 2),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                Container(width: 30, height: 30, decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(4))),
                const SizedBox(width: 5),
                Container(width: 30, height: 30, decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(4))),
              ]),
              const Icon(Icons.drive_eta, size: 40, color: Colors.grey),
            ],
          ),
          const SizedBox(height: 30),
          for (int row = 0; row < 12; row++)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [_seatBtn((row * 4) + 1), const SizedBox(width: 10), _seatBtn((row * 4) + 2)]),
                  Text('${row + 1}', style: const TextStyle(color: AppColors.textGrey, fontSize: 11)),
                  Row(children: [_seatBtn((row * 4) + 3), const SizedBox(width: 10), _seatBtn((row * 4) + 4)]),
                ],
              ),
            )
        ],
      ),
    );
  }

  Widget _seatBtn(int seatNr) {
    bool isBooked = bookedSeats.contains(seatNr);
    bool isSelected = selectedSeats.contains(seatNr);

    Color fill = isSelected ? AppColors.primaryGold : (isBooked ? Colors.grey.shade300 : Colors.white);
    Color border = isSelected ? AppColors.primaryGold : (isBooked ? Colors.grey : AppColors.success);
    Color textCol = isSelected ? Colors.white : (isBooked ? Colors.grey.shade600 : AppColors.success);

    return GestureDetector(
      onTap: () {
        if(isBooked) return;
        setState(() {
          if(selectedSeats.contains(seatNr)) {
            selectedSeats.remove(seatNr);
          } else {
            selectedSeats.add(seatNr);
          }
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 35, height: 35,
        decoration: BoxDecoration(
          color: fill,
          border: Border.all(color: border, width: isSelected ? 2 : 1),
          borderRadius: BorderRadius.circular(6),
          boxShadow: isSelected ? [BoxShadow(color: AppColors.primaryGold.withValues(alpha: 0.3), blurRadius: 6)] : null,
        ),
        child: Center(child: Text('$seatNr', style: TextStyle(color: textCol, fontWeight: FontWeight.bold, fontSize: 11))),
      ),
    );
  }

  Widget _buildSummaryAndPayment() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade100), boxShadow: AppTheme.cardShadow),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Përmbledhje e Rezervimit', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          _summaryRow('Linja', 'Prishtinë → Prizren'),
          const Divider(height: 1),
          const SizedBox(height: 12),
          _summaryRow('Data', '25 Maj 2025'),
          const Divider(height: 1),
          const SizedBox(height: 12),
          _summaryRow('Ora', '08:00'),
          const Divider(height: 1),
          const SizedBox(height: 12),
          _summaryRow('Ulëset', selectedSeats.join(', ')),
          const Divider(height: 1),
          const SizedBox(height: 12),
          _summaryRow('Nr. i biletave', '${selectedSeats.length}'),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primaryGold.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.primaryGold.withValues(alpha: 0.3)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Totali', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text('€${(selectedSeats.length * 6).toString()}.00', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: AppColors.primaryGold)),
              ],
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Rezervimi u krye me sukses!'),
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
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Paguaj Tani', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: AppColors.textGrey, fontSize: 14)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        ],
      ),
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
              Center(child: Container(width: 50, height: 4, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2)))),
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