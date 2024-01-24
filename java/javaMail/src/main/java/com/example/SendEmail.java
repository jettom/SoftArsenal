package com.example;

import javax.mail.*;
import javax.mail.internet.*;

import java.util.Properties;

public class SendEmail {

    public static void main(String[] args) {

        // ?�u?����?��
        Properties properties = new Properties();
        properties.put("mail.smtp.host", "192.168.0.88");
        properties.put("mail.smtp.port", "2525"); // ��FakeSMTP�z�u�I�����[��

        // ?����?
        Session session = Session.getDefaultInstance(properties);

        try {
            // ?���꘢��?�IMimeMessage?��
            Message message = new MimeMessage(session);

            // ?�u From: header field
            message.setFrom(new InternetAddress("your-email@example.com"));

            // ?�u To: header field
            message.setRecipients(Message.RecipientType.TO,
                    InternetAddress.parse("recipient@example.com"));

            // ?�u Subject: header field
            message.setSubject("Test Mail from Java Program");

            // ?�u������
            message.setText("This is a test mail from Java program using FakeSMTP!");

            // ?������
            Transport.send(message);

            System.out.println("Sent message successfully....");

        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }
    }
}
