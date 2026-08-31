import 'package:flutter/material.dart';
import 'game_storage.dart';

class AppLanguage {
  final String code;
  final String nativeName;
  final String englishName;
  final String flagEmoji;

  const AppLanguage({
    required this.code,
    required this.nativeName,
    required this.englishName,
    required this.flagEmoji,
  });
}

class AppStrings {
  static final List<AppLanguage> supportedLanguages = const [
    AppLanguage(code: 'en', nativeName: 'English', englishName: 'English', flagEmoji: '🇺🇸'),
    AppLanguage(code: 'id', nativeName: 'Indonesia', englishName: 'Indonesia', flagEmoji: '🇮🇩'),
    AppLanguage(code: 'es', nativeName: 'Española', englishName: 'Spanish', flagEmoji: '🇪🇸'),
    AppLanguage(code: 'vi', nativeName: 'Tiếng Việt', englishName: 'Vietnamese', flagEmoji: '🇻🇳'),
    AppLanguage(code: 'th', nativeName: 'แบบไทย', englishName: 'Thai', flagEmoji: '🇹🇭'),
    AppLanguage(code: 'pt', nativeName: 'Português', englishName: 'Portuguese', flagEmoji: '🇵🇹'),
    AppLanguage(code: 'ru', nativeName: 'Русский', englishName: 'Russian', flagEmoji: '🇷🇺'),
    AppLanguage(code: 'fr', nativeName: 'Français', englishName: 'French', flagEmoji: '🇫🇷'),
    AppLanguage(code: 'ko', nativeName: '한국인', englishName: 'Korean', flagEmoji: '🇰🇷'),
    AppLanguage(code: 'hi', nativeName: 'हिंदी', englishName: 'Hindi', flagEmoji: '🇮🇳'),
  ];

  static final ValueNotifier<String> languageNotifier = ValueNotifier<String>('en');

  static String get currentLanguage => languageNotifier.value;

  static void init() {
    languageNotifier.value = GameStorage.getLanguage();
  }

  static Future<void> changeLanguage(String code) async {
    await GameStorage.setLanguage(code);
    languageNotifier.value = code;
  }

  static String _get(Map<String, String> map) {
    return map[currentLanguage] ?? map['en'] ?? '';
  }

  // --- Common & App Global ---
  static String get appTitle => _get({
    'en': 'CyberHex',
    'id': 'CyberHex',
    'es': 'CyberHex',
    'vi': 'CyberHex',
    'th': 'CyberHex',
    'pt': 'CyberHex',
    'ru': 'CyberHex',
    'fr': 'CyberHex',
    'ko': 'CyberHex',
    'hi': 'CyberHex',
  });

  static String get appSubTitle => _get({
    'en': 'Node Hacker',
    'id': 'Peretas Simpul',
    'es': 'Hacker de Nodos',
    'vi': 'Hacker Nút Network',
    'th': 'แฮกเกอร์โหนด',
    'pt': 'Hacker de Nós',
    'ru': 'Хакер Узлов',
    'fr': 'Hacker de Nœuds',
    'ko': '노드 해커',
    'hi': 'नोड हैकर',
  });

  static String get cancel => _get({
    'en': 'CANCEL',
    'id': 'BATAL',
    'es': 'CANCELAR',
    'vi': 'HỦY',
    'th': 'ยกเลิก',
    'pt': 'CANCELAR',
    'ru': 'ОТМЕНА',
    'fr': 'ANNULER',
    'ko': '취소',
    'hi': 'रद्द करें',
  });

  static String get exitGame => _get({
    'en': 'EXIT GAME',
    'id': 'KELUAR GAME',
    'es': 'SALIR DEL JUEGO',
    'vi': 'THOÁT GAME',
    'th': 'ออกจากเกม',
    'pt': 'SAIR DO JOGO',
    'ru': 'ВЫЙТИ ИЗ ИГРЫ',
    'fr': 'QUITTER',
    'ko': '게임 종료',
    'hi': 'गेम से बाहर निकलें',
  });

  static String get dataCredits => _get({
    'en': 'Data',
    'id': 'Data',
    'es': 'Datos',
    'vi': 'Dữ liệu',
    'th': 'ข้อมูล',
    'pt': 'Dados',
    'ru': 'Данные',
    'fr': 'Données',
    'ko': '데이터',
    'hi': 'डेटा',
  });

  // --- Splash Screen ---
  static String get systemInitializing => _get({
    'en': 'System Initializing...',
    'id': 'Inisialisasi Sistem...',
    'es': 'Inicializando Sistema...',
    'vi': 'Đang Khởi Tạo Hệ Thống...',
    'th': 'กำลังเริ่มต้นระบบ...',
    'pt': 'Inicializando Sistema...',
    'ru': 'Инициализация системы...',
    'fr': 'Initialisation du Système...',
    'ko': '시스템 초기화 중...',
    'hi': 'सिस्टम प्रारंभ हो रहा है...',
  });

  // --- Onboarding Screen ---
  static String get skip => _get({
    'en': 'Skip',
    'id': 'Lewati',
    'es': 'Omitir',
    'vi': 'Bỏ qua',
    'th': 'ข้าม',
    'pt': 'Pular',
    'ru': 'Пропустить',
    'fr': 'Passer',
    'ko': '건너뛰기',
    'hi': 'छोड़ें',
  });

  static String get proceedProtocol => _get({
    'en': 'Proceed Protocol',
    'id': 'Lanjutkan Protokol',
    'es': 'Continuar Protocolo',
    'vi': 'Tiếp Tục Giao Thức',
    'th': 'ดำเนินการตามโปรโตคอล',
    'pt': 'Prosseguir Protocolo',
    'ru': 'Продолжить протокол',
    'fr': 'Poursuivre le Protocole',
    'ko': '프로토콜 진행',
    'hi': 'प्रोटोकॉल आगे बढ़ाएं',
  });

  static String get enterNeuralLink => _get({
    'en': 'Enter Neural Link',
    'id': 'Masuk Tautan Neural',
    'es': 'Entrar Enlace Neural',
    'vi': 'Vào Liên Kết Thần Kinh',
    'th': 'เข้าสู่ลิงก์ประสาท',
    'pt': 'Entrar no Link Neural',
    'ru': 'Войти в нейросеть',
    'fr': 'Entrer dans le Lien Neural',
    'ko': '뉴럴 링크 접속',
    'hi': 'न्यूरल लिंक में प्रवेश करें',
  });

  static String get obSlide1Title => _get({
    'en': 'Welcome Hacker',
    'id': 'Selamat Datang Peretas',
    'es': 'Bienvenido Hacker',
    'vi': 'Chào Mừng Hacker',
    'th': 'ยินดีต้อนรับแฮกเกอร์',
    'pt': 'Bem-vindo Hacker',
    'ru': 'Добро пожаловать, Хакер',
    'fr': 'Bienvenue Hacker',
    'ko': '해커 환영',
    'hi': 'स्वागत है हैकर',
  });

