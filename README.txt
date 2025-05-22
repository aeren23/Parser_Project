# 📌 EMA Parser Dili (CENG 218 Proje)

Bu proje, **CENG 218 Programlama Dilleri Teorik Dersi** kapsamında tasarlanan ve geliştirilen, C-benzeri sözdizimine sahip bir alan özgü dil (**DSL**) olan **EMA Parser Dili**’nin Flex ve Bison ile yazılmış parser sistemini içermektedir.

---

## 📖 Proje Amacı

Bu projenin amacı, C-benzeri sözdizimine sahip, basit çizim komutları ve temel programlama yapıları barındıran bir alan özgü dil (DSL) tasarlamak ve bu dilin söz dizimi analizini yapan bir **parser** geliştirmektir. Parser, verilen programın dil gramerine uygunluğunu kontrol eder, uygun ise “[Başarılı] Kod gramer kurallarına uygundur.” mesajı verir. Hatalarda ise satır numarası ile birlikte hata mesajı döner.

---

## 📜 EMA Parser Dili Özellikleri

### 📌 Yorum Satırları

- `--` ile başlayan satırlar yorum kabul edilir ve çalıştırılmaz.

**Örnek:**
```text
-- Bu bir yorum satırıdır
x =: 5 -- Satır sonu yorumu
```

---

### 📌 Değişken Tanımlama ve Atama

- Değişkenler sayı veya string olabilir.
- Atama işlemi için `=:` operatörü kullanılır.

**Örnek:**
```text
x =: 10
isim =: "Ali"
```

---

### 📌 Aritmetik Operatörler

| Operatör | Anlamı    |
|----------|-----------|
| +        | Toplama   |
| -        | Çıkarma   |
| *        | Çarpma    |
| /        | Bölme     |
| %        | Mod alma  |
| **       | Üs alma   |
| //       | Karekök   |

---

### 📌 Karşılaştırma Operatörleri

| Operatör | Anlamı           |
|----------|------------------|
| <        | Küçüktür         |
| >        | Büyüktür         |
| <=       | Küçük veya eşit  |
| >=       | Büyük veya eşit  |
| =        | Eşittir          |
| =/=      | Eşit değildir    |

---

### 📌 Mantıksal Operatörler

| Operatör | Anlamı |
|----------|--------|
| and      | Ve     |
| or       | Veya   |
| ~        | Değil  |

---

### 📌 Blok Yapısı

- `{ ... }` içerisinde birden fazla komut gruplandırılır.

---

### 📌 Koşul Yapısı (if-else)

**Örnek:**
```text
if x < 5 then {
  print "x küçük"
} else {
  print "x büyük veya eşit"
}
```

---

### 📌 Döngü Yapısı (loop)

**Örnek:**
```text
loop (x > 0) {
  print x
  x =: x - 1
}
```

---

### 📌 Fonksiyonlar

- Fonksiyonlar `function` ile tanımlanır, `endfunc` ile biter.
- Parametre alabilir, `return` ile değer döndürebilir.

**Tanım:**
```text
function topla(a, b) {
  print a + b
} endfunc
```
**Çağrı:**
```text
topla(3, 5)
```

---

### 📌 Çizim Komutları

- `draw_circle x y r`
- `draw_line x1 y1 x2 y2`
- `draw_rectangle en boy`
- `draw_triangle taban yukseklik`

---

### 📌 Klavye Girişi

**Örnek:**
```text
if key_pressed key_UP then {
  y =: y - 5
}
```

---

## 📂 Proje Dosyaları

| Dosya               | Açıklama                                  |
|---------------------|-------------------------------------------|
| `parser.l`          | Lexical analiz kuralları (token tanımları)|
| `parser.y`          | Parser gramer kuralları ve C kodları      |
| `Makefile`          | Derleme komutları                         |
| `test_program.dsl`  | Örnek test DSL dosyası                    |
| `README.md`         | Proje açıklama dosyası                    |

---

## 🛠️ Derleme ve Çalıştırma

### **Derlemek için:**
```bash
make
```
veya manuel olarak:
```bash
bison -d parser.y
flex parser.l
gcc -o parser parser.tab.c lex.yy.c -lfl -lm
```

### **Çalıştırmak için:**
```bash
./parser < test_program.dsl
```

---

## 📊 Örnek Test Çıktısı

```text
42
75
Daire çizildi: (50,50) yariçap: 25
Çizgi: (0,0) → (100,100)
[Başarili] Kod gramer kurallarina uygundur.
```

---

## 📎 Önemli Notlar

- Her DSL dosyasında yalnızca 1 adet ana blok (BODY) kullanılmalıdır. Aksi halde parser hata verir.
- Yazım hatalarında satır numarası ve hata mesajı ile geri bildirim yapılır.
- Flex & Bison bağımlılıkları gereklidir.

---

## 👥 Ekip

- **Ali Eren Oğuztaş** — https://github.com/aeren23
- **Melih Boyacı** — https://github.com/melihboyaci
- **Ersin Demirel** — https://github.com/ersindemirel10

---

## 📌 Sonuç

Bu proje kapsamında, C-benzeri bir sözdizimine sahip, temel programlama kontrol yapılarını ve çizim komutlarını destekleyen bir alan özgü dil (DSL) tasarlanıp, Flex ve Bison ile söz dizimi kontrolü gerçekleştirilmiş ve başarılı şekilde çalıştırılmıştır.

**EMA Parser Dili**, çizim işlemleri ve program kontrol akışı için CENG 218 kapsamında örnek alınabilecek başarılı bir DSL örneğidir.
