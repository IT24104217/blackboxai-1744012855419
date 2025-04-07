package com.bikerental.util;

import com.bikerental.model.Bike;
import java.io.*;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

public class FileHandler {
    private static final String BIKES_FILE = "bikes.txt";
    private static final String OWNERS_FILE = "owners.txt";
    private static final String LOG_FILE = "actions.log";
    private static final DateTimeFormatter TIMESTAMP_FORMAT = 
        DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    // Initialize files if they don't exist
    static {
        try {
            if (!Files.exists(Paths.get(BIKES_FILE))) {
                Files.createFile(Paths.get(BIKES_FILE));
                logAction("System", "Created bikes data file");
            }
            if (!Files.exists(Paths.get(OWNERS_FILE))) {
                Files.createFile(Paths.get(OWNERS_FILE));
                // Add default admin owner
                writeOwner("admin", "admin123");
                logAction("System", "Created owners data file with default admin");
            }
            if (!Files.exists(Paths.get(LOG_FILE))) {
                Files.createFile(Paths.get(LOG_FILE));
            }
        } catch (IOException e) {
            System.err.println("Error initializing files: " + e.getMessage());
        }
    }

    // Bike CRUD Operations
    public static List<Bike> getAllBikes() {
        try {
            return Files.lines(Paths.get(BIKES_FILE))
                .map(FileHandler::parseBike)
                .collect(Collectors.toList());
        } catch (IOException e) {
            logError("Error reading bikes file", e);
            return new ArrayList<>();
        }
    }

    public static Bike getBikeById(String id) {
        return getAllBikes().stream()
            .filter(b -> b.getId().equals(id))
            .findFirst()
            .orElse(null);
    }

    public static boolean saveBike(Bike bike) {
        List<Bike> bikes = getAllBikes();
        bikes.add(bike);
        return writeAllBikes(bikes);
    }

    public static boolean updateBike(Bike updatedBike) {
        List<Bike> bikes = getAllBikes();
        bikes = bikes.stream()
            .map(b -> b.getId().equals(updatedBike.getId()) ? updatedBike : b)
            .collect(Collectors.toList());
        return writeAllBikes(bikes);
    }

    public static boolean deleteBike(String id) {
        List<Bike> bikes = getAllBikes();
        bikes = bikes.stream()
            .filter(b -> !b.getId().equals(id))
            .collect(Collectors.toList());
        return writeAllBikes(bikes);
    }

    // Owner Authentication
    public static boolean validateOwner(String username, String password) {
        try {
            return Files.lines(Paths.get(OWNERS_FILE))
                .anyMatch(line -> {
                    String[] parts = line.split(",");
                    return parts.length == 2 && 
                           parts[0].equals(username) && 
                           parts[1].equals(password);
                });
        } catch (IOException e) {
            logError("Error validating owner", e);
            return false;
        }
    }

    public static boolean writeOwner(String username, String password) {
        try (BufferedWriter writer = Files.newBufferedWriter(
            Paths.get(OWNERS_FILE), java.nio.file.StandardOpenOption.APPEND)) {
            writer.write(username + "," + password + "\n");
            return true;
        } catch (IOException e) {
            logError("Error writing owner", e);
            return false;
        }
    }

    // Logging
    public static void logAction(String actor, String action) {
        try (BufferedWriter writer = Files.newBufferedWriter(
            Paths.get(LOG_FILE), java.nio.file.StandardOpenOption.APPEND)) {
            writer.write(String.format("[%s] %s: %s\n", 
                LocalDateTime.now().format(TIMESTAMP_FORMAT), 
                actor, 
                action));
        } catch (IOException e) {
            System.err.println("Error writing to log file: " + e.getMessage());
        }
    }

    // Helper Methods
    private static boolean writeAllBikes(List<Bike> bikes) {
        try (BufferedWriter writer = Files.newBufferedWriter(Paths.get(BIKES_FILE))) {
            for (Bike bike : bikes) {
                writer.write(serializeBike(bike) + "\n");
            }
            return true;
        } catch (IOException e) {
            logError("Error writing bikes file", e);
            return false;
        }
    }

    private static String serializeBike(Bike bike) {
        return String.join(",",
            bike.getId(),
            bike.getName(),
            String.valueOf(bike.getPrice()),
            bike.getImageUrl(),
            String.valueOf(bike.isAvailable()),
            bike.getDescription(),
            bike.getCategory(),
            bike.getLastUpdated()
        );
    }

    private static Bike parseBike(String line) {
        String[] parts = line.split(",");
        if (parts.length >= 5) {
            Bike bike = new Bike();
            bike.setId(parts[0]);
            bike.setName(parts[1]);
            bike.setPrice(Double.parseDouble(parts[2]));
            bike.setImageUrl(parts[3]);
            bike.setAvailable(Boolean.parseBoolean(parts[4]));
            if (parts.length > 5) bike.setDescription(parts[5]);
            if (parts.length > 6) bike.setCategory(parts[6]);
            if (parts.length > 7) bike.setLastUpdated(parts[7]);
            return bike;
        }
        return null;
    }

    private static void logError(String message, Exception e) {
        System.err.println(message + ": " + e.getMessage());
        logAction("System", "ERROR: " + message);
    }
}