  static String get obSlide1Subtitle => _get({
    'en': 'The Mission Overview',
    'id': 'Ikhtisar Misi',
    'es': 'Resumen de la Misión',
    'vi': 'Tổng Quan Nhiệm Vụ',
    'th': 'ภาพรวมภารกิจ',
    'pt': 'Visão Geral da Missão',
    'ru': 'Обзор миссии',
    'fr': 'Aperçu de la Mission',
    'ko': '미션 개요',
    'hi': 'मिशन अवलोकन',
  });

  static String get obSlide1Desc => _get({
    'en': 'You are an elite Node Hacker operating in the deep shadows. Your goal is to infiltrate high-security corporate node networks, breach their firewalls, and extract critical core intelligence.',
    'id': 'Anda adalah Peretas Simpul elit di bayangan. Tujuan Anda adalah menyusup ke jaringan perusahaan tingkat tinggi, menembus firewall, dan mengekstrak intelijen inti.',
    'es': 'Eres un Hacker de Nodos de élite. Tu objetivo es infiltrarte en redes corporativas de alta seguridad, romper sus cortafuegos y extraer inteligencia de núcleo vital.',
    'vi': 'Bạn là một Hacker Nút ưu tú. Mục tiêu của bạn là xâm nhập mạng lưới doanh nghiệp bảo mật cao, vượt qua tường lửa và trích xuất dữ liệu quan trọng.',
    'th': 'คุณคือแฮกเกอร์โหนดระดับแนวหน้า เป้าหมายของคุณคือการเจาะเครือข่ายองค์กรที่มีความปลอดภัยสูง ทะลวงไฟร์วอลล์ และดึงข้อมูลหลักที่สำคัญ',
    'pt': 'Você é um Hacker de Nós de elite. Seu objetivo é se infiltrar em redes corporativas de alta segurança, quebrar seus firewalls e extrair inteligência vital.',
    'ru': 'Вы — элитный Хакер Узлов. Ваша цель — проникнуть в corporate-сети высокой безопасности, взломать брандмауэры и извлечь ключевые данные.',
    'fr': 'Vous êtes un Hacker de Nœuds d\'élite. Votre objectif est de vous infiltrer dans les réseaux d\'entreprise hautement sécurisés, de franchir leurs pare-feu et d\'extraire les données.',
    'ko': '당신은 엘리트 노드 해커입니다. 목표는 보안이 철저한 기업 노드 네트워크에 침투하여 방화벽을 뚫고 핵심 정보를 추출하는 것입니다.',
    'hi': 'आप एक एलीट नोड हैकर हैं। आपका लक्ष्य उच्च-सुरक्षा कॉर्पोरेट नोड नेटवर्क में सेंध लगाना, उनके फ़ायरवॉल को तोड़ना और महत्वपूर्ण डेटा निकालना है।',
  });

  static String get obSlide2Title => _get({
    'en': 'Traverse Nodes',
    'id': 'Melintasi Simpul',
    'es': 'Recorrer Nodos',
    'vi': 'Di Chuyển Qua Nút',
    'th': 'เดินทางผ่านโหนด',
    'pt': 'Navegar por Nós',
    'ru': 'Перемещение по узлам',
    'fr': 'Parcourir les Nœuds',
    'ko': '노드 이동',
    'hi': 'नोड्स पार करें',
  });

  static String get obSlide2Subtitle => _get({
    'en': 'RAM Resource Management',
    'id': 'Manajemen Sumber Daya RAM',
    'es': 'Gestión de Recursos RAM',
    'vi': 'Quản Lý Tài Nguyên RAM',
    'th': 'การจัดการทรัพยากร RAM',
    'pt': 'Gerenciamento de Recursos RAM',
    'ru': 'Управление памятью RAM',
    'fr': 'Gestion des Ressources RAM',
    'ko': 'RAM 리소스 관리',
    'hi': 'RAM संसाधन प्रबंधन',
  });

  static String get obSlide2Desc => _get({
    'en': 'In CyberHex, you move by linking to adjacent nodes. Each hop consumes 1 MB of your RAM Energy. Plan your route carefully: if your RAM cache decays to zero, your connection drops and you fail.',
    'id': 'Di CyberHex, Anda bergerak dengan menghubungkan ke simpul terdekat. Setiap lompatan menghabiskan 1 MB RAM. Rencanakan rute Anda dengan cermat.',
    'es': 'En CyberHex, te mueves conectándote a nodos adyacentes. Cada salto consume 1 MB de energía RAM. Planifica tu ruta con cuidado.',
    'vi': 'Trong CyberHex, bạn di chuyển bằng cách kết nối với các nút liền kề. Mỗi bước tốn 1 MB RAM. Hãy lên kế hoạch cẩn thận.',
    'th': 'ใน CyberHex คุณย้ายโดยเชื่อมต่อกับโหนดที่อยู่ติดกัน การกระโดดแต่ละครั้งใช้พลังงาน RAM 1 MB วางแผนเส้นทางของคุณอย่างระมัดระวัง',
    'pt': 'No CyberHex, você se move conectando-se a nós adjacentes. Cada salto consome 1 MB de RAM. Planeje sua rota com cuidado.',
    'ru': 'В CyberHex вы перемещаетесь между соседними узлами. Каждый шаг расходует 1 МБ энергии RAM. Тщательно планируйте маршрут.',
    'fr': 'Dans CyberHex, vous vous déplacez en vous liant aux nœuds adjacents. Chaque saut consomme 1 Mo de RAM. Planifiez soigneusement votre itinéraire.',
    'ko': 'CyberHex에서는 인접한 노드로 연결하여 이동합니다. 이동할 때마다 1MB의 RAM이 소모됩니다. 경로를 신중하게 계획하세요.',
    'hi': 'CyberHex में, आप आस-पास के नोड्स से जुड़कर आगे बढ़ते हैं। प्रत्येक कदम 1 MB RAM ऊर्जा की खपत करता है। अपने मार्ग की सावधानीपूर्वक योजना बनाएं।',
  });

  static String get obSlide3Title => _get({
    'en': 'Avoid Threats',
    'id': 'Hindari Ancaman',
    'es': 'Evitar Amenazas',
    'vi': 'Tránh Mối Đe Dọa',
    'th': 'หลีกเลี่ยงภัยคุกคาม',
    'pt': 'Evitar Ameaças',
    'ru': 'Избегайте угроз',
    'fr': 'Éviter les Menaces',
    'ko': '위협 회피',
    'hi': 'खतरों से बचें',
  });

