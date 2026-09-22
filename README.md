# 🔥 پنل VodiWalker

یک پنل قدرتمند، سریع و حرفه‌ای برای مدیریت سرویس‌ها و کانفیگ‌ها، با طراحی مدرن و امکانات کاربردی.

⚡ پشتیبانی از پروتکل‌های TCP و WS
🚀 سرعت و پایداری بالا
🔐 امنیت و مدیریت آسان
💻 سازگار با سیستم‌ها و دستگاه‌های مختلف

کانال تلگرام: https://t.me/vodiwalkervpn03

---

# 🚀 دیپلوی روی Render.com (راهنمای کامل)

## روش ۱: دیپلوی از طریق داشبورد Render (ساده‌ترین روش)

### قدم ۱ — ریپو رو پوش کن
اگر فایل‌های اصلاح‌شده رو داری، به گیتهاب خودت پوش کن:

```bash
git clone https://github.com/zamaneslamdust1/openui.git
cd openui
# فایل‌های اصلاح‌شده رو جایگزین کن، بعد:
git add .
git commit -m "Fix files for Render deployment"
git push origin main
```

### قدم ۲ — ساخت Web Service در Render
1. برو به [dashboard.render.com](https://dashboard.render.com) و با گیتهابت لاگین کن
2. روی **New +** کلیک کن و **Web Service** رو انتخاب کن
3. ریپوی `zamaneslamdust1/openui` رو وصل کن (اگر تو لیست نیست، از **Connect repository** دستی اضافه کن)
4. تنظیمات رو این‌طوری بذار:

| تنظیم | مقدار |
|---|---|
| **Runtime** | `Docker` |
| **Region** | `Frankfurt` (نزدیک‌ترین به ایران) |
| **Branch** | `main` |
| **Instance Type** | `Free` (برای تست) یا `Starter` (برای استفاده واقعی) |

5. بخش **Environment Variables**، این متغیرها رو اضافه کن:

| کلید | مقدار |
|---|---|
| `ADMIN_USERNAME` | نام کاربری ادمین (مثلاً `VodiAdmin`) |
| `ADMIN_PASSWORD` | یه رمز قوی و اختصاصی |
| `SECRET_KEY` | خالی بذار یا رشته تصادفی بذار |

> بقیه متغیرها (`PORT` و `RENDER_EXTERNAL_URL`) رو **خود Render خودکار ست می‌کنه** — لازم نیست دستی وارد کنی.

6. روی **Create Web Service** بزن و صبر کن بیلد تموم شه (۲–۳ دقیقه)

### قدم ۳ — بعد از دیپلوی
- Render یه آدرس بهت میده مثل: `https://vodiwalker-panel.onrender.com`
- برو به همون آدرس، با `ADMIN_USERNAME` و `ADMIN_PASSWORD` لاگین کن
- (اختیاری ولی توصیه‌شده) برگرد به **Environment** و متغیر `PUBLIC_BASE_URL` رو با دامنه‌ای که گرفتی پر کن تا لینک‌های اشتراک همیشه درست ساخته بشن

---

## روش ۲: دیپلوی خودکار با Blueprint

اگه ریپو رو با فایل `render.yaml` پوش کنی، کافیه توی Render:
1. **New +** → **Blueprint**
2. ریپوتو انتخاب کن
3. Render خودش همه‌چیز رو از `render.yaml` می‌خونه (فقط `ADMIN_USERNAME` و `ADMIN_PASSWORD` رو ازت می‌پرسه)

---

## ⚠️ نکات مهم

### پلن Free
- بعد از ۱۵ دقیقه بی‌استفاده بودن، سرویس **خواب می‌ره**؛ درخواست بعدی چند ثانیه طول می‌کشه تا بیدار شه
- **داده‌ها دائمی نیستن** — با هر دیپلوی/ری‌استارت، لینک‌ها و تنظیمات پنل پاک میشن
- برای استفاده واقعی، پلن **Starter** + **Disk** بگیر (۱ گیگ کافیه)

### فعال‌سازی دیسک دائمی (پلن پولی)
1. توی تنظیمات سرویس برو به **Disks** → **Add Disk**
2. Mount Path رو بذار: `/var/data`
3. توی Environment متغیر `DATA_DIR` رو بذار: `/var/data`
4. دوباره Deploy کن — از این به بعد داده‌ها باقی می‌مونن

### محدودیت TCP روی Render
- پنل وب و رله **VLESS-WS** کامل کار می‌کنن ✅ (از طریق پورت HTTPS)
- رله **VLESS-TCP خام** (پورت 6543) روی Render قابل دسترس عمومی نیست ❌ — Render مثل Railway قابلیت TCP Proxy نداره. برای کانفیگ‌های TCP از سرویس‌های دیگه (VPS یا Railway) استفاده کن

### اتصال ربات تلگرام (اختیاری)
توی Environment این‌ها رو اضافه کن:
- `TELEGRAM_BOT_TOKEN` → توکن ربات از [@BotFather](https://t.me/BotFather)
- `TELEGRAM_ADMIN_IDS` → آیدی عددی ادمین‌ها با کاما (مثلاً `123456789`)

---

## 🛠 اجرای محلی (تست)

```bash
pip install -r requirements.txt
ADMIN_USERNAME=admin ADMIN_PASSWORD=test123 python3 main.py
# پنل: http://localhost:8000
```

---

## 📁 ساختار فایل‌ها

```
├── main.py              # اپ اصلی FastAPI
├── pages.py             # رابط کاربری پنل
├── relay_vless.py       # رله VLESS-WS
├── tcp_relay.py         # رله VLESS-TCP
├── telegram_bot.py      # ربات فروش تلگرام
├── sales.py / speed_limit.py / xhttp_siz10.py
├── Dockerfile           # بیلد Render
├── render.yaml          # Blueprint دیپلوی خودکار
├── railway.json         # تنظیمات Railway (اگه خواستی اونجا هم دیپلوی کنی)
└── data/                # دیتای پنل (در زمان اجرا ساخته میشه)
```
