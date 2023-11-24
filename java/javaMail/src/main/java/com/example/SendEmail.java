package com.example

import javax.mail.*;
import javax.mail.internet.*;

import java.util.Properties;

public class SendEmail {

    public static void main(String[] args) {

        // ?置?件服?器
        Properties properties = new Properties();
        properties.put("mail.smtp.host", "localhost");
        properties.put("mail.smtp.port", "2525"); // 或FakeSMTP配置的其他端口

        // ?建会?
        Session session = Session.getDefaultInstance(properties);

        try {
            // ?建一个默?的MimeMessage?象
            Message message = new MimeMessage(session);

            // ?置 From: header field
            message.setFrom(new InternetAddress("your-email@example.com"));

            // ?置 To: header field
            message.setRecipients(Message.RecipientType.TO,
                    InternetAddress.parse("recipient@example.com"));

            // ?置 Subject: header field
            message.setSubject("Test Mail from Java Program");

            // ?置消息体
            message.setText("This is a test mail from Java program using FakeSMTP!");

            // ?送消息
            Transport.send(message);

            System.out.println("Sent message successfully....");

        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }
    }
}