  static String get obSlide3Subtitle => _get({
    'en': 'Security Detection & Escape',
    'id': 'Deteksi Keamanan & Pelarian',
    'es': 'Detección de Seguridad y Escape',
    'vi': 'Phát Hiện Bảo Mật & Thoát',
    'th': 'ตรวจจับความปลอดภัยและการหลบหนี',
    'pt': 'Detecção de Segurança e Fuga',
    'ru': 'Обнаружение и эвакуация',
    'fr': 'Détection de Sécurité et Évasion',
    'ko': '보안 감지 및 탈출',
    'hi': 'सुरक्षा पहचान और बचाव',
  });

  static String get obSlide3Desc => _get({
    'en': 'Beware! Stepping on Firewall nodes triggers immediate alarms (+25% threat speed). Watch out for security Drones patrolling the paths (marked with dotted amber lines). Seek and enter the green Extraction Gate to escape and secure your loot.',
    'id': 'Waspada! Menerobos simpul Firewall memicu alarm (+25% ancaman). Waspadai Dron keamanan di garis kuning. Masuk ke Gerbang Ekstraksi hijau untuk kabur.',
    'es': '¡Cuidado! Pisar nodos de Firewall activa alarmas (+25% amenaza). Cuidado con los Drones de seguridad. Entra en el Puerto de Extracción para escapar.',
    'vi': 'Cảnh báo! Giậm vào nút Tường Lửa sẽ kích hoạt báo động (+25% mối đe dọa). Chú ý Drones tuần tra. Tiến vào Cổng Trích Xuất để thoát.',
    'th': 'ระวัง! การเหยียบโหนดไฟร์วอลล์จะเปิดใช้งานการแจ้งเตือน (+25% ภัยคุกคาม) ระวังโดรนรักษาความปลอดภัย เข้าสู่ประตูสกัดสีเขียวเพื่อหลบหนี',
    'pt': 'Cuidado! Pisar em nós de Firewall ativa alarmes (+25% de ameaça). Cuidado com os Drones de segurança. Entre no Portão de Extração para escapar.',
    'ru': 'Осторожно! Нажатие на Firewall активирует тревогу (+25% угрозы). Избегайте Дронов. Войдите в Порт Эвакуации для побега.',
    'fr': 'Attention ! Marcher sur un pare-feu déclenche une alarme (+25% de menace). Attention aux Drones. Rejoignez la Porte d\'Extraction pour vous échapper.',
    'ko': '주의! 방화벽 노드를踏으면 경보가 발동됩니다(+25% 위협). 순찰 드론을 피하고 녹색 추출 게이트로 탈출하세요.',
    'hi': 'सावधान! फ़ायरवॉल नोड्स पर जाने से अलार्म बजता है (+25% खतरा)। सुरक्षा ड्रोन से बचें। बाहर निकलने के लिए निष्कर्षण गेट पर पहुंचें।',
  });

  static String get obSlide4Title => _get({
    'en': 'Upgrade Arsenal',
    'id': 'Tingkatkan Arsenal',
    'es': 'Mejorar Arsenal',
    'vi': 'Nâng Cấp Arsenal',
    'th': 'อัปเกรดคลังแสง',
    'pt': 'Melhorar Arsenal',
    'ru': 'Улучшение арсенала',
    'fr': 'Améliorer l\'Arsenal',
    'ko': '아스널 업그레이드',
    'hi': 'शस्त्रागार अपग्रेड करें',
  });

  static String get obSlide4Subtitle => _get({
    'en': 'Mainframe Upgrades',
    'id': 'Peningkatan Mainframe',
    'es': 'Mejoras de Mainframe',
    'vi': 'Nâng Cấp Mainframe',
    'th': 'การอัปเกรดเมนเฟรม',
    'pt': 'Melhorias de Mainframe',
    'ru': 'Улучшения мейнфрейма',
    'fr': 'Améliorations du Mainframe',
    'ko': '메인프레임 업그레이드',
    'hi': 'मेनफ्रेम अपग्रेड',
  });

  static String get obSlide4Desc => _get({
    'en': 'Redeem extracted DATA credits at the Terminal Shop to upgrade your rig. Expand your max RAM, install Jammers to slow down firewall tracing, or buy Decoys to hide from security patrol drone paths.',
    'id': 'Tukarkan kredit DATA di Toko Terminal untuk meningkatkan sistem Anda. Tambah RAM maksimum, pasang Pengacak (Jammer), atau beli Umpan (Decoy).',
    'es': 'Canjea créditos de DATA en la Tienda Terminal para mejorar tu equipo. Aumenta tu RAM máxima, instala Inhibidores o compra Señuelos.',
    'vi': 'Đổi tín dụng DATA tại Cửa Hàng để nâng cấp trang thiết bị. Mở rộng RAM tối đa, cài Đặt Bộ Nhiễu hoặc mua Mồi Bẫy.',
    'th': 'แลกรับเครดิต DATA ที่ร้านค้าเพื่ออัปเกรดอุปกรณ์ของคุณ ขยาย RAM สั่งซื้อตัวรบกวนสัญญาณ หรือซื้อเหยื่อล่อ',
    'pt': 'Resgate créditos DATA na Loja para melhorar seu equipamento. Expanda sua RAM máxima, instale Bloqueadores ou compre Decoys.',
    'ru': 'Обменивайте кредиты DATA в Магазине на улучшения. Увеличивайте RAM, устанавливайте Глушители или покупайте Приманки.',
    'fr': 'Échangez vos crédits DATA dans la Boutique pour améliorer votre équipement. Augmentez votre RAM, installez des Brouilleurs ou achetez des Leurres.',
    'ko': '상점에서 DATA 크레딧을 사용해 장비를 업그레이드하세요. 최대 RAM을 늘리거나 재머, 디코이를 구매하세요.',
    'hi': 'टर्मिनल शॉप में DATA क्रेडिट भुनाएं। अपना अधिकतम RAM बढ़ाएं, जैमर स्थापित करें, या डिकॉय खरीदें।',
  });

  // --- Main Menu ---
  static String get selectTargetNetwork => _get({
    'en': 'Select Target Node Network:',
    'id': 'Pilih Jaringan Simpul Target:',
    'es': 'Seleccionar Red de Nodos Objetivo:',
    'vi': 'Chọn Mạng Nút Mục Tiêu:',
    'th': 'เลือกเครือข่ายโหนดเป้าหมาย:',
    'pt': 'Selecionar Rede de Nós Alvo:',
    'ru': 'Выберите целевую сеть узлов:',
    'fr': 'Sélectionner le Réseau Cible:',
    'ko': '타겟 노드 네트워크 선택:',
    'hi': 'लक्ष्य नोड नेटवर्क चुनें:',
  });

  static String get disconnectTitle => _get({
    'en': 'Disconnect System?',
    'id': 'Putuskan Sistem?',
    'es': '¿Desconectar Sistema?',
    'vi': 'Ngắt Kết Nối Hệ Thống?',
    'th': 'ตัดการเชื่อมต่อระบบหรือไม่?',
    'pt': 'Desconectar Sistema?',
    'ru': 'Отключить систему?',
    'fr': 'Déconnecter le Système ?',
    'ko': '시스템 연결 해제?',
    'hi': 'सिस्टम डिस्कनेक्ट करें?',
  });

