package com.oceanview.service;

import com.oceanview.dao.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 * EmailService - Real Email Notifications using JavaMail API
 * Uses Gmail SMTP for sending emails
 * Complex functionality requirement
 */
public class EmailService {

    // ⚠️ Your Gmail credentials
    private static final String FROM_EMAIL = "your-email@gmail.com";
    private static final String APP_PASSWORD = "your-app-password-here";

    /**
     * Send real email using Gmail SMTP
     */
    private boolean sendEmail(String toEmail, String subject, 
                              String body) {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.ssl.trust", "smtp.gmail.com");

        Session session = Session.getInstance(props,
            new javax.mail.Authenticator() {
                protected PasswordAuthentication 
                        getPasswordAuthentication() {
                    return new PasswordAuthentication(
                        FROM_EMAIL, APP_PASSWORD);
                }
            });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_EMAIL));
            message.setRecipients(Message.RecipientType.TO,
                InternetAddress.parse(toEmail));
            message.setSubject(subject);
            message.setText(body);

            Transport.send(message);
            System.out.println("[EMAIL SUCCESS] Sent to: " + toEmail);

            // Log to database
            logEmail(toEmail, subject, body, "SENT");
            return true;

        } catch (MessagingException e) {
            System.err.println("[EMAIL ERROR] " + e.getMessage());
            logEmail(toEmail, subject, body, "FAILED");
            return false;
        }
    }

    /**
     * Send reservation confirmation email
     */
    public boolean sendReservationConfirmation(String guestName,
            String toEmail, String reservationNumber,
            String roomType, String checkIn, String checkOut) {

        String subject = "Reservation Confirmed - Ocean View Resort";
        String body = 
            "Dear " + guestName + ",\n\n" +
            "Your reservation has been confirmed!\n\n" +
            "Reservation Number: " + reservationNumber + "\n" +
            "Room Type: " + roomType + "\n" +
            "Check-in: " + checkIn + "\n" +
            "Check-out: " + checkOut + "\n\n" +
            "Thank you for choosing Ocean View Resort!\n" +
            "No. 42, Lighthouse Street, Galle Fort, Galle, Sri Lanka\n" +
            "Tel: +94 91 223 4567\n" +
            "Email: info@oceanviewgalle.lk";

        return sendEmail(toEmail, subject, body);
    }

    /**
     * Send bill email
     */
    public boolean sendBillEmail(String guestName, String toEmail,
            String reservationNumber, double amount) {

        String subject = "Bill Generated - Ocean View Resort";
        String body = 
            "Dear " + guestName + ",\n\n" +
            "Your bill has been generated.\n\n" +
            "Reservation: " + reservationNumber + "\n" +
            "Total Amount: LKR " + amount + "\n\n" +
            "Thank you for staying with us!\n" +
            "Ocean View Resort, Galle, Sri Lanka";

        return sendEmail(toEmail, subject, body);
    }

    /**
     * Log email to database
     */
    private boolean logEmail(String recipient, String subject,
            String message, String status) {

        String sql = "INSERT INTO email_logs (recipient, subject, " +
                     "message, status, sent_at) " +
                     "VALUES (?, ?, ?, ?, NOW())";

        try (Connection conn = 
                DBConnection.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, recipient);
            stmt.setString(2, subject);
            stmt.setString(3, message);
            stmt.setString(4, status);
            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("[EMAIL LOG ERROR] " + e.getMessage());
            return false;
        }
    }
}