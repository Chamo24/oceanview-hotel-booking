package com.oceanview.controller;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.oceanview.model.Reservation;
import com.oceanview.service.ReservationService;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/api/reservations")
public class ReservationApiServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private ReservationService reservationService;
    private Gson gson;

    @Override
    public void init() throws ServletException {
        reservationService = new ReservationService();
        gson = new GsonBuilder()
            .setDateFormat("yyyy-MM-dd HH:mm:ss")
            .create();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        String action = request.getParameter("action");
        String idStr = request.getParameter("id");
        String number = request.getParameter("number");

        try {
            if ("count".equals(action)) {
                List<Reservation> all = reservationService.getAllReservations();
                long confirmed = 0;
                long checkedOut = 0;
                long cancelled = 0;
                for (Reservation r : all) {
                    if ("Confirmed".equals(r.getStatus())) confirmed++;
                    if ("Checked-Out".equals(r.getStatus())) checkedOut++;
                    if ("Cancelled".equals(r.getStatus())) cancelled++;
                }
                Map<String, Object> counts = new HashMap<String, Object>();
                counts.put("total", all.size());
                counts.put("confirmed", confirmed);
                counts.put("checkedOut", checkedOut);
                counts.put("cancelled", cancelled);
                out.print(gson.toJson(counts));

            } else if (idStr != null) {
                int reservationId = Integer.parseInt(idStr);
                Reservation reservation = reservationService.getReservationById(reservationId);
                if (reservation != null) {
                    out.print(gson.toJson(reservation));
                } else {
                    response.setStatus(404);
                    Map<String, String> error = new HashMap<String, String>();
                    error.put("error", "Reservation not found");
                    out.print(gson.toJson(error));
                }

            } else if (number != null) {
                Reservation reservation = reservationService.getReservationByNumber(number);
                if (reservation != null) {
                    out.print(gson.toJson(reservation));
                } else {
                    response.setStatus(404);
                    Map<String, String> error = new HashMap<String, String>();
                    error.put("error", "Reservation not found");
                    out.print(gson.toJson(error));
                }

            } else {
                List<Reservation> reservations = reservationService.getAllReservations();
                out.print(gson.toJson(reservations));
            }

        } catch (Exception e) {
            response.setStatus(500);
            Map<String, String> error = new HashMap<String, String>();
            error.put("error", e.getMessage());
            out.print(gson.toJson(error));
        }

        out.flush();
    }
}