  static String get disconnectDesc => _get({
    'en': 'Are you sure you want to terminate the hacking session and exit CyberHex?',
    'id': 'Apakah Anda yakin ingin mengakhiri sesi peretasan dan keluar dari CyberHex?',
    'es': '¿Estás seguro de que deseas terminar la sesión de hackeo y salir de CyberHex?',
    'vi': 'Bạn có chắc chắn muốn kết thúc phiên hack và thoát CyberHex không?',
    'th': 'คุณแน่ใจหรือไม่ว่าต้องการยุติเซสชันการแฮกและออกจาก CyberHex?',
    'pt': 'Tem certeza de que deseja encerrar a sessão de hacking e sair do CyberHex?',
    'ru': 'Вы уверены, что хотите завершить сеанс взлома и выйти из CyberHex?',
    'fr': 'Êtes-vous sûr de vouloir terminer la session de hacking et quitter CyberHex ?',
    'ko': '해킹 세션을 종료하고 CyberHex를 나가시겠습니까?',
    'hi': 'क्या आप निश्चित रूप से हैकिंग सत्र समाप्त करके CyberHex से बाहर निकलना चाहते हैं?',
  });

  static String get purgeDataTitle => _get({
    'en': 'Purge all data?',
    'id': 'Hapus semua data?',
    'es': '¿Purgar todos los datos?',
    'vi': 'Xóa toàn bộ dữ liệu?',
    'th': 'ล้างข้อมูลทั้งหมดหรือไม่?',
    'pt': 'Purgar todos os dados?',
    'ru': 'Очистить все данные?',
    'fr': 'Purger toutes les données ?',
    'ko': '모든 데이터 삭제?',
    'hi': 'सभी डेटा मिटाएं?',
  });

  static String get purgeDataWarning => _get({
    'en': 'Warning: This will wipe all system credits and unlocked configurations permanently.',
    'id': 'Peringatan: Ini akan menghapus semua kredit sistem dan konfigurasi secara permanen.',
    'es': 'Advertencia: Esto borrará todos los créditos y configuraciones de forma permanente.',
    'vi': 'Cảnh báo: Hành động này sẽ xóa vĩnh viễn tất cả tín dụng và cấu hình đã mở khóa.',
    'th': 'คำเตือน: สิ่งนี้จะลบเครดิตระบบและการตั้งค่าที่ปลดล็อกทั้งหมดอย่างถาวร',
    'pt': 'Aviso: Isso apagará todos os créditos do sistema e configurações permanentemente.',
    'ru': 'Предупреждение: Это навсегда удалит все кредиты и разблокированные конфигурации.',
    'fr': 'Avertissement : Cela effacera définitivement tous les crédits et configurations.',
    'ko': '경고: 모든 시스템 크레딧과 잠금 해제된 설정이 영구적으로 삭제됩니다.',
    'hi': 'चेतावनी: यह सभी सिस्टम क्रेडिट और अनलॉक की गई कॉन्फ़िगरेशन को स्थायी रूप से मिटा देगा।',
  });

  static String get purgeButton => _get({
    'en': 'Purge Database Progress',
    'id': 'Hapus Progres Basis Data',
    'es': 'Purgar Progreso de Base de Datos',
    'vi': 'Xóa Tiến Trình Cơ Sở Dữ Liệu',
    'th': 'ล้างความคืบหน้าฐานข้อมูล',
    'pt': 'Purgar Progresso do Banco de Dados',
    'ru': 'Очистить прогресс базы данных',
    'fr': 'Purger la Progression de la Base de Données',
    'ko': '데이터베이스 진행 상황 삭제',
    'hi': 'डेटाबेस प्रगति साफ़ करें',
  });

  static String get purgeAction => _get({
    'en': 'Purge',
    'id': 'Hapus',
    'es': 'Purgar',
    'vi': 'Xóa',
    'th': 'ล้าง',
    'pt': 'Purgar',
    'ru': 'Очистить',
    'fr': 'Purger',
    'ko': '삭제',
    'hi': 'मिटाएं',
  });

  static String get clearanceLevel => _get({
    'en': 'Clearance Lvl',
    'id': 'Tingkat Izin',
    'es': 'Nivel de Acceso',
    'vi': 'Cấp Bậc Bảo Mật',
    'th': 'ระดับการอนุมัติ',
    'pt': 'Nível de Acesso',
    'ru': 'Уровень доступа',
    'fr': 'Niveau d\'Accès',
    'ko': '보안 등급',
    'hi': 'स्वीकृति स्तर',
  });

  static String get themeLabel => _get({
    'en': 'Theme:',
    'id': 'Tema:',
    'es': 'Tema:',
    'vi': 'Chủ đề:',
    'th': 'ธีม:',
    'pt': 'Tema:',
    'ru': 'Тема:',
    'fr': 'Thème :',
    'ko': '테마:',
    'hi': 'थीम:',
  });

  static String get dailyRewardTitle => _get({
    'en': 'Daily Data Bonus',
    'id': 'Bonus Data Harian',
    'es': 'Bono Diario de Datos',
    'vi': 'Thưởng Dữ Liệu Hàng Ngày',
    'th': 'โบนัสข้อมูลรายวัน',
    'pt': 'Bônus Diário de Dados',
    'ru': 'Ежедневный бонус данных',
    'fr': 'Bonus Quotidien de Données',
    'ko': '일일 데이터 보너스',
    'hi': 'दैनिक डेटा बोनस',
  });

  static String get dailyRewardAvailable => _get({
    'en': 'Claim +50 Data Credits reward now!',
    'id': 'Klaim hadiah +50 Kredit Data sekarang!',
    'es': '¡Reclama +50 Créditos de Datos ahora!',
    'vi': 'Nhận thưởng +50 Tín Dụng Dữ Liệu ngay!',
    'th': 'รับรางวัล +50 เครดิตข้อมูลตอนนี้!',
    'pt': 'Resgate +50 Créditos de Dados agora!',
    'ru': 'Получите +50 кредитов данных прямо сейчас!',
    'fr': 'Réclamez +50 Crédits de Données maintenant !',
    'ko': '지금 +50 데이터 크레딧 보상을 받으세요!',
    'hi': '+50 डेटा क्रेडिट इनाम अभी दावा करें!',
  });

  static String get nextBonusIn => _get({
    'en': 'Next Bonus in:',
    'id': 'Bonus berikutnya dalam:',
    'es': 'Siguiente bono en:',
    'vi': 'Thưởng tiếp theo trong:',
    'th': 'โบนัสถัดไปใน:',
    'pt': 'Próximo bônus em:',
    'ru': 'Следующий бонус через:',
    'fr': 'Prochain bonus dans :',
    'ko': '다음 보너스까지:',
    'hi': 'अगला बोनस समय:',
  });

