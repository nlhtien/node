// File: server.js
const express = require('express');
const bodyParser = require('body-parser');
const fs = require('fs');

const app = express();
const port = 3000;

app.use(bodyParser.json());
app.use(bodyParser.raw({ type: 'application/json' }));

const receivedMessages = [];

app.post('/send-message', (req, res) => {
  try {
    const dataString = req.body.toString();
    console.log('Received data:', dataString);

    // Kiểm tra xem có phải là JSON hay không
    if (!dataString.startsWith('{')) {
      throw new Error('Not a JSON data');
    }

    const data = JSON.parse(dataString);
    const { message, timestamp } = data;

    console.log(`Received message: ${message} (${timestamp})`);
    receivedMessages.push({ message, timestamp });

    // Kiểm tra nếu tin nhắn là lệnh gửi ảnh
    if (message === 'send-image') {
      const imageData = req.body.slice(req.body.indexOf('{'));
      const imageFileName = `picture2/${timestamp}.jpeg`;

      // Lưu ảnh vào thư mục picture2
      fs.writeFileSync(imageFileName, imageData);

      console.log(`Image saved: ${imageFileName}`);
    }

    // Kiểm tra nếu tin nhắn là lệnh kết thúc
    if (message === 'terminate-server') {
      console.log('Terminating server...');
      process.exit(0); // Kết thúc quá trình Node.js
    }

    res.json({ status: 'success', message: 'Message received' });
  } catch (error) {
    console.error('Error:', error.message);
    res.status(400).json({ status: 'error', message: 'Invalid data' });
  }
});

app.get('/get-messages', (req, res) => {
  res.json({ messages: receivedMessages });
});

app.listen(port, () => {
  console.log(`Server is running at http://localhost:${port}`);
});

