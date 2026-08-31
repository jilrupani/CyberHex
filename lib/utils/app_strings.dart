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

  // --- Main Menu & Stages ---
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

  static String stageLabel(int id) {
    final numStr = id < 10 ? '0$id' : '$id';
    final stageWord = _get({
      'en': 'Stage',
      'id': 'Tahap',
      'es': 'Etapa',
      'vi': 'Giai đoạn',
      'th': 'ขั้นตอน',
      'pt': 'Etapa',
      'ru': 'Этап',
      'fr': 'Étape',
      'ko': '스테이지',
      'hi': 'चरण',
    });
    return '$stageWord $numStr';
  }

  static String get nodeNetworkEncrypted => _get({
    'en': 'Node network encrypted. Complete previous stages.',
    'id': 'Jaringan simpul terenkripsi. Selesaikan tahap sebelumnya.',
    'es': 'Red de nodos cifrada. Completa las etapas anteriores.',
    'vi': 'Mạng nút bị mã hóa. Hoàn thành các giai đoạn trước.',
    'th': 'เครือข่ายโหนดถูกเข้ารหัส สำเร็จขั้นตอนก่อนหน้า',
    'pt': 'Rede de nós criptografada. Conclua as etapas anteriores.',
    'ru': 'Зашифрованная сеть. Пройдите предыдущие этапы.',
    'fr': 'Réseau de nœuds crypté. Terminez les étapes précédentes.',
    'ko': '노드 네트워크가 암호화되었습니다. 이전 스테이지를 완료하세요.',
    'hi': 'नोड नेटवर्क एन्क्रिप्टेड है। पिछले चरणों को पूरा करें।',
  });

  static String translateCodeName(String codeName) {
    switch (codeName) {
      case "SUBNET_BYPASS":
        return _get({'en': 'Subnet Bypass', 'id': 'Pintasan Subnet', 'es': 'Bypass de Subred', 'vi': 'Bỏ Qua Phân Mạng', 'th': 'การข้ามซับเน็ต', 'pt': 'Bypass de Sub-rede', 'ru': 'Обход подсети', 'fr': 'Contournement de Sous-réseau', 'ko': '서브넷 바이패스', 'hi': 'सबनेट बायपास'});
      case "PROXY_INFILTRATION":
        return _get({'en': 'Proxy Infiltration', 'id': 'Infiltrasi Proksi', 'es': 'Infiltración Proxy', 'vi': 'Xâm Nhập Proksi', 'th': 'การแทรกซึมพร็อกซี', 'pt': 'Infiltração de Proxy', 'ru': 'Инфильтрация прокси', 'fr': 'Infiltration Proxy', 'ko': '프록시 침투', 'hi': 'प्रोक्सी घुसपैठ'});
      case "CORE_HARVEST":
        return _get({'en': 'Core Harvest', 'id': 'Panen Inti', 'es': 'Cosecha del Núcleo', 'vi': 'Thu Hoạch Lõi', 'th': 'การเก็บเกี่ยวคอร์', 'pt': 'Colheita de Núcleo', 'ru': 'Сбор ядра', 'fr': 'Récolte du Cœur', 'ko': '코어 수확', 'hi': 'कोर कटाई'});
      case "NEURAL_CASCADE":
        return _get({'en': 'Neural Cascade', 'id': 'Kaskade Neural', 'es': 'Cascada Neural', 'vi': 'Phân Tầng Thần Kinh', 'th': 'คาสเคดประสาท', 'pt': 'Cascata Neural', 'ru': 'Нейронный каскад', 'fr': 'Cascade Neurale', 'ko': '뉴럴 캐스케이드', 'hi': 'न्यूरल कैस्케이드'});
      case "MAINFRAME_CORE":
        return _get({'en': 'Mainframe Core', 'id': 'Inti Mainframe', 'es': 'Núcleo de Mainframe', 'vi': 'Lõi Mainframe', 'th': 'คอร์เมนเฟรม', 'pt': 'Núcleo do Mainframe', 'ru': 'Ядро мейнфрейма', 'fr': 'Cœur du Mainframe', 'ko': '메인프레임 코어', 'hi': 'मेनफ्रेम कोर'});
      case "CYBER_GATEWAY":
        return _get({'en': 'Cyber Gateway', 'id': 'Gerbang Siber', 'es': 'Puerta Cibernética', 'vi': 'Cổng Vào Cyber', 'th': 'เกตเวย์ไซเบอร์', 'pt': 'Gateway Cibernético', 'ru': 'Кибер-шлюз', 'fr': 'Passerelle Cyber', 'ko': '사이버 게이트웨이', 'hi': 'साइबर गेटवे'});
      case "QUANTUM_FIREWALL":
        return _get({'en': 'Quantum Firewall', 'id': 'Firewall Kuantum', 'es': 'Firewall Cuántico', 'vi': 'Tường Lửa Lượng Tử', 'th': 'ไฟร์วอลล์ควอนตัม', 'pt': 'Firewall Quântico', 'ru': 'Квантовый брандмауэр', 'fr': 'Pare-feu Quantique', 'ko': '퀀텀 방화벽', 'hi': 'क्वांटम फ़ायरवॉल'});
      case "BLACK_HAT_MATRIX":
        return _get({'en': 'Black Hat Matrix', 'id': 'Matriks Black Hat', 'es': 'Matriz Black Hat', 'vi': 'Ma Trận Black Hat', 'th': 'เมทริกซ์แบล็กแฮต', 'pt': 'Matriz Black Hat', 'ru': 'Матрица Black Hat', 'fr': 'Matrice Black Hat', 'ko': '블랙햇 매트릭스', 'hi': 'ब्लैक हैट मैट्रिक्स'});
      case "DEEP_NET_INFILTRATOR":
        return _get({'en': 'Deep Net Infiltrator', 'id': 'Penyusup Jaringan Dalam', 'es': 'Infiltrador de Red Profunda', 'vi': 'Kẻ Xâm Nhập Mạng Sâu', 'th': 'ผู้แทรกซึมดีปเน็ต', 'pt': 'Infiltrador de Rede Profunda', 'ru': 'Инфильтратор Deep Net', 'fr': 'Infiltrateur de Réseau Profond', 'ko': '딥넷 인필트레이터', 'hi': 'डीप नेट इनफिल्टरेटर'});
      case "THE_ROOT_OVERLORD":
        return _get({'en': 'The Root Overlord', 'id': 'Penguasa Root Utama', 'es': 'El Soberano Root', 'vi': 'Bá Chủ Root', 'th': 'ผู้ครองรูท', 'pt': 'O Soberano Root', 'ru': 'Оверлорд Root', 'fr': 'Le Souverain Root', 'ko': '루트 오버로드', 'hi': 'द रूट ओवरलॉर्ड'});
    }

    final parts = codeName.split('_');
    if (parts.length >= 2) {
      final prefKey = parts[0];
      final suffKey = parts[1];

      final prefMap = <String, Map<String, String>>{
        'NEURAL': {'en': 'Neural', 'id': 'Neural', 'es': 'Neural', 'vi': 'Thần Kinh', 'th': 'ประสาท', 'pt': 'Neural', 'ru': 'Нейро', 'fr': 'Neural', 'ko': '뉴럴', 'hi': 'न्यूरल'},
        'CYBER': {'en': 'Cyber', 'id': 'Siber', 'es': 'Ciber', 'vi': 'Cyber', 'th': 'ไซเบอร์', 'pt': 'Cyber', 'ru': 'Кибер', 'fr': 'Cyber', 'ko': '사이버', 'hi': 'साइबर'},
        'PROXY': {'en': 'Proxy', 'id': 'Proksi', 'es': 'Proxy', 'vi': 'Proksi', 'th': 'พร็อกซี', 'pt': 'Proxy', 'ru': 'Прокси', 'fr': 'Proxy', 'ko': '프록시', 'hi': 'प्रोक्सी'},
        'QUANTUM': {'en': 'Quantum', 'id': 'Kuantum', 'es': 'Cuántico', 'vi': 'Lượng Tử', 'th': 'ควอนตัม', 'pt': 'Quântico', 'ru': 'Квант', 'fr': 'Quantique', 'ko': '퀀텀', 'hi': 'क्वांटम'},
        'SHADOW': {'en': 'Shadow', 'id': 'Bayangan', 'es': 'Sombra', 'vi': 'Bóng Tối', 'th': 'เงา', 'pt': 'Sombra', 'ru': 'Тень', 'fr': 'Ombre', 'ko': '섀도우', 'hi': 'शैडो'},
        'GRID': {'en': 'Grid', 'id': 'Grid', 'es': 'Red', 'vi': 'Lưới', 'th': 'กริ๊ด', 'pt': 'Rede', 'ru': 'Сеть', 'fr': 'Grille', 'ko': '그리드', 'hi': 'ग्रिड'},
        'CORE': {'en': 'Core', 'id': 'Inti', 'es': 'Núcleo', 'vi': 'Lõi', 'th': 'คอร์', 'pt': 'Núcleo', 'ru': 'Ядро', 'fr': 'Cœur', 'ko': '코어', 'hi': 'कोर'},
        'NODE': {'en': 'Node', 'id': 'Simpul', 'es': 'Nodo', 'vi': 'Nút', 'th': 'โหนด', 'pt': 'Nó', 'ru': 'Узел', 'fr': 'Nœud', 'ko': '노드', 'hi': 'नोड'},
        'DATABANK': {'en': 'Databank', 'id': 'Bank Data', 'es': 'Banco de Datos', 'vi': 'Ngân Hàng Dữ Liệu', 'th': 'คลังข้อมูล', 'pt': 'Banco de Dados', 'ru': 'База данных', 'fr': 'Banque de Données', 'ko': '데이터뱅크', 'hi': 'डेटाबैंक'},
        'HYPER': {'en': 'Hyper', 'id': 'Hiper', 'es': 'Híper', 'vi': 'Hyper', 'th': 'ไฮเปอร์', 'pt': 'Hiper', 'ru': 'Гипер', 'fr': 'Hyper', 'ko': '하이퍼', 'hi': 'हाइपर'},
        'ROOT': {'en': 'Root', 'id': 'Root', 'es': 'Raíz', 'vi': 'Gốc', 'th': 'รูท', 'pt': 'Raiz', 'ru': 'Рут', 'fr': 'Racine', 'ko': '루트', 'hi': 'रूट'},
        'MAINFRAME': {'en': 'Mainframe', 'id': 'Mainframe', 'es': 'Mainframe', 'vi': 'Mainframe', 'th': 'เมนเฟรม', 'pt': 'Mainframe', 'ru': 'Мейнфрейм', 'fr': 'Mainframe', 'ko': '메인프레임', 'hi': 'मेनफ्रेम'},
        'VECTOR': {'en': 'Vector', 'id': 'Vektor', 'es': 'Vector', 'vi': 'Vector', 'th': 'เวกเตอร์', 'pt': 'Vetor', 'ru': 'Вектор', 'fr': 'Vecteur', 'ko': '벡터', 'hi': 'वेक्टर'},
        'SYNAPSE': {'en': 'Synapse', 'id': 'Sinapsis', 'es': 'Sinapsis', 'vi': 'Xináp', 'th': 'ซินแนปส์', 'pt': 'Sinapse', 'ru': 'Синапс', 'fr': 'Synapse', 'ko': '시냅스', 'hi': 'सिनैपส์'},
        'CRYPTO': {'en': 'Crypto', 'id': 'Kripto', 'es': 'Cripto', 'vi': 'Mã Hóa', 'th': 'คริปโท', 'pt': 'Cripto', 'ru': 'Крипто', 'fr': 'Crypto', 'ko': '크립토', 'hi': 'क्रिप्टो'},
        'GHOST': {'en': 'Ghost', 'id': 'Hantu', 'es': 'Fantasma', 'vi': 'Băng Hồn', 'th': 'เงาผี', 'pt': 'Fantasma', 'ru': 'Призрак', 'fr': 'Fantôme', 'ko': '고스트', 'hi': 'गोस्ट'},
      };

      final suffMap = <String, Map<String, String>>{
        'BREACH': {'en': 'Breach', 'id': 'Pelanggaran', 'es': 'Brecha', 'vi': 'Đột Phá', 'th': 'การเจาะ', 'pt': 'Quebra', 'ru': 'Прорыв', 'fr': 'Brèche', 'ko': '브리치', 'hi': 'ब्रीच'},
        'BYPASS': {'en': 'Bypass', 'id': 'Pintasan', 'es': 'Bypass', 'vi': 'Bỏ Qua', 'th': 'ทางเลี่ยง', 'pt': 'Bypass', 'ru': 'Обход', 'fr': 'Contournement', 'ko': '바이패스', 'hi': 'बायपास'},
        'HARVEST': {'en': 'Harvest', 'id': 'Panen', 'es': 'Cosecha', 'vi': 'Thu Hoạch', 'th': 'การเก็บเกี่ยว', 'pt': 'Colheita', 'ru': 'Сбор', 'fr': 'Récolte', 'ko': '하베스트', 'hi': 'हार्वेस्ट'},
        'OVERLORD': {'en': 'Overlord', 'id': 'Penguasa', 'es': 'Soberano', 'vi': 'Bá Chủ', 'th': 'ผู้ครอง', 'pt': 'Soberano', 'ru': 'Оверлорд', 'fr': 'Souverain', 'ko': '오버로드', 'hi': 'ओवरलॉर्ड'},
        'CASCADE': {'en': 'Cascade', 'id': 'Kaskade', 'es': 'Cascada', 'vi': 'Phân Tầng', 'th': 'คาสเคด', 'pt': 'Cascata', 'ru': 'Каскад', 'fr': 'Cascade', 'ko': '캐스케이드', 'hi': 'कैस्เคด'},
        'INTRUSION': {'en': 'Intrusion', 'id': 'Intrusi', 'es': 'Intrusión', 'vi': 'Xâm Nhập', 'th': 'การบุกรุก', 'pt': 'Intrusão', 'ru': 'Вторжение', 'fr': 'Intrusion', 'ko': '침입', 'hi': 'घुसपैठ'},
        'DECRYPT': {'en': 'Decrypt', 'id': 'Dekripsi', 'es': 'Descifrado', 'vi': 'Giải Mã', 'th': 'ถอดรหัส', 'pt': 'Decodificar', 'ru': 'Расшифровка', 'fr': 'Décryptage', 'ko': '디크립트', 'hi': 'डिक्रिप्ट'},
        'TUNNEL': {'en': 'Tunnel', 'id': 'Terowongan', 'es': 'Túnel', 'vi': 'Đường Hầm', 'th': 'อุโมงค์', 'pt': 'Túnel', 'ru': 'Туннель', 'fr': 'Tunnel', 'ko': '터널', 'hi': 'टनल'},
        'INFILTRATOR': {'en': 'Infiltrator', 'id': 'Penyusup', 'es': 'Infiltrador', 'vi': 'Kẻ Xâm Nhập', 'th': 'ผู้แทรกซึม', 'pt': 'Infiltrador', 'ru': 'Инфильтратор', 'fr': 'Infiltrateur', 'ko': '인필트레이터', 'hi': 'इनफिल्टरेटर'},
        'GATEWAY': {'en': 'Gateway', 'id': 'Gerbang', 'es': 'Puerta Entrada', 'vi': 'Cổng Vào', 'th': 'เกตเวย์', 'pt': 'Gateway', 'ru': 'Шлюз', 'fr': 'Passerelle', 'ko': '게이트เว이', 'hi': 'गेटเว'},
        'MATRIX': {'en': 'Matrix', 'id': 'Matriks', 'es': 'Matriz', 'vi': 'Ma Trận', 'th': 'เมทริกซ์', 'pt': 'Matriz', 'ru': 'Матрица', 'fr': 'Matrice', 'ko': '매트릭스', 'hi': 'मैट्रिक्स'},
        'MINING': {'en': 'Mining', 'id': 'Penambangan', 'es': 'Minería', 'vi': 'Khai Thác', 'th': 'การทำเหมือง', 'pt': 'Mineração', 'ru': 'Майнинг', 'fr': 'Minage', 'ko': '마이닝', 'hi': 'माइनिंग'},
        'ISOLATION': {'en': 'Isolation', 'id': 'Isolasi', 'es': 'Aislamiento', 'vi': 'Cách Ly', 'th': 'การแยก', 'pt': 'Isolamento', 'ru': 'Изоляция', 'fr': 'Isolement', 'ko': '격리', 'hi': 'अलगाव'},
        'INJECTOR': {'en': 'Injector', 'id': 'Injektor', 'es': 'Inyector', 'vi': 'Bộ Bơm', 'th': 'อินเจ็กเตอร์', 'pt': 'Injetor', 'ru': 'Инжектор', 'fr': 'Injecteur', 'ko': '인젝터', 'hi': 'इंजेक्टर'},
        'STRIKE': {'en': 'Strike', 'id': 'Serangan', 'es': 'Golpe', 'vi': 'Đòn Đánh', 'th': 'การโจมตี', 'pt': 'Golpe', 'ru': 'Удар', 'fr': 'Frappe', 'ko': '스트라이크', 'hi': 'स्ट्राइक'},
      };

      final prefTrans = prefMap.containsKey(prefKey) ? _get(prefMap[prefKey]!) : prefKey;
      final suffTrans = suffMap.containsKey(suffKey) ? _get(suffMap[suffKey]!) : suffKey;

      return '$prefTrans $suffTrans';
    }

    return codeName;
  }

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
        'fr': 'Chef de l\'Organisation Fantôme',
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

  static String get language => _get({
    'en': 'Language',
    'id': 'Bahasa',
    'es': 'Idioma',
    'vi': 'Ngôn Ngữ',
    'th': 'ภาษา',
    'pt': 'Idioma',
    'ru': 'Язык',
    'fr': 'Langue',
    'ko': '언어',
    'hi': 'भाषा',
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

  // --- Select Language Screen ---
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

  // --- Rules Screen Localization ---
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

  static String get rulesHeader01 => _get({
    'en': '01. Mission & Gameplay Objective',
    'id': '01. Misi & Tujuan Permainan',
    'es': '01. Misión y Objetivo del Juego',
    'vi': '01. Nhiệm Vụ & Mục Tiêu Trò Chơi',
    'th': '01. ภารกิจและวัตถุประสงค์ของเกม',
    'pt': '01. Missão e Objetivo do Jogo',
    'ru': '01. Миссия и цель игры',
    'fr': '01. Mission & Objectif du Jeu',
    'ko': '01. 미션 및 게임 목표',
    'hi': '01. मिशन और गेमप्ले का उद्देश्य',
  });

  static String get rulesCard1Title => _get({
    'en': 'What is CyberHex?',
    'id': 'Apa itu CyberHex?',
    'es': '¿Qué es CyberHex?',
    'vi': 'CyberHex là gì?',
    'th': 'CyberHex คืออะไร?',
    'pt': 'O que é o CyberHex?',
    'ru': 'Что такое CyberHex?',
    'fr': 'Qu\'est-ce que CyberHex ?',
    'ko': 'CyberHex란 무엇인가요?',
    'hi': 'CyberHex क्या है?',
  });

  static String get rulesCard1Desc => _get({
    'en': 'You play as an elite Node Hacker operating in the deep shadows. Your goal is to infiltrate high-security corporate node networks, breach their firewalls, harvest valuable data cores, and escape safely.',
    'id': 'Anda bermain sebagai Peretas Simpul elit di bayangan. Tujuan Anda adalah menyusup ke jaringan simpul perusahaan tingkat tinggi, menembus firewall, memanen inti data berharga, dan kabur dengan selamat.',
    'es': 'Juegas como un Hacker de Nodos de élite. Tu objetivo es infiltrarte en redes corporativas de alta seguridad, romper sus cortafuegos, cosechar núcleos de datos valiosos y escapar a salvo.',
    'vi': 'Bạn đóng vai một Hacker Nút ưu tú trong bóng tối. Mục tiêu của bạn là xâm nhập mạng lưới doanh nghiệp bảo mật cao, vượt tường lửa, thu thập dữ liệu và thoát an toàn.',
    'th': 'คุณเล่นเป็นแฮกเกอร์โหนดระดับแนวหน้า เป้าหมายของคุณคือการเจาะเครือข่ายองค์กร ทะลวงไฟร์วอลล์ เก็บเกี่ยวคอร์ข้อมูล และหลบหนีอย่างปลอดภัย',
    'pt': 'Você joga como um Hacker de Nós de elite nas sombras. Seu objetivo é se infiltrar em redes corporativas de alta segurança, quebrar seus firewalls, colher núcleos de dados e escapar em segurança.',
    'ru': 'Вы играете за элитного Хакера Узлов. Ваша цель — проникнуть в защищенные корпоративные сети, взломать брандмауэры, собрать ценные ядра данных и успешно уйти.',
    'fr': 'Vous incarnez un Hacker de Nœuds d\'élite. Votre objectif est de vous infiltrer dans les réseaux d\'entreprise, de franchir leurs pare-feu, de récolter des cœurs de données et de vous échapper.',
    'ko': '당신은 엘리트 노드 해커로 플레이합니다. 목표는 보안이 철저한 기업 노드 네트워크에 침투하여 방화벽을 뚫고 데이터 코어를 수집한 후 안전하게 탈출하는 것입니다.',
    'hi': 'आप एक एलीट नोड हैकर के रूप में खेलते हैं। आपका लक्ष्य कॉर्पोरेट नोड नेटवर्क में सेंध लगाना, उनके फ़ायरवॉल को तोड़ना, मूल्यवान डेटा कोर एकत्र करना और सुरक्षित रूप से निकलना है।',
  });

  static String get rulesCard2Title => _get({
    'en': 'Step-by-Step Gameplay Flow',
    'id': 'Alur Permainan Langkah demi Langkah',
    'es': 'Flujo de Juego Paso a Paso',
    'vi': 'Quy Trình Chơi Theo Từng Bước',
    'th': 'ขั้นตอนการเล่นเกมทีละขั้นตอน',
    'pt': 'Fluxo de Jogo Passo a Passo',
    'ru': 'Пошаговый игровой процесс',
    'fr': 'Déroulement du Jeu Étape par Étape',
    'ko': '단계별 게임플레이 흐름',
    'hi': 'चरण-दर-चरण गेमप्ले प्रवाह',
  });

  static String get rulesCard2Desc => _get({
    'en': '1. Select a Stage network target from the main menu.\n2. You start at the Start Node. The system highlights adjacent nodes that you can link to.\n3. Plan your route carefully: each node-to-node hop costs 1 MB of RAM.\n4. Capture Data Cores on the grid to accumulate credits.\n5. Evade patrol drones (moving along dotted lines) and avoid firewalls.\n6. Secure your escape by stepping on the magenta Extraction Port to complete the level.',
    'id': '1. Pilih target jaringan Tahap dari menu utama.\n2. Anda mulai di Simpul Awal. Sistem menampilkan simpul terdekat yang dapat dihubungkan.\n3. Rencanakan rute Anda: setiap langkah menghabiskan 1 MB RAM.\n4. Tangkap Inti Data untuk mengumpulkan kredit.\n5. Hindari dron patroli dan firewall.\n6. Amankan pelarian Anda dengan melangkah ke Port Ekstraksi magenta.',
    'es': '1. Selecciona una red objetivo desde el menú principal.\n2. Empiezas en el Nodo de Inicio. El sistema resalta los nodos adyacentes.\n3. Planifica tu ruta: cada salto cuesta 1 MB de RAM.\n4. Captura Núcleos de Datos para acumular créditos.\n5. Evita drones de patrulla y cortafuegos.\n6. Asegura tu escape pisando el Puerto de Extracción magenta.',
    'vi': '1. Chọn mạng mục tiêu từ menu chính.\n2. Bạn bắt đầu tại Nút Bắt Đầu. Hệ thống hiển thị các nút liền kề.\n3. Lên kế hoạch di chuyển: mỗi bước tốn 1 MB RAM.\n4. Thu thập Lõi Dữ Liệu để tích lũy tín dụng.\n5. Tránh né drones tuần tra và tường lửa.\n6. Trích xuất an toàn bằng cách bước vào Cổng Trích Xuất màu hồng.',
    'th': '1. เลือกเครือข่ายเป้าหมายจากเมนูหลัก\n2. คุณเริ่มต้นที่โหนดเริ่มต้น ระบบจะไฮไลต์โหนดที่เชื่อมต่อได้\n3. วางแผนเส้นทาง: การย้ายแต่ละครั้งใช้ 1 MB RAM\n4. เก็บ คอร์ข้อมูล เพื่อสะสมเครดิต\n5. หลบโดรนและไฟร์วอลล์\n6. หลบหนีอย่างปลอดภัยโดยไปที่ ประตูสกัดสีชมพู',
    'pt': '1. Selecione uma rede alvo no menu principal.\n2. Você começa no Nó Inicial. O sistema destaca nós adjacentes.\n3. Planeje sua rota: cada salto custa 1 MB de RAM.\n4. Capture Núcleos de Dados para acumular créditos.\n5. Evite drones de patrulha e firewalls.\n6. Garanta sua fuga pisando no Portão de Extração magenta.',
    'ru': '1. Выберите сеть на главном экране.\n2. Вы начинаете в Старт-узле. Доступные соседние узлы подсвечены.\n3. Каждое перемещение стоит 1 МБ RAM.\n4. Собирайте Ядра Данных для получения кредитов.\n5. Избегайте патрульных дронов и брандмауэров.\n6. Шагните в Порт Эвакуации маджента для завершения уровня.',
    'fr': '1. Sélectionnez un réseau cible sur le menu principal.\n2. Vous commencez au Nœud de Départ.\n3. Chaque saut coûte 1 Mo de RAM.\n4. Capturez des Cœurs de Données pour accumuler des crédits.\n5. Évitez les drones et les pare-feu.\n6. Échappez-vous via la Porte d\'Extraction magenta.',
    'ko': '1. 메인 메뉴에서 타겟 네트워크를 선택하세요.\n2. 시작 노드에서 출발합니다. 이동 가능한 인접 노드가 표시됩니다.\n3. 이동 시 1MB의 RAM이 소모되므로 경로를 계획하세요.\n4. 데이터 코어를 수집하여 크레딧을 획득하세요.\n5. 순찰 드론과 방화벽을 피하세요.\n6. 마젠타색 추출 포트로 이동하여 탈출하세요.',
    'hi': '1. मुख्य मेनू से लक्ष्य नेटवर्क चुनें।\n2. आप स्टार्ट नोड से शुरू करते हैं। जुड़े नोड्स हाइलाइट होते हैं।\n3. अपने मार्ग की योजना बनाएं: प्रत्येक कदम 1 MB RAM खपत करता है।\n4. क्रेडिट जमा करने के लिए डेटा कोर कैप्चर करें।\n5. ड्रोन और फ़ायरवॉल से बचें।\n6. स्तर पूरा करने के लिए मैजेंटा निष्कर्षण पोर्ट पर जाएं।',
  });

  static String get rulesHeader02 => _get({
    'en': '02. Node & Color-Wise Directory',
    'id': '02. Direktori Simpul & Warna',
    'es': '02. Directorio de Nodos y Colores',
    'vi': '02. Danh Mục Nút & Màu Sắc',
    'th': '02. ไดเรกทอรีโหนดและสี',
    'pt': '02. Diretório de Nós e Cores',
    'ru': '02. Справочник узлов и цветов',
    'fr': '02. Répertoire des Nœuds et Couleurs',
    'ko': '02. 노드 및 색상별 디렉토리',
    'hi': '02. नोड और रंग-वार निर्देशिका',
  });

  static String get rulesSection2Subtitle => _get({
    'en': 'Memorize the color codes to identify nodes instantly on the tactical map:',
    'id': 'Hafalkan kode warna untuk mengidentifikasi simpul di peta taktis:',
    'es': 'Memoriza los códigos de color para identificar nodos en el mapa:',
    'vi': 'Ghi nhớ mã màu để nhận diện nút ngay lập tức trên bản đồ:',
    'th': 'จำรหัสสีเพื่อระบุโหนดทันทีบนแผนที่ยุทธวิธี:',
    'pt': 'Memorize os códigos de cores para identificar nós no mapa tático:',
    'ru': 'Запомните цветовые коды для идентификации узлов на карте:',
    'fr': 'Mémorisez les codes couleur pour identifier les nœuds sur la carte :',
    'ko': '전술 지도에서 노드를 즉시 식별할 수 있도록 색상 코드를 기억하세요:',
    'hi': 'नक्शे पर तुरंत नोड्स की पहचान करने के लिए रंग कोड याद रखें:',
  });

  // Node Directory Items
  static String get nodeCyanTitle => _get({
    'en': 'Cyan Color (Hacker / Player Core)',
    'id': 'Warna Cyan (Peretas / Inti Pemain)',
    'es': 'Color Cian (Hacker / Núcleo Jugador)',
    'vi': 'Màu Xanh Cyan (Hacker / Người Chơi)',
    'th': 'สีฟ้า (แฮกเกอร์ / คอร์ผู้เล่น)',
    'pt': 'Cor Ciano (Hacker / Núcleo Jogador)',
    'ru': 'Голубой цвет (Хакер / Игрок)',
    'fr': 'Couleur Cyan (Hacker / Joueur)',
    'ko': '시안 색상 (해커 / 플레이어 코어)',
    'hi': 'सयान रंग (हैकर / प्लेयर कोर)',
  });

  static String get nodeCyanBadge => _get({
    'en': 'HACKER',
    'id': 'PERETAS',
    'es': 'HACKER',
    'vi': 'HACKER',
    'th': 'แฮกเกอร์',
    'pt': 'HACKER',
    'ru': 'ХАКЕР',
    'fr': 'HACKER',
    'ko': '해커',
    'hi': 'हैकर',
  });

  static String get nodeCyanDesc => _get({
    'en': 'Indicates your current active footprint in the network. A cyan target cursor showing where your system connection currently resides.',
    'id': 'Menunjukkan jejak aktif Anda di jaringan saat ini.',
    'es': 'Indica tu huella activa actual en la red.',
    'vi': 'Hiển thị vị trí kết nối hiện tại của bạn trong mạng.',
    'th': 'ระบุตำแหน่งการเชื่อมต่อที่ใช้อยู่ในปัจจุบันของคุณ',
    'pt': 'Indica sua presença ativa atual na rede.',
    'ru': 'Указывает ваше текущее активное положение в сети.',
    'fr': 'Indique votre position active actuelle dans le réseau.',
    'ko': '네트워크에서 현재 접속 중인 위치를 나타냅니다.',
    'hi': 'नेटवर्क में आपकी वर्तमान सक्रिय उपस्थिति को दर्शाता है।',
  });

  static String get nodeGreenTitle => _get({
    'en': 'Green Color (Data Core)',
    'id': 'Warna Hijau (Inti Data)',
    'es': 'Color Verde (Núcleo de Datos)',
    'vi': 'Màu Xanh Lá (Lõi Dữ Liệu)',
    'th': 'สีเขียว (คอร์ข้อมูล)',
    'pt': 'Cor Verde (Núcleo de Dados)',
    'ru': 'Зеленый цвет (Ядро данных)',
    'fr': 'Couleur Verte (Cœur de Données)',
    'ko': '녹색 색상 (데이터 코어)',
    'hi': 'हरा रंग (डेटा कोर)',
  });

  static String get nodeGreenBadge => _get({
    'en': '+DATA',
    'id': '+DATA',
    'es': '+DATOS',
    'vi': '+DATA',
    'th': '+ข้อมูล',
    'pt': '+DADOS',
    'ru': '+ДАННЫЕ',
    'fr': '+DONNÉES',
    'ko': '+데이터',
    'hi': '+डेटा',
  });

  static String get nodeGreenDesc => _get({
    'en': 'Secured database containing system credits. Step on these green nodes to harvest their value (+50 to +300 Credits).',
    'id': 'Basis data aman berisi kredit. Langkah ke simpul hijau untuk memanen nilai kredit (+50 hingga +300).',
    'es': 'Base de datos que contiene créditos. Pisa estos nodos verdes para cosecharlos (+50 a +300).',
    'vi': 'Cơ sở dữ liệu chứa tín dụng. Bước vào các nút xanh để thu thập (+50 đến +300 tín dụng).',
    'th': 'ฐานข้อมูลที่มีเครดิต เหยียบโหนดสีเขียวเพื่อเก็บเกี่ยว (+50 ถึง +300 เครดิต)',
    'pt': 'Banco de dados contendo créditos. Pise nesses nós para colhê-los (+50 a +300).',
    'ru': 'База данных с кредитами. Шагните на зеленый узел для сбора (+50 до +300 кредитов).',
    'fr': 'Base de données contenant des crédits (+50 à +300 crédits).',
    'ko': '크레딧이 포함된 데이터베이스입니다. 녹색 노드로 이동하여 크레딧을 획득하세요 (+50 ~ +300).',
    'hi': 'सुरक्षित डेटाबेस जिसमें क्रेडिट शामिल हैं। मूल्य एकत्र करने के लिए हरे नोड्स पर जाएं (+50 से +300)।',
  });

  static String get nodeRedTitle => _get({
    'en': 'Red Color (Firewall node)',
    'id': 'Warna Merah (Simpul Firewall)',
    'es': 'Color Rojo (Nodo Firewall)',
    'vi': 'Màu Đỏ (Nút Tường Lửa)',
    'th': 'สีแดง (โหนดไฟร์วอลล์)',
    'pt': 'Cor Vermelha (Nó Firewall)',
    'ru': 'Красный цвет (Брандмауэр)',
    'fr': 'Couleur Rouge (Nœud Pare-feu)',
    'ko': '빨간색 (방화벽 노드)',
    'hi': 'लाल रंग (फ़ायरवॉल नोड)',
  });

  static String get nodeRedBadge => _get({
    'en': 'HAZARD',
    'id': 'BAHAYA',
    'es': 'PELIGRO',
    'vi': 'NGUY HIỂM',
    'th': 'อันตราย',
    'pt': 'PERIGO',
    'ru': 'ОПАСНОСТЬ',
    'fr': 'DANGER',
    'ko': '위험',
    'hi': 'खतरा',
  });

  static String get nodeRedDesc => _get({
    'en': 'Secured corporate firewalls. Stepping on a red node instantly triggers alarm protocols, rising the Firewall Threat level by 25%.',
    'id': 'Firewall perusahaan. Melangkah ke simpul merah memicu alarm (+25% ancaman).',
    'es': 'Cortafuegos corporativos. Pisar un nodo rojo activa la alarma (+25% de amenaza).',
    'vi': 'Tường lửa doanh nghiệp. Giậm vào nút đỏ sẽ kích hoạt báo động (+25% mối đe dọa).',
    'th': 'ไฟร์วอลล์องค์กร การเหยียบโหนดสีแดงจะเปิดใช้งานการแจ้งเตือน (+25% ภัยคุกคาม)',
    'pt': 'Firewalls corporativos. Pisar em um nó vermelho ativa o alarme (+25% de ameaça).',
    'ru': 'Защитный брандмауэр. Нажатие активирует тревогу (+25% к уровню угрозы).',
    'fr': 'Pare-feu d\'entreprise. Marcher dessus déclenche l\'alarme (+25% de menace).',
    'ko': '방화벽 노드입니다. 이동 시 즉시 경보가 발생하여 위협 레벨이 25% 상승합니다.',
    'hi': 'सुरक्षित फ़ायरवॉल। लाल नोड पर जाने से अलार्म बजता है (+25% खतरा)।',
  });

  static String get nodeMagentaTitle => _get({
    'en': 'Magenta Color (Extraction Port)',
    'id': 'Warna Magenta (Port Ekstraksi)',
    'es': 'Color Magenta (Puerto de Extracción)',
    'vi': 'Màu Hồng Magenta (Cổng Trích Xuất)',
    'th': 'สีชมพู (ประตูสกัด)',
    'pt': 'Cor Magenta (Portão de Extração)',
    'ru': 'Пурпурный цвет (Порт эвакуации)',
    'fr': 'Couleur Magenta (Porte d\'Extraction)',
    'ko': '마젠타 색상 (추출 포트)',
    'hi': 'मैजेंटा रंग (निष्कर्षण पोर्ट)',
  });

  static String get nodeMagentaBadge => _get({
    'en': 'ESCAPE',
    'id': 'KABUR',
    'es': 'ESCAPAR',
    'vi': 'THOÁT',
    'th': 'หลบหนี',
    'pt': 'ESCAPAR',
    'ru': 'ПОБЕГ',
    'fr': 'ÉVASION',
    'ko': '탈출',
    'hi': 'बचाव',
  });

  static String get nodeMagentaDesc => _get({
    'en': 'A concentric magenta gateway circle representing the network exit. Stepping here successfully extracts you and saves your credits.',
    'id': 'Gerbang magenta tempat keluar jaringan. Melangkah ke sini untuk berhasil kabur.',
    'es': 'Puerta magenta de salida. Písala para extraer los datos y completar el nivel.',
    'vi': 'Cổng ra màu hồng đại diện cho lối thoát. Bước vào đây để hoàn thành cấp độ.',
    'th': 'ประตูสีชมพูซึ่งเป็นทางออก เหยียบตรงนี้เพื่อสกัดข้อมูลและสำเร็จระดับ',
    'pt': 'Portão magenta representando a saída da rede. Pise aqui para escapar.',
    'ru': 'Шлюз эвакуации. Нажатие сюда завершает уровень и сохраняет кредиты.',
    'fr': 'Porte de sortie du réseau. Échappez-vous et sauvegardez vos crédits.',
    'ko': '네트워크 출구입니다. 이곳으로 이동하면 레벨을 완료하고 탈출합니다.',
    'hi': 'नेटवर्क से बाहर निकलने का गेट। यहां पहुंचकर आप सुरक्षित बाहर निकल सकते हैं।',
  });

  static String get nodeAmberTitle => _get({
    'en': 'Amber Color (Security Patrol Drone)',
    'id': 'Warna Amber (Dron Patroli)',
    'es': 'Color Ámbar (Dron de Seguridad)',
    'vi': 'Màu Hổ Phách (Drone Tuần Tra)',
    'th': 'สีส้ม (โดรนตรวจการณ์)',
    'pt': 'Cor Âmbar (Drone de Patrulha)',
    'ru': 'Янтарный цвет (Патрульный дрон)',
    'fr': 'Couleur Ambre (Drone de Patrouille)',
    'ko': '호박색 (순찰 드론)',
    'hi': 'एम्बर रंग (सुरक्षा गश्ती ड्रोन)',
  });

  static String get nodeAmberBadge => _get({
    'en': 'AVOID',
    'id': 'HINDARI',
    'es': 'EVITAR',
    'vi': 'TRÁNH',
    'th': 'หลีกเลี่ยง',
    'pt': 'EVITAR',
    'ru': 'ИЗБЕГАТЬ',
    'fr': 'ÉVITER',
    'ko': '회피',
    'hi': 'बचें',
  });

  static String get nodeAmberDesc => _get({
    'en': 'Patrolling node security system. Drones move along dotted amber lines each turn. If they crash into you, your connection is terminated.',
    'id': 'Sistem keamanan dron. Dron bergerak di sepanjang garis titik-titik kuning.',
    'es': 'Drones de seguridad. Se mueven por las líneas punteadas en cada turno.',
    'vi': 'Hệ thống drone tuần tra di chuyển theo đường chấm vàng mỗi lượt.',
    'th': 'โดรนตรวจการณ์ เคลื่อนที่ตามเส้นประสีส้มในแต่ละตา',
    'pt': 'Drones de segurança que se movem pelas linhas pontilhadas a cada turno.',
    'ru': 'Патрульный дрон. Перемещается по пунктирной линии каждый ход.',
    'fr': 'Drones de patrouille. Se déplacent le long des lignes pointillées.',
    'ko': '순찰 드론입니다. 턴마다 점선을 따라 이동하며 부딪히면 연결이 종료됩니다.',
    'hi': 'गश्ती सुरक्षा ड्रोन। यदि वे आपसे टकराते हैं, तो कनेक्शन समाप्त हो जाएगा।',
  });

  static String get rulesHeader03 => _get({
    'en': '03. Main Settings & Stages Details',
    'id': '03. Pengaturan Utama & Detail Tahap',
    'es': '03. Ajustes Principales y Detalles de Etapas',
    'vi': '03. Cài Đặt Chính & Chi Tiết Các Giai Đoạn',
    'th': '03. การตั้งค่าหลักและรายละเอียดขั้นตอน',
    'pt': '03. Configurações Principais e Detalhes das Etapas',
    'ru': '03. Основные настройки и детали этапов',
    'fr': '03. Paramètres Principaux & Détails des Étapes',
    'ko': '03. 주요 설정 및 스테이지 상세 정보',
    'hi': '03. मुख्य सेटिंग्स और चरण विवरण',
  });

  static String get rulesSection3Card1Title => _get({
    'en': 'Total Game Stages (60 Levels)',
    'id': 'Total Tahap Permainan (60 Tingkat)',
    'es': 'Etapas Totales del Juego (60 Niveles)',
    'vi': 'Tổng Số Giai Đoạn (60 Cấp Độ)',
    'th': 'ขั้นตอนทั้งหมดในเกม (60 ระดับ)',
    'pt': 'Total de Etapas do Jogo (60 Níveis)',
    'ru': 'Всего этапов игры (60 уровней)',
    'fr': 'Nombre Total d\'Étapes (60 Niveaux)',
    'ko': '전체 게임 스테이지 (60개 레벨)',
    'hi': 'कुल गेम चरण (60 स्तर)',
  });

  static String get rulesSection3Card1Desc => _get({
    'en': 'The mainframe contains three classes of stages:\n• Stages 01 - 10: Handcrafted subnets introducing basic elements and patrol routes.\n• Stages 11 - 50: Procedural normal networks with varying complexity, bigger layouts, and multiple cores.\n• Stages 51 - 60: Hardcore mainframe nodes with extremely tight RAM (12-16 MB), high speed firewalls (28% to 32% threat growth rate), and dense firewall node placements.',
    'id': 'Mainframe memiliki 3 kelas tahap:\n• Tahap 01 - 10: Subnet buatan tangan mengenalkan elemen dasar.\n• Tahap 11 - 50: Jaringan prosedural dengan kompleksitas bervariasi.\n• Tahap 51 - 60: Tahap hardcore dengan RAM sangat terbatas (12-16 MB) dan firewall cepat.',
    'es': 'El mainframe contiene 3 clases de etapas:\n• Etapas 01 - 10: Subredes iniciales con elementos básicos.\n• Etapas 11 - 50: Redes procedimentales de complejidad variable.\n• Etapas 51 - 60: Nodos hardcore con RAM muy ajustada (12-16 MB) y firewalls veloces.',
    'vi': 'Hệ thống gồm 3 nhóm giai đoạn:\n• Giai đoạn 01 - 10: Mạng giới thiệu cơ bản.\n• Giai đoạn 11 - 50: Mạng ngẫu nhiên với độ phức tạp tăng dần.\n• Giai đoạn 51 - 60: Các cấp độ siêu khó với RAM cực kỳ ít (12-16 MB).',
    'th': 'เมนเฟรมมีขั้นตอน 3 ระดับ:\n• ขั้นตอน 01 - 10: ซับเน็ตพื้นฐานแนะนำองค์ประกอบ\n• ขั้นตอน 11 - 50: เครือข่ายปกติที่มีความซับซ้อนหลากหลาย\n• ขั้นตอน 51 - 60: โหมดฮาร์ดคอร์ที่มี RAM จำกัดอย่างมาก (12-16 MB)',
    'pt': 'O mainframe contém 3 classes de etapas:\n• Etapas 01 - 10: Sub-redes básicas introduzindo elementos.\n• Etapas 11 - 50: Redes procedurais com complexidade variável.\n• Etapas 51 - 60: Nós hardcore com RAM muito apertada (12-16 MB).',
    'ru': 'Мейнфрейм содержит 3 категории этапов:\n• Этапы 01 - 10: Базовые подсети для знакомства.\n• Этапы 11 - 50: Процедурные сети разной сложности.\n• Этапы 51 - 60: Хардкорные узлы с жестким лимитом RAM (12-16 МБ).',
    'fr': 'Le mainframe contient 3 catégories d\'étapes :\n• Étapes 01 - 10 : Sous-réseaux de base.\n• Étapes 11 - 50 : Réseaux procéduraux de complexité variable.\n• Étapes 51 - 60 : Niveaux hardcore avec RAM limitée (12-16 Mo).',
    'ko': '메인프레임은 3가지 유형의 스테이지로 구성됩니다:\n• 스테이지 01 - 10: 기본 요소와 순찰 경로를 소개하는 튜토리얼 스테이지.\n• 스테이지 11 - 50: 다양한 난이도의 절차적 생성 네트워크.\n• 스테이지 51 - 60: 극도로 제한된 RAM(12-16MB)과 빠른 방화벽의 하드코어 스테이지.',
    'hi': 'मेनफ्रेम में तीन प्रकार के चरण होते हैं:\n• चरण 01 - 10: बुनियादी तत्व सिखाने वाले शुरुआती स्तर।\n• चरण 11 - 50: बढ़ती जटिलता वाले सामान्य नेटवर्क।\n• चरण 51 - 60: अत्यंत सीमित RAM (12-16 MB) और तेज़ फ़ायरवॉल वाले कठिन स्तर।',
  });

  static String get rulesSection3Card2Title => _get({
    'en': 'Upgrades Terminal',
    'id': 'Terminal Peningkatan',
    'es': 'Terminal de Mejoras',
    'vi': 'Trạm Nâng Cấp',
    'th': 'เทอร์มินัลอัปเกรด',
    'pt': 'Terminal de Melhorias',
    'ru': 'Терминал улучшений',
    'fr': 'Terminal d\'Améliorations',
    'ko': '업그레이드 터미널',
    'hi': 'अपग्रेड टर्मिनल',
  });

  static String get rulesSection3Card2Desc => _get({
    'en': 'Redeem your green data core credits to bypass strict security barriers:\n• RAM Overclock: Adds +2 MB of RAM limits per upgrade level.\n• Signal Jammer: Slows down firewall threat accumulation by 15% per upgrade level.\n• Decoy Signature: Deploys decoys so security drones ignore you for 3 moves.',
    'id': 'Tukarkan kredit inti data untuk melewati rintangan keamanan:\n• RAM Overclock: +2 MB batas RAM per tingkat.\n• Signal Jammer: Memperlambat pertumbuhan firewall sebesar 15%.\n• Decoy Signature: Dron mengabaikan Anda selama 3 langkah.',
    'es': 'Canjea créditos para superar barreras de seguridad:\n• RAM Overclock: +2 MB de RAM por nivel.\n• Signal Jammer: Reduce el crecimiento de amenaza en 15%.\n• Decoy Signature: Los drones te ignoran durante 3 turnos.',
    'vi': 'Đổi tín dụng dữ liệu để vượt qua rào cản bảo mật:\n• RAM Overclock: Thêm +2 MB RAM mỗi cấp.\n• Signal Jammer: Giảm tốc độ tăng tường lửa đi 15%.\n• Decoy Signature: Drones bỏ qua bạn trong 3 bước đầu.',
    'th': 'แลกเครดิตข้อมูลเพื่อข้ามสิ่งกีดขวางความปลอดภัย:\n• RAM Overclock: เพิ่ม +2 MB RAM ต่อระดับ\n• Signal Jammer: ชะลอการเติบโตของไฟร์วอลล์ลง 15%\n• Decoy Signature: โดรนจะละเว้นคุณเป็นเวลา 3 ตา',
    'pt': 'Resgate créditos para ignorar barreiras de segurança:\n• RAM Overclock: +2 MB de RAM por nível.\n• Signal Jammer: Desacelera a ameaça do firewall em 15%.\n• Decoy Signature: Drones ignoram você por 3 movimentos.',
    'ru': 'Обменивайте кредиты на улучшения системы:\n• Оверклок RAM: +2 МБ RAM за каждый уровень.\n• Глушитель сигнала: Замедляет рост угрозы на 15%.\n• Сигнальная приманка: Дроны игнорируют вас 3 хода.',
    'fr': 'Échangez vos crédits pour franchir les barrières :\n• Surcadencage RAM : +2 Mo de RAM par niveau.\n• Brouilleur de Signal : Ralentit la menace de 15%.\n• Signature Leurres : Les drones vous ignorent pendant 3 coups.',
    'ko': '데이터 크레딧을 사용하여 보안 장벽을 우회하세요:\n• RAM 오버클럭: 레벨당 +2MB RAM 추가.\n• 신호 재머: 방화벽 위협 증가 속도를 15% 감소.\n• 디코이 시그니처: 드론이 3턴 동안 플레이어를 무시합니다.',
    'hi': 'क्रेडिट भुनाकर सुरक्षा बाधाओं को पार करें:\n• RAM ओवरक्लॉक: प्रति स्तर +2 MB RAM जोड़ता है।\n• सिग्नल जैमर: फ़ायरवॉल खतरे की गति 15% कम करता है।\n• डिकॉय सिग्नेचर: ड्रोन 3 चालों तक आपको अनदेखा करते हैं।',
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

  // --- General, Privacy Policy, Feedback & Rate Us ---
  static String get generalSection => _get({
    'en': 'General',
    'id': 'Umum',
    'es': 'General',
    'vi': 'Chung',
    'th': 'ทั่วไป',
    'pt': 'Geral',
    'ru': 'Общие',
    'fr': 'Général',
    'ko': '일반',
    'hi': 'सामान्य',
  });

  static String get privacyPolicy => _get({
    'en': 'Privacy Policy',
    'id': 'Kebijakan Privasi',
    'es': 'Política de Privacidad',
    'vi': 'Chính Sách Bảo Mật',
    'th': 'นโยบายความเป็นส่วนตัว',
    'pt': 'Política de Privacidade',
    'ru': 'Политика конфиденциальности',
    'fr': 'Politique de Confidentialité',
    'ko': '개인정보 처리방침',
    'hi': 'गोपनीयता नीति',
  });

  static String get feedback => _get({
    'en': 'Feedback',
    'id': 'Umpan Balik',
    'es': 'Comentarios',
    'vi': 'Phản Hồi',
    'th': 'ข้อเสนอแนะ',
    'pt': 'Feedback',
    'ru': 'Обратная связь',
    'fr': 'Commentaires',
    'ko': '피드백',
    'hi': 'प्रतिक्रिया',
  });

  static String get rateUs => _get({
    'en': 'Rate Us',
    'id': 'Beri Nilai Kami',
    'es': 'Valóranos',
    'vi': 'Đánh Giá Chúng Tôi',
    'th': 'ให้คะแนนเรา',
    'pt': 'Avalie-nos',
    'ru': 'Оценить нас',
    'fr': 'Évaluez-nous',
    'ko': '평가하기',
    'hi': 'हमें रेट करें',
  });

  static String get feedbackCategoryLabel => _get({
    'en': 'Feedback Type',
    'id': 'Tipe Umpan Balik',
    'es': 'Tipo de Comentario',
    'vi': 'Loại Phản Hồi',
    'th': 'ประเภทข้อเสนอแนะ',
    'pt': 'Tipo de Feedback',
    'ru': 'Тип отзыва',
    'fr': 'Type de Commentaire',
    'ko': '피드백 유형',
    'hi': 'प्रतिक्रिया प्रकार',
  });

  static String get fbOptNotWorking => _get({
    'en': 'App Not Working',
    'id': 'Aplikasi Tidak Bekerja',
    'es': 'La App No Funciona',
    'vi': 'Ứng Dụng Không Hoạt Động',
    'th': 'แอปไม่ทำงาน',
    'pt': 'Aplicativo Não Funciona',
    'ru': 'Приложение не работает',
    'fr': 'L\'application Ne Fonctionne Pas',
    'ko': '앱이 작동하지 않음',
    'hi': 'ऐप काम नहीं कर रहा है',
  });

  static String get fbOptLag => _get({
    'en': 'Game Lag / Freeze',
    'id': 'Game Lag / Macet',
    'es': 'Juego Lag / Congelado',
    'vi': 'Game Giật / Lag',
    'th': 'เกมแล็ก / ค้าง',
    'pt': 'Jogo Com Lag / Travando',
    'ru': 'Игра лагает / зависает',
    'fr': 'Jeu Rame / Bloqué',
    'ko': '게임 렉 / 멈춤',
    'hi': 'गेम लैग / फ़्रीज़',
  });

  static String get fbOptControls => _get({
    'en': 'Controls Not Working',
    'id': 'Kontrol Tidak Bekerja',
    'es': 'Controles No Funcionan',
    'vi': 'Điều Khiển Không Hoạt Động',
    'th': 'ปุ่มควบคุมไม่ทำงาน',
    'pt': 'Controles Não Funcionam',
    'ru': 'Управление не работает',
    'fr': 'Les Commandes Ne Fonctionnent Pas',
    'ko': '조작이 되지 않음',
    'hi': 'नियंत्रण काम नहीं कर रहे',
  });

  static String get fbOptAudio => _get({
    'en': 'Audio / Sound Issue',
    'id': 'Masalah Audio / Suara',
    'es': 'Problema de Audio / Sonido',
    'vi': 'Lỗi Âm Thanh',
    'th': 'ปัญหาเสียง',
    'pt': 'Problema de Áudio / Som',
    'ru': 'Проблема со звуком',
    'fr': 'Problème Audio / Son',
    'ko': '오디오 / 사운드 문제',
    'hi': 'ऑडियो / ध्वनि समस्या',
  });

  static String get fbOptLevel => _get({
    'en': 'Level / Stage Issue',
    'id': 'Masalah Level / Tahap',
    'es': 'Problema de Nivel / Etapa',
    'vi': 'Lỗi Cấp Độ / Giai Đoạn',
    'th': 'ปัญหาด่าน / ขั้นตอน',
    'pt': 'Problema de Nível / Etapa',
    'ru': 'Проблема с уровнем / этапом',
    'fr': 'Problème de Niveau / Étape',
    'ko': '레벨 / 스테이지 문제',
    'hi': 'स्तर / चरण समस्या',
  });

  static String get fbOptOther => _get({
    'en': 'Other App Issue',
    'id': 'Masalah Aplikasi Lainnya',
    'es': 'Otro Problema de la App',
    'vi': 'Vấn Đề Khác',
    'th': 'ปัญหาอื่นๆ ของแอป',
    'pt': 'Outro Problema do App',
    'ru': 'Другая проблема',
    'fr': 'Autre Problème',
    'ko': '기타 앱 문제',
    'hi': 'अन्य ऐप समस्या',
  });

  static String get feedbackMessageHint => _get({
    'en': 'Describe your feedback or suggestion...',
    'id': 'Jelaskan umpan balik Anda...',
    'es': 'Describe tu sugerencia...',
    'vi': 'Mô tả phản hồi của bạn...',
    'th': 'อธิบายข้อเสนอแนะของคุณ...',
    'pt': 'Descreva seu feedback...',
    'ru': 'Опишите ваш отзыв...',
    'fr': 'Décrivez votre commentaire...',
    'ko': '피드백을 작성해주세요...',
    'hi': 'अपनी प्रतिक्रिया का वर्णन करें...',
  });

  static String get feedbackEmailHint => _get({
    'en': 'Your Email (Optional)',
    'id': 'Email Anda (Opsional)',
    'es': 'Tu Correo (Opcional)',
    'vi': 'Email Của Bạn (Tùy chọn)',
    'th': 'อีเมลของคุณ (ไม่บังคับ)',
    'pt': 'Seu E-mail (Opcional)',
    'ru': 'Ваш Email (необязательно)',
    'fr': 'Votre Email (Optionnel)',
    'ko': '이메일 (선택사항)',
    'hi': 'आपका ईमेल (वैकल्पिक)',
  });

  static String get submitFeedback => _get({
    'en': 'Submit Feedback',
    'id': 'Kirim Umpan Balik',
    'es': 'Enviar Comentarios',
    'vi': 'Gửi Phản Hồi',
    'th': 'ส่งข้อเสนอแนะ',
    'pt': 'Enviar Feedback',
    'ru': 'Отправить отзыв',
    'fr': 'Envoyer le Commentaire',
    'ko': '피드백 제출',
    'hi': 'प्रतिक्रिया जमा करें',
  });

  static String get feedbackSuccessToast => _get({
    'en': 'Feedback transmitted to mainframe server!',
    'id': 'Umpan balik berhasil dikirim!',
    'es': '¡Comentario transmitido con éxito!',
    'vi': 'Đã gửi phản hồi thành công!',
    'th': 'ส่งข้อเสนอแนะสำเร็จแล้ว!',
    'pt': 'Feedback enviado com sucesso!',
    'ru': 'Отзыв успешно отправлен!',
    'fr': 'Commentaire transmis avec succès !',
    'ko': '피드백이 성공적으로 전송되었습니다!',
    'hi': 'प्रतिक्रिया सफलतापूर्वक भेजी गई!',
  });

  static String get rateTitle => _get({
    'en': 'Rate CyberHex',
    'id': 'Beri Nilai CyberHex',
    'es': 'Calificar CyberHex',
    'vi': 'Đánh Giá CyberHex',
    'th': 'ให้คะแนน CyberHex',
    'pt': 'Avaliar CyberHex',
    'ru': 'Оценить CyberHex',
    'fr': 'Évaluer CyberHex',
    'ko': 'CyberHex 평가',
    'hi': 'CyberHex को रेट करें',
  });

  static String get rateDesc => _get({
    'en': 'How would you rate your node hacking experience?',
    'id': 'Bagaimana pengalaman peretasan Anda?',
    'es': '¿Cómo calificarías tu experiencia?',
    'vi': 'Bạn đánh giá trải nghiệm hack thế nào?',
    'th': 'คุณให้คะแนนประสบการณ์แฮกอย่างไร?',
    'pt': 'Como você avalia sua experiência?',
    'ru': 'Как вы оцените игру?',
    'fr': 'Comment évaluez-vous votre expérience ?',
    'ko': '게임 경험은 어떠셨나요?',
    'hi': 'आप अपने अनुभव को कैसे रेट करेंगे?',
  });
}