  static String get claim => _get({
    'en': 'CLAIM',
    'id': 'KLAIM',
    'es': 'RECLAMAR',
    'vi': 'NHẬN',
    'th': 'รับรางวัล',
    'pt': 'RESGATAR',
    'ru': 'ЗАБРАТЬ',
    'fr': 'RÉCLAMER',
    'ko': '수령',
    'hi': 'दावा करें',
  });

  static String get locked => _get({
    'en': 'LOCKED',
    'id': 'TERKUNCI',
    'es': 'BLOQUEADO',
    'vi': 'ĐÃ KHÓA',
    'th': 'ล็อกอยู่',
    'pt': 'BLOQUEADO',
    'ru': 'ЗАКРЫТО',
    'fr': 'VERROUILLÉ',
    'ko': '잠김',
    'hi': 'लॉक है',
  });

  static String get dailyRewardClaimed => _get({
    'en': 'Daily Reward Claimed: +50 Data Credits!',
    'id': 'Hadiah Harian Diklaim: +50 Kredit Data!',
    'es': '¡Bono Diario Reclamado: +50 Créditos de Datos!',
    'vi': 'Đã Nhận Thưởng Hàng Ngày: +50 Tín Dụng Dữ Liệu!',
    'th': 'รับรางวัลรายวันแล้ว: +50 เครดิตข้อมูล!',
    'pt': 'Recompensa Diária Resgatada: +50 Créditos de Dados!',
    'ru': 'Ежедневный бонус получен: +50 кредитов данных!',
    'fr': 'Récompense Quotidienne Réclamée : +50 Crédits de Données !',
    'ko': '일일 보상 수령 완료: +50 데이터 크레딧!',
    'hi': 'दैनिक इनाम का दावा किया गया: +50 डेटा क्रेडिट!',
  });

  // Ranks
  static String rankTitle(int level) {
    if (level >= 8) {
      return _get({
        'en': 'Legendary Netrunner',
        'id': 'Netrunner Legendaris',
        'es': 'Netrunner Legendario',
        'vi': 'Netrunner Huyền Thoại',
        'th': 'เน็ตรันเนอร์ระดับตำนาน',
        'pt': 'Netrunner Lendário',
        'ru': 'Легендарный Нетраннер',
        'fr': 'Netrunner Légendaire',
        'ko': '전설적인 넷러너',
        'hi': 'प्रसिद्ध नेटरनर',
      });
    }
    if (level >= 6) {
      return _get({
        'en': 'Ghost Syndicate Lead',
        'id': 'Pemimpin Sindikat Hantu',
        'es': 'Líder del Sindicato Fantasma',
        'vi': 'Thủ Lĩnh Băng Hồn',
        'th': 'ผู้นำซินดิเคทเงา',
        'pt': 'Líder do Sindicato Fantasma',
        'ru': 'Глава Призрачного Синдиката',
        'fr': 'Chef del\'Organisation Fantôme',
        'ko': '고스트 신디케이트 리더',
        'hi': 'गोस्ट सिंडिकेट लीड',
      });
    }
    if (level >= 4) {
      return _get({
        'en': 'Cyber Operative',
        'id': 'Operatif Siber',
        'es': 'Operativo Cibernético',
        'vi': 'Đặc Viên Cyber',
        'th': 'เจ้าหน้าที่ไซเบอร์',
        'pt': 'Operativo Cibernético',
        'ru': 'Кибер-оперативник',
        'fr': 'Opérateur Cyber',
        'ko': '사이버 요원',
        'hi': 'साइबर ऑपरेटर',
      });
    }
    if (level >= 2) {
      return _get({
        'en': 'Node Breaker',
        'id': 'Pemobol Simpul',
        'es': 'Rompedor de Nodos',
        'vi': 'Kẻ Phá Nút',
        'th': 'ผู้ทำลายโหนด',
        'pt': 'Quebrador de Nós',
        'ru': 'Взломщик узлов',
        'fr': 'Briseur de Nœuds',
        'ko': '노드 브레이커',
        'hi': 'नोड ब्रेकर',
      });
    }
    return _get({
      'en': 'Script Kiddie',
      'id': 'Script Kiddie',
      'es': 'Script Kiddie',
      'vi': 'Script Kiddie',
      'th': 'Script Kiddie',
      'pt': 'Script Kiddie',
      'ru': 'Скрипт-кидди',
      'fr': 'Script Kiddie',
      'ko': '스크립트 키디',
      'hi': 'स्क्रिप्ट किडी',
    });
  }

  // --- Settings Screen ---
  static String get systemSettings => _get({
    'en': 'System Settings',
    'id': 'Pengaturan Sistem',
    'es': 'Ajustes del Sistema',
    'vi': 'Cài Đặt Hệ Thống',
    'th': 'การตั้งค่าระบบ',
    'pt': 'Configurações do Sistema',
    'ru': 'Настройки системы',
    'fr': 'Paramètres Système',
    'ko': '시스템 설정',
    'hi': 'सिस्टम सेटिंग्स',
  });

  static String get audioConfigurations => _get({
    'en': 'Audio Configurations',
    'id': 'Konfigurasi Audio',
    'es': 'Configuración de Audio',
    'vi': 'Cấu Hình Âm Thanh',
    'th': 'การตั้งค่าเสียง',
    'pt': 'Configurações de Áudio',
    'ru': 'Конфигурация аудио',
    'fr': 'Configurations Audio',
    'ko': '오디오 설정',
    'hi': 'ऑडियो कॉन्फ़िगरेशन',
  });

  static String get backgroundMusic => _get({
    'en': 'Background Music',
    'id': 'Musik Latar',
    'es': 'Música de Fondo',
    'vi': 'Nhạc Nền',
    'th': 'เพลงประกอบ',
    'pt': 'Música de Fundo',
    'ru': 'Фоновая музыка',
    'fr': 'Musique de Fond',
    'ko': '배경 음악',
    'hi': 'बैकग्राउंड म्यूजिक',
  });

  static String get audioSubtitle => _get({
    'en': 'Ambient sci-fi cyber sound loops',
    'id': 'Loop suara siber sci-fi ambien',
    'es': 'Bucles de sonido cibernético sci-fi',
    'vi': 'Âm thanh cyber viễn tưởng ambient',
    'th': 'เสียงไซไฟไซเบอร์บรรยากาศ',
    'pt': 'Loops de som cibernético sci-fi',
    'ru': 'Эмбиентные научно-фантастические звуки',
    'fr': 'Boucles sonores cyber sci-fi ambiantes',
    'ko': '앰비언트 SF 사이버 사운드 루프',
    'hi': 'एंबिएंट साइ-फाइ साइबर साउंड लूप्स',
  });

