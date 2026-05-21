CREATE DATABASE IF NOT EXISTS alpukat_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE alpukat_db;

CREATE TABLE admin (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    nama VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE kategori (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(100) NOT NULL,
    slug VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE produk (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(200) NOT NULL,
    slug VARCHAR(200) NOT NULL UNIQUE,
    kategori_id INT,
    harga DECIMAL(15,2) NOT NULL,
    stok INT DEFAULT 0,
    deskripsi TEXT,
    gambar VARCHAR(255),
    berat DECIMAL(10,2) DEFAULT 0,
    satuan VARCHAR(20) DEFAULT 'kg',
    aktif TINYINT(1) DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (kategori_id) REFERENCES kategori(id)
);

CREATE TABLE pembeli (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    telepon VARCHAR(20),
    alamat TEXT,
    kota VARCHAR(100),
    provinsi VARCHAR(100),
    kode_pos VARCHAR(10),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE pesanan (
    id INT AUTO_INCREMENT PRIMARY KEY,
    kode_pesanan VARCHAR(20) NOT NULL UNIQUE,
    pembeli_id INT,
    total DECIMAL(15,2) NOT NULL,
    ongkir DECIMAL(15,2) DEFAULT 0,
    status ENUM('pending','dibayar','diproses','dikirim','selesai','dibatalkan') DEFAULT 'pending',
    catatan TEXT,
    bukti_bayar VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (pembeli_id) REFERENCES pembeli(id)
);

CREATE TABLE detail_pesanan (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pesanan_id INT,
    produk_id INT,
    nama_produk VARCHAR(200),
    harga DECIMAL(15,2),
    jumlah INT,
    subtotal DECIMAL(15,2),
    FOREIGN KEY (pesanan_id) REFERENCES pesanan(id),
    FOREIGN KEY (produk_id) REFERENCES produk(id)
);

CREATE TABLE edukasi (
    id INT AUTO_INCREMENT PRIMARY KEY,
    judul VARCHAR(200) NOT NULL,
    konten TEXT NOT NULL,
    gambar VARCHAR(255),
    kategori VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert admin default (password: admin123)
INSERT INTO admin (username, password, nama) VALUES
('admin', 'pbkdf2:sha256:260000$salt$hashedpassword', 'Administrator');

-- Insert kategori
INSERT INTO kategori (nama, slug) VALUES
('Buah Alpukat', 'buah-alpukat'),
('Bibit Alpukat', 'bibit-alpukat');

-- Insert 15 Produk Buah Alpukat
INSERT INTO produk (nama, slug, kategori_id, harga, stok, deskripsi, berat, satuan, gambar) VALUES
('Alpukat Mentega Premium', 'alpukat-mentega-premium', 1, 35000, 100, 'Alpukat mentega kualitas premium, daging tebal lembut dan creamy. Dipetik langsung dari kebun terpilih.', 0.5, 'kg', 'alpukat1.jpg'),
('Alpukat Hass Super', 'alpukat-hass-super', 1, 45000, 80, 'Alpukat Hass impor berkualitas tinggi, kulit gelap dan daging kuning cerah. Rasa gurih dan kaya nutrisi.', 0.3, 'kg', 'alpukat2.jpg'),
('Alpukat Aligator Jumbo', 'alpukat-aligator-jumbo', 1, 55000, 60, 'Alpukat Aligator berukuran jumbo, bobot hingga 1-1.5 kg per buah. Daging tebal dan bijinya kecil.', 1.0, 'kg', 'alpukat3.jpg'),
('Alpukat Kendil Organik', 'alpukat-kendil-organik', 1, 40000, 75, 'Alpukat kendil ditanam secara organik tanpa pestisida kimia. Aman untuk seluruh keluarga.', 0.4, 'kg', 'alpukat4.jpg'),
('Alpukat Miki Manis', 'alpukat-miki-manis', 1, 30000, 90, 'Alpukat Miki dengan rasa yang lebih manis dari jenis lain. Cocok untuk jus dan smoothie.', 0.3, 'kg', 'alpukat5.jpg'),
('Alpukat Wina Lembut', 'alpukat-wina-lembut', 1, 38000, 70, 'Alpukat Wina terkenal dengan tekstur daging yang sangat lembut. Favorit untuk membuat guacamole.', 0.4, 'kg', 'alpukat6.jpg'),
('Alpukat Pluwang Besar', 'alpukat-pluwang-besar', 1, 50000, 50, 'Alpukat Pluwang berukuran besar, khas Jawa Tengah. Rasa kaya dan bernutrisi tinggi.', 0.8, 'kg', 'alpukat7.jpg'),
('Alpukat Fuerte Segar', 'alpukat-fuerte-segar', 1, 42000, 65, 'Alpukat Fuerte segar dipanen pagi hari. Kulit hijau halus dan daging berwarna kuning pucat.', 0.35, 'kg', 'alpukat8.jpg'),
('Alpukat Booth 7 Import', 'alpukat-booth7-import', 1, 60000, 40, 'Alpukat Booth 7 varietas impor premium. Daging tebal, biji kecil, rasa creamy istimewa.', 0.5, 'kg', 'alpukat9.jpg'),
('Alpukat Lula Florida', 'alpukat-lula-florida', 1, 48000, 55, 'Alpukat Lula asal Florida berukuran sedang-besar. Kandungan lemak sehat tinggi, baik untuk diet.', 0.6, 'kg', 'alpukat10.jpg'),
('Alpukat Sharwil Australia', 'alpukat-sharwil-australia', 1, 65000, 35, 'Alpukat Sharwil impor Australia, tekstur mirip Hass namun lebih halus dan rasa lebih kaya.', 0.4, 'kg', 'alpukat11.jpg'),
('Alpukat Reed Besar', 'alpukat-reed-besar', 1, 52000, 45, 'Alpukat Reed ukuran besar seperti bola, daging padat dan rasa kacang yang kuat. Jarang di pasaran.', 0.7, 'kg', 'alpukat12.jpg'),
('Alpukat Pinkerton Hijau', 'alpukat-pinkerton-hijau', 1, 44000, 60, 'Alpukat Pinkerton berbentuk panjang dengan biji kecil. Daging oranye kekuningan, rasa mild.', 0.45, 'kg', 'alpukat13.jpg'),
('Alpukat Ettinger Israel', 'alpukat-ettinger-israel', 1, 58000, 30, 'Alpukat Ettinger dari Israel, kulit hijau dan halus. Daging pucat dengan rasa yang ringan dan segar.', 0.5, 'kg', 'alpukat14.jpg'),
('Paket Alpukat Mix 3 kg', 'paket-alpukat-mix-3kg', 1, 95000, 25, 'Paket hemat 3 kg berisi campuran berbagai varietas alpukat pilihan. Cocok untuk keluarga besar.', 3.0, 'paket', 'alpukat15.jpg'),

-- Insert 15 Produk Bibit Alpukat
('Bibit Alpukat Mentega Okulasi', 'bibit-mentega-okulasi', 2, 25000, 200, 'Bibit alpukat mentega hasil okulasi, usia 3 bulan siap tanam. Tinggi 30-40 cm, kondisi sehat.', 0.5, 'pohon', 'bibit1.jpg'),
('Bibit Alpukat Hass Grafting', 'bibit-hass-grafting', 2, 35000, 150, 'Bibit alpukat Hass hasil grafting, berbuah lebih cepat 1-2 tahun. Bersertifikat dari balai benih.', 0.6, 'pohon', 'bibit2.jpg'),
('Bibit Alpukat Aligator Cangkok', 'bibit-aligator-cangkok', 2, 40000, 120, 'Bibit alpukat Aligator hasil cangkok dari pohon induk produktif. Berbuah lebat dan cepat berbuah.', 0.7, 'pohon', 'bibit3.jpg'),
('Bibit Alpukat Kendil Bersertifikat', 'bibit-kendil-bersertifikat', 2, 30000, 180, 'Bibit alpukat Kendil bersertifikat BPSB, bebas hama dan penyakit. Garansi tumbuh 100%.', 0.5, 'pohon', 'bibit4.jpg'),
('Bibit Alpukat Miki Polybag', 'bibit-miki-polybag', 2, 20000, 250, 'Bibit alpukat Miki dalam polybag 20x30 cm. Cocok ditanam di pot atau lahan. Mudah perawatannya.', 0.4, 'pohon', 'bibit5.jpg'),
('Bibit Alpukat Wina Unggul', 'bibit-wina-unggul', 2, 28000, 160, 'Bibit alpukat Wina unggul seleksi, pertumbuhan cepat dan produktivitas tinggi. Usia 2-3 bulan.', 0.5, 'pohon', 'bibit6.jpg'),
('Bibit Alpukat Booth Impor', 'bibit-booth-impor', 2, 75000, 80, 'Bibit alpukat Booth varietas impor. Berbuah besar dengan nilai jual tinggi. Cocok untuk agribisnis.', 1.0, 'pohon', 'bibit7.jpg'),
('Bibit Alpukat Fuerte Hibrida', 'bibit-fuerte-hibrida', 2, 45000, 100, 'Bibit alpukat Fuerte hibrida unggul, tahan penyakit dan cuaca ekstrem. Adaptif di berbagai ketinggian.', 0.7, 'pohon', 'bibit8.jpg'),
('Bibit Alpukat Sidat Okulasi', 'bibit-sidat-okulasi', 2, 32000, 140, 'Bibit alpukat Sidat okulasi dari entres pohon berumur >10 tahun. Sudah terbukti produktif.', 0.6, 'pohon', 'bibit9.jpg'),
('Bibit Alpukat Lula Stek', 'bibit-lula-stek', 2, 38000, 110, 'Bibit alpukat Lula hasil stek dengan hormon perangsang. Sistem akar kuat dan pertumbuhan cepat.', 0.6, 'pohon', 'bibit10.jpg'),
('Paket Bibit 5 Pohon Mix', 'paket-bibit-5-pohon', 2, 120000, 50, 'Paket 5 bibit alpukat berbagai varietas unggul. Hemat untuk kebun keluarga atau bisnis kecil.', 3.0, 'paket', 'bibit11.jpg'),
('Paket Bibit 10 Pohon Mentega', 'paket-bibit-10-mentega', 2, 220000, 40, 'Paket 10 bibit alpukat mentega untuk perkebunan. Diskon khusus dan gratis konsultasi perawatan.', 5.0, 'paket', 'bibit12.jpg'),
('Bibit Alpukat Nano Dwarf', 'bibit-alpukat-nano-dwarf', 2, 85000, 60, 'Bibit alpukat nano/dwarf cocok ditanam di pot dalam rumah. Tinggi maksimal 2m dan tetap berbuah.', 0.8, 'pohon', 'bibit13.jpg'),
('Bibit Alpukat Pinkerton Okulasi', 'bibit-pinkerton-okulasi', 2, 42000, 90, 'Bibit Pinkerton okulasi, varietas langka dengan produktivitas tinggi dan biji sangat kecil.', 0.7, 'pohon', 'bibit14.jpg'),
('Paket Starter Kebun Alpukat', 'paket-starter-kebun', 2, 350000, 20, 'Paket lengkap memulai kebun: 10 bibit pilihan + pupuk organik + media tanam + panduan budidaya.', 10.0, 'paket', 'bibit15.jpg');

-- Insert edukasi
INSERT INTO edukasi (judul, konten, kategori, gambar) VALUES
('Mengenal Jenis-Jenis Alpukat Unggulan Indonesia', 'Alpukat (Persea americana) merupakan buah tropis yang kaya manfaat. Di Indonesia terdapat beberapa varietas unggulan seperti Alpukat Mentega yang terkenal dengan daging tebalnya, Alpukat Hass dengan kulit berwarna gelap saat matang, dan Alpukat Aligator yang berukuran jumbo...', 'buah', 'edukasi1.jpg'),
('Cara Menanam Bibit Alpukat yang Benar', 'Menanam alpukat membutuhkan persiapan yang matang. Pilih lahan dengan sinar matahari penuh, tanah gembur dan drainase baik. Buat lubang tanam 60x60x60 cm, campurkan tanah dengan pupuk kandang matang dengan perbandingan 1:1...', 'bibit', 'edukasi2.jpg'),
('Manfaat Alpukat untuk Kesehatan Tubuh', 'Alpukat adalah superfood yang kaya lemak sehat (asam oleat), vitamin E, K, C, B5, B6, potasium, dan folat. Konsumsi alpukat rutin terbukti menyehatkan jantung, membantu penyerapan nutrisi, menjaga kesehatan mata, dan mendukung program diet sehat...', 'kesehatan', 'edukasi3.jpg'),
('Tips Memilih Alpukat yang Matang dan Berkualitas', 'Memilih alpukat yang tepat adalah seni tersendiri. Tekan ujung buah dengan lembut - jika sedikit lunak berarti sudah matang. Kulit Hass yang matang berwarna ungu-hitam gelap. Jangan memilih buah yang terlalu lunak atau memiliki bintik-bintik coklat...', 'tips', 'edukasi4.jpg'),
('Cara Budidaya Alpukat Organik Tanpa Pestisida', 'Budidaya alpukat organik semakin diminati karena nilai jual lebih tinggi dan ramah lingkungan. Gunakan pupuk organik dari kotoran sapi/kambing yang sudah matang. Kendalikan hama dengan pestisida nabati dari bahan-bahan alami seperti bawang putih dan cabai...', 'budidaya', 'edukasi5.jpg');