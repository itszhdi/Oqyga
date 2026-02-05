
// для запуска - node index.js

const { Client, LocalAuth } = require('whatsapp-web.js');
const qrcode = require('qrcode-terminal');
const express = require('express');

const app = express();

// Настройка для приема JSON-данных
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

const PORT = 3000;

const client = new Client({
    authStrategy: new LocalAuth(),
    puppeteer: {
        headless: true,
        executablePath: process.env.PUPPETEER_EXECUTABLE_PATH || undefined, 
        args: [
            '--no-sandbox',
            '--disable-setuid-sandbox',
            '--disable-dev-shm-usage',
            '--disable-accelerated-2d-canvas',
            '--no-first-run',
            '--no-zygote',
            '--disable-gpu'
        ],
    }
});

let isClientReady = false;

client.on('qr', (qr) => {
    console.log('>>> QR-код получен. Сканируйте его через WhatsApp:');
    qrcode.generate(qr, { small: true });
});

client.on('ready', () => {
    console.log('>>> WhatsApp клиент готов к работе!');
    isClientReady = true;
});

client.on('authenticated', () => {
    console.log('>>> Авторизация прошла успешно');
});

client.on('auth_failure', msg => {
    console.error('>>> ОШИБКА АВТОРИЗАЦИИ:', msg);
});

client.on('disconnected', (reason) => {
    console.log('>>> Клиент отключен:', reason);
    isClientReady = false;
    
    client.initialize();
});

// 3. API Эндпоинт для отправки сообщений
app.post('/api/send-otp', async (req, res) => {
    try {
        // Проверка: пришел ли JSON вообще
        if (!req.body || Object.keys(req.body).length === 0) {
            return res.status(400).json({ 
                error: 'Тело запроса пустое. Убедитесь, что отправляете JSON и заголовок Content-Type: application/json' 
            });
        }

        const { phone, message } = req.body;

        // Валидация данных
        if (!phone || !message) {
            return res.status(400).json({ error: 'Необходимо указать phone и message' });
        }

        // Проверка готовности клиента
        if (!isClientReady) {
            return res.status(503).json({ error: 'WhatsApp клиент еще загружается или не авторизован (отсканируйте QR)' });
        }

        // Очистка номера телефона от лишних символов (+, пробелы, тире)
        const cleanNumber = phone.toString().replace(/\D/g, '');
        
        // Формирование ID чата (для обычных номеров это номер@c.us)
        const chatId = `${cleanNumber}@c.us`;

        // Проверка: зарегистрирован ли номер в WhatsApp
        const isRegistered = await client.isRegisteredUser(chatId);
        if (!isRegistered) {
            return res.status(404).json({ error: 'Этот номер не зарегистрирован в WhatsApp' });
        }

        // Отправка сообщения
        await client.sendMessage(chatId, message);
        console.log(`[Успех] Сообщение отправлено на номер: ${cleanNumber}`);

        res.status(200).json({ 
            status: 'success', 
            details: `Сообщение успешно отправлено на номер ${cleanNumber}` 
        });

    } catch (error) {
        console.error('[Ошибка API]:', error);
        res.status(500).json({ 
            error: 'Произошла внутренняя ошибка при отправке', 
            details: error.message 
        });
    }
});

client.on('loading_screen', (percent, message) => {
    console.log('ЗАГРУЗКА:', percent, '% -', message);
});

client.initialize();

app.listen(PORT, () => {
    console.log(`\n==============================================`);
    console.log(`Сервер запущен на: http://localhost:${PORT}`);
    console.log(`Эндпоинт: POST http://localhost:${PORT}/api/send-otp`);
    console.log(`==============================================\n`);
});