  static String get languageSettings => _get({
    'en': 'Language Settings',
    'id': 'Pengaturan Bahasa',
    'es': 'Ajustes de Idioma',
    'vi': 'Cài Đặt Ngôn Ngữ',
    'th': 'การตั้งค่าภาษา',
    'pt': 'Configurações de Idioma',
    'ru': 'Настройки языка',
    'fr': 'Paramètres de Langue',
    'ko': '언어 설정',
    'hi': 'भाषा सेटिंग्स',
  });

  static String get appLanguage => _get({
    'en': 'App Language',
    'id': 'Bahasa Aplikasi',
    'es': 'Idioma de la Aplicación',
    'vi': 'Ngôn Ngữ Ứng Dụng',
    'th': 'ภาษาของแอป',
    'pt': 'Idioma do Aplicativo',
    'ru': 'Язык приложения',
    'fr': 'Langue de l\'Application',
    'ko': '앱 언어',
    'hi': 'ऐप भाषा',
  });

  static String get languageSubtitle => _get({
    'en': 'Select your preferred language',
    'id': 'Pilih bahasa yang Anda inginkan',
    'es': 'Selecciona tu idioma preferido',
    'vi': 'Chọn ngôn ngữ ưu tiên của bạn',
    'th': 'เลือกภาษาที่คุณต้องการ',
    'pt': 'Selecione seu idioma preferido',
    'ru': 'Выберите предпочитаемый язык',
    'fr': 'Choisissez votre langue préférée',
    'ko': '선호하는 언어를 선택하세요',
    'hi': 'अपनी पसंदीदा भाषा चुनें',
  });

  static String get hackingDatabaseRef => _get({
    'en': 'Hacking Database & Reference',
    'id': 'Basis Data Peretasan & Referensi',
    'es': 'Base de Datos de Hackeo y Referencia',
    'vi': 'Cơ Sở Dữ Liệu Hack & Tham Chiếu',
    'th': 'ฐานข้อมูลการแฮกและการอ้างอิง',
    'pt': 'Banco de Dados de Hacking e Referência',
    'ru': 'База данных взлома и справка',
    'fr': 'Base de Données de Hacking & Références',
    'ko': '해킹 데이터베이스 및 참조',
    'hi': 'हैकिंग डेटाबेस और संदर्भ',
  });

  static String get systemRulesTitle => _get({
    'en': 'System Rules & Hacking Guide',
    'id': 'Aturan Sistem & Panduan Peretasan',
    'es': 'Reglas del Sistema y Guía de Hackeo',
    'vi': 'Quy Tắc Hệ Thống & Hướng Dẫn Hack',
    'th': 'กฎระบบและคู่มือการแฮก',
    'pt': 'Regras do Sistema e Guia de Hacking',
    'ru': 'Правила системы и руководство по взлому',
    'fr': 'Règles du Système & Guide de Hacking',
    'ko': '시스템 규칙 및 해킹 가이드',
    'hi': 'सिस्टम नियम और हैकिंग गाइड',
  });

  static String get systemRulesSubtitle => _get({
    'en': 'Objective, Node types, colors and stages',
    'id': 'Tujuan, jenis simpul, warna dan tahapan',
    'es': 'Objetivo, tipos de nodos, colores y etapas',
    'vi': 'Mục tiêu, loại nút, màu sắc và các giai đoạn',
    'th': 'วัตถุประสงค์ ประเภทโหนด สี และขั้นตอน',
    'pt': 'Objetivo, tipos de nós, cores e etapas',
    'ru': 'Цель, типы узлов, цвета и этапы',
    'fr': 'Objectif, types de nœuds, couleurs et étapes',
    'ko': '목표, 노드 유형, 색상 및 스테이지',
    'hi': 'उद्देश्य, नोड के प्रकार, रंग और चरण',
  });

  // --- Select Language Screen (from Photo UI) ---
  static String get selectLanguageTitle => _get({
    'en': 'Select Language',
    'id': 'Pilih Bahasa',
    'es': 'Seleccionar Idioma',
    'vi': 'Chọn Ngôn Ngữ',
    'th': 'เลือกภาษา',
    'pt': 'Selecionar Idioma',
    'ru': 'Выберите язык',
    'fr': 'Sélectionner la langue',
    'ko': '언어 선택',
    'hi': 'भाषा चुनें',
  });

  static String get selectLanguageDesc => _get({
    'en': 'Choose your preferred language to continue',
    'id': 'Pilih bahasa yang Anda inginkan untuk melanjutkan',
    'es': 'Elige tu idioma preferido para continuar',
    'vi': 'Chọn ngôn ngữ ưu tiên của bạn để tiếp tục',
    'th': 'เลือกภาษาที่คุณต้องการเพื่อดำเนินการต่อ',
    'pt': 'Escolha o seu idioma preferido para continuar',
    'ru': 'Выберите предпочитаемый язык для продолжения',
    'fr': 'Choisissez votre langue préférée pour continuer',
    'ko': '계속하려면 선호하는 언어를 선택하세요',
    'hi': 'आगे बढ़ने के लिए अपनी पसंदीदा भाषा चुनें',
  });

  static String get continueBtn => _get({
    'en': 'Continue',
    'id': 'Lanjutkan',
    'es': 'Continuar',
    'vi': 'Tiếp Tục',
    'th': 'ดำเนินการต่อ',
    'pt': 'Continuar',
    'ru': 'Продолжить',
    'fr': 'Continuer',
    'ko': '계속하기',
    'hi': 'आगे बढ़ें',
  });

  // --- Shop Screen ---
  static String get cyberMarketplace => _get({
    'en': 'Cyber Marketplace',
    'id': 'Pasar Siber',
    'es': 'Mercado Cibernético',
    'vi': 'Chợ Cyber',
    'th': 'ตลาดไซเบอร์',
    'pt': 'Mercado Cibernético',
    'ru': 'Кибер-маркетплейс',
    'fr': 'Marché Cyber',
    'ko': '사이버 마켓플레이스',
    'hi': 'साइबर मार्केटप्लेस',
  });

  static String get systemUpgrades => _get({
    'en': 'System Upgrades',
    'id': 'Peningkatan Sistem',
    'es': 'Mejoras del Sistema',
    'vi': 'Nâng Cấp Hệ Thống',
    'th': 'การอัปเกรดระบบ',
    'pt': 'Melhorias do Sistema',
    'ru': 'Улучшения системы',
    'fr': 'Améliorations du Système',
    'ko': '시스템 업그레이드',
    'hi': 'सिस्टम अपग्रेड',
  });

  static String get wallpapersThemes => _get({
    'en': 'Wallpapers & Themes',
    'id': 'Wallpaper & Tema',
    'es': 'Fondos y Temas',
    'vi': 'Hình Nền & Chủ Đề',
    'th': 'วอลเปเปอร์และธีม',
    'pt': 'Papéis de Parede e Temas',
    'ru': 'Обои и темы',
    'fr': 'Fonds d\'écran & Thèmes',
    'ko': '배경화면 및 테마',
    'hi': 'वॉलपेपर और थीम',
  });

  static String get maxed => _get({
    'en': 'Maxed',
    'id': 'Maksimal',
    'es': 'Máximo',
    'vi': 'Tối Đa',
    'th': 'สูงสุดแล้ว',
    'pt': 'Máximo',
    'ru': 'Максимум',
    'fr': 'Maxi',
    'ko': '최대',
    'hi': 'मैक्स',
  });

  static String get equip => _get({
    'en': 'EQUIP',
    'id': 'PASANG',
    'es': 'EQUIPAR',
    'vi': 'TRANG BỊ',
    'th': 'สวมใส่',
    'pt': 'EQUIPAR',
    'ru': 'НАДЕТЬ',
    'fr': 'ÉQUIPER',
    'ko': '장착',
    'hi': 'इक्विप',
  });

  static String get equipped => _get({
    'en': 'EQUIPPED',
    'id': 'TERPASANG',
    'es': 'EQUIPADO',
    'vi': 'ĐÃ TRANG BỊ',
    'th': 'สวมใส่อยู่',
    'pt': 'EQUIPADO',
    'ru': 'УСТАНОВЛЕНО',
    'fr': 'ÉQUIPÉ',
    'ko': '장착됨',
    'hi': 'इक्विप्ड',
  });

  // Upgrade item details
  static String upgradeName(String id) {
    switch (id) {
      case 'ram':
        return _get({
          'en': 'RAM Expansion',
          'id': 'Ekspansi RAM',
          'es': 'Expansión de RAM',
          'vi': 'Mở Rộng RAM',
          'th': 'การขยาย RAM',
          'pt': 'Expansão de RAM',
          'ru': 'Расширение RAM',
          'fr': 'Extension de RAM',
          'ko': 'RAM 확장',
          'hi': 'RAM विस्तार',
        });
      case 'jammer':
        return _get({
          'en': 'Firewall Jammer',
          'id': 'Pengacak Firewall',
          'es': 'Inhibidor de Firewall',
          'vi': 'Bộ Nhiễu Tường Lửa',
          'th': 'ตัวรบกวนสัญญาณไฟร์วอลล์',
          'pt': 'Bloqueador de Firewall',
          'ru': 'Глушитель брандмауэра',
          'fr': 'Brouilleur de Pare-feu',
          'ko': '방화벽 재머',
          'hi': 'फ़ायरवॉल जैमर',
        });
      case 'scanner':
        return _get({
          'en': 'Node Radar Scanner',
          'id': 'Pemindai Radar Simpul',
          'es': 'Escáner de Radar de Nodos',
          'vi': 'Máy Quét Radar Nút',
          'th': 'เครื่องสแกนเรดาร์โหนด',
          'pt': 'Escâner de Radar de Nós',
          'ru': 'Радарный сканер узлов',
          'fr': 'Scanner Radar de Nœuds',
          'ko': '노드 레이더 스캐너',
          'hi': 'नोड रडार स्कैनर',
        });
      case 'decoy':
        return _get({
          'en': 'Signal Decoy',
          'id': 'Umpan Sinyal',
          'es': 'Señol de Señal',
          'vi': 'Mồi Bẫy Tín Hiệu',
          'th': 'เหยื่อล่อสัญญาณ',
          'pt': 'Decoy de Sinal',
          'ru': 'Сигнальная приманка',
          'fr': 'Leurre de Signal',
          'ko': '신호 디코이',
          'hi': 'सिग्नल डिकॉय',
        });
      default:
        return '';
    }
  }

  static String upgradeDesc(String id) {
    switch (id) {
      case 'ram':
        return _get({
          'en': 'Increases starting action capacity by +2 RAM per level.',
          'id': 'Meningkatkan kapasitas awal sebesar +2 RAM per tingkat.',
          'es': 'Aumenta la capacidad inicial en +2 RAM por nivel.',
          'vi': 'Tăng dung lượng khởi đầu thêm +2 RAM mỗi cấp.',
          'th': 'เพิ่มความจุเริ่มต้นขึ้น +2 RAM ต่อระดับ',
          'pt': 'Aumenta a capacidade inicial em +2 RAM por nível.',
          'ru': 'Увеличивает начальную емкость на +2 RAM за уровень.',
          'fr': 'Augmente la capacité initiale de +2 Mo de RAM par niveau.',
          'ko': '레벨당 초기 작업 용량을 +2 RAM만큼 증가시킵니다.',
          'hi': 'प्रत्येक स्तर पर प्रारंभिक क्षमता +2 RAM बढ़ाएं।',
        });
      case 'jammer':
        return _get({
          'en': 'Reduces threat level growth per move by 15%.',
          'id': 'Mengurangi pertumbuhan tingkat ancaman sebesar 15%.',
          'es': 'Reduce el crecimiento de amenaza en un 15% por movimiento.',
          'vi': 'Giảm tốc độ tăng mối đe dọa đi 15% mỗi bước.',
          'th': 'ลดการเติบโตของระดับภัยคุกคามลง 15% ต่อการเคลื่อนไหว',
          'pt': 'Reduz o crescimento do nível de ameaça em 15% por movimento.',
          'ru': 'Снижает рост уровня угрозы на 15% за шаг.',
          'fr': 'Réduit la progression du niveau de menace de 15% par coup.',
          'ko': '이동당 위협 증가율을 15% 감소시킵니다.',
          'hi': 'प्रति चाल खतरा वृद्धि को 15% कम करता है।',
        });
      case 'scanner':
        return _get({
          'en': 'Increases data detection ranges to locate far-off network packet nodes.',
          'id': 'Meningkatkan jangkauan deteksi untuk menemukan simpul data jauh.',
          'es': 'Aumenta el rango de detección para localizar nodos lejanos.',
          'vi': 'Tăng phạm vi phát hiện để tìm các nút dữ liệu ở xa.',
          'th': 'เพิ่มระยะการตรวจจับเพื่อค้นหาโหนดแพ็กเกจข้อมูลที่อยู่ไกล',
          'pt': 'Aumenta o alcance de detecção para localizar nós distantes.',
          'ru': 'Увеличивает дальность обнаружения удаленных узлов данных.',
          'fr': 'Augmente la portée de détection pour localiser les nœuds éloignés.',
          'ko': '데이터 감지 범위를 늘려 멀리 있는 노드를 탐지합니다.',
          'hi': 'दूर के डेटा नोड्स को खोजने के लिए पहचान सीमा बढ़ाएं।',
        });
      case 'decoy':
        return _get({
          'en': 'Deploy decoys. Drones start level in standby mode for 3 moves.',
          'id': 'Gunakan umpan. Dron siaga selama 3 langkah pertama.',
          'es': 'Despliega señuelos. Los drones permanecen en espera 3 turnos.',
          'vi': 'Triển khai mồi bẫy. Drones đơ 3 bước đầu.',
          'th': 'วางเหยื่อล่อ โดรนจะเข้าสู่โหมดสแตนด์บายเป็นเวลา 3 ตา',
          'pt': 'Implante decoys. Drones ficam em espera por 3 movimentos.',
          'ru': 'Приманка удерживает дронов в режиме ожидания на 3 хода.',
          'fr': 'Déployez des leurres. Les drones restent en attente pendant 3 coups.',
          'ko': '디코이를 배치하여 드론을 3턴 동안 대기 상태로 만듭니다.',
          'hi': 'डिकॉय तैनात करें। ड्रोन 3 चालों के लिए स्टैंडबाय पर रहेंगे।',
        });
      default:
        return '';
    }
  }

  // --- Rules Screen ---
  static String get hackingProtocols => _get({
    'en': 'Hacking Protocols',
    'id': 'Protokol Peretasan',
    'es': 'Protocolos de Hackeo',
    'vi': 'Giao Thức Hack',
    'th': 'โปรโตคอลการแฮก',
    'pt': 'Protocolos de Hacking',
    'ru': 'Протоколы взлома',
    'fr': 'Protocoles de Hacking',
    'ko': '해킹 프로토콜',
    'hi': 'हैकिंग प्रोटोकॉल',
  });

  // --- Game Screen HUD & Dialogs ---
  static String get ramEnergy => _get({
    'en': 'RAM Energy:',
    'id': 'Energi RAM:',
    'es': 'Energía RAM:',
    'vi': 'Năng Lượng RAM:',
    'th': 'พลังงาน RAM:',
    'pt': 'Energia RAM:',
    'ru': 'Энергия RAM:',
    'fr': 'Énergie RAM :',
    'ko': 'RAM 에너지:',
    'hi': 'RAM ऊर्जा:',
  });

  static String get firewallThreat => _get({
    'en': 'Firewall Threat',
    'id': 'Ancaman Firewall',
    'es': 'Amenaza de Firewall',
    'vi': 'Đe Dọa Tường Lửa',
    'th': 'ภัยคุกคามไฟร์วอลล์',
    'pt': 'Ameaça de Firewall',
    'ru': 'Угроза брандмауэра',
    'fr': 'Menace Pare-feu',
    'ko': '방화벽 위협',
    'hi': 'फ़ायरवॉल खतरा',
  });

  static String get terminalLogOutput => _get({
    'en': 'Terminal Log Output:',
    'id': 'Output Log Terminal:',
    'es': 'Registro de Terminal:',
    'vi': 'Nhật Ký Terminal:',
    'th': 'บันทึกของเทอร์มินัล:',
    'pt': 'Saída de Log do Terminal:',
    'ru': 'Лог терминала:',
    'fr': 'Sortie du Journal :',
    'ko': '터미널 로그 출력:',
    'hi': 'टर्मिनल लॉग आउटपुट:',
  });

  static String get extractionSuccess => _get({
    'en': 'Extraction Success',
    'id': 'Ekstraksi Berhasil',
    'es': 'Extracción Exitosa',
    'vi': 'Trích Xuất Thành Công',
    'th': 'สกัดข้อมูลสำเร็จ',
    'pt': 'Extração Bem-Sucedida',
    'ru': 'Эвакуация успешна',
    'fr': 'Éxtraction Réussie',
    'ko': '추출 성공',
    'hi': 'निष्कर्षण सफल',
  });

  static String get connectionTerminated => _get({
    'en': 'Connection Terminated',
    'id': 'Koneksi Terputus',
    'es': 'Conexión Terminada',
    'vi': 'Kết Nối Bị Ngắt',
    'th': 'การเชื่อมต่อถูกยุติ',
    'pt': 'Conexão Encerrada',
    'ru': 'Соединение разорвано',
    'fr': 'Connexion Interrompue',
    'ko': '연결 종료됨',
    'hi': 'कनेक्शन समाप्त',
  });

  static String get menu => _get({
    'en': 'Menu',
    'id': 'Menu',
    'es': 'Menú',
    'vi': 'Menu',
    'th': 'เมนู',
    'pt': 'Menu',
    'ru': 'Меню',
    'fr': 'Menu',
    'ko': '메뉴',
    'hi': 'मेनू',
  });

  static String get replay => _get({
    'en': 'Replay',
    'id': 'Ulangi',
    'es': 'Rejugar',
    'vi': 'Chơi lại',
    'th': 'เล่นอีกครั้ง',
    'pt': 'Repetir',
    'ru': 'Повторить',
    'fr': 'Rejouer',
    'ko': '다시하기',
    'hi': 'दोबारा खेलें',
  });

  static String get retry => _get({
    'en': 'Retry',
    'id': 'Coba Lagi',
    'es': 'Reintentar',
    'vi': 'Thử lại',
    'th': 'ลองใหม่',
    'pt': 'Tentar Novamente',
    'ru': 'Еще раз',
    'fr': 'Réessayer',
    'ko': '재시도',
    'hi': 'पुनः प्रयास करें',
  });

  static String winDesc(int credits) => _get({
    'en': 'Mainframe decrypted. Gained +$credits system credits data.',
    'id': 'Mainframe terdekripsi. Mendapatkan +$credits kredit data.',
    'es': 'Mainframe descifrado. Ganaste +$credits créditos de datos.',
    'vi': 'Đã giải mã Mainframe. Nhận +$credits tín dụng dữ liệu.',
    'th': 'ถอดรหัสเมนเฟรมแล้ว ได้รับ +$credits เครดิตข้อมูล',
    'pt': 'Mainframe decodificado. Ganhou +$credits créditos de dados.',
    'ru': 'Мейнфрейм расшифрован. Получено +$credits кредитов данных.',
    'fr': 'Mainframe décrypté. Gagné +$credits crédits de données.',
    'ko': '메인프레임 암호 해독 완료. +$credits 데이터 크레딧 획득.',
    'hi': 'मेनफ्रेम डिक्रिप्ट हुआ। +$credits डेटा क्रेडिट मिले।',
  });

  static String get loseDesc => _get({
    'en': 'Firewall detected network node footprint. System isolated.',
    'id': 'Firewall mendeteksi simpul Anda. Sistem terisolasi.',
    'es': 'El Firewall detectó tu huella. Sistema aislado.',
    'vi': 'Tường lửa đã phát hiện bạn. Hệ thống bị phong tỏa.',
    'th': 'ไฟร์วอลล์ตรวจพบร่องรอยของคุณ ระบบถูกแยกออก',
    'pt': 'Firewall detectou sua presença. Sistema isolado.',
    'ru': 'Брандмауэр обнаружил присутствие. Система изолирована.',
    'fr': 'Le pare-feu a détecté votre empreinte. Système isolé.',
    'ko': '방화벽이 위치를 감지했습니다. 시스템이 격리되었습니다.',
    'hi': 'फ़ायरवॉल ने आपकी उपस्थिति का पता लगाया। सिस्टम अलग कर दिया गया।',
  });
}
