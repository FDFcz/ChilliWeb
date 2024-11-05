package com.example.Controlers;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.BufferedReader;
import java.io.File;
import java.io.InputStreamReader;
import java.util.ArrayList;

public class PhotoController {

    public boolean takeSnapshot(String outPutPath) {
        try {
            if(System.getProperty("os.name").toLowerCase().contains("windows")) {
                // Create a simple placeholder image
                int width = 100; // Width of the image
                int height = 100; // Height of the image

                BufferedImage img = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
                Graphics2D g2d = img.createGraphics();
                g2d.setColor(Color.BLUE); // Set color to blue
                g2d.fillRect(0, 0, width, height); // Fill the rectangle
                g2d.setColor(Color.WHITE);
                g2d.drawString("Test", 10, 50); // Draw some text
                g2d.dispose();

                // Save the image
                File outputFile = new File(outPutPath, "test.jpg");
                ImageIO.write(img, "jpg", outputFile); // Write the image to a file

                return outputFile.exists();// Return true if the image was created
            }
            else {
                // Path to your CMD file
                String scriptPath = "C:\\projects\\java\\ChilliWeb\\src\\main\\RusberriPI\\test.cmd";

                // Build the command
                ProcessBuilder processBuilder = new ProcessBuilder(
                        "cmd", "/c", scriptPath, outPutPath
                );
                processBuilder.redirectErrorStream(true); // Redirect error stream to output

                // Start the process
                Process process = processBuilder.start();

                // Capture and print the output
                BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()));
                String line;
                while ((line = reader.readLine()) != null) {
                    System.out.println(line);
                }

                // Wait for the process to complete and get the exit code
                int exitCode = process.waitFor();
                System.out.println("Exit Code: " + exitCode);

                // Check if the exit code indicates success
                if (exitCode == 0) {
                    // Check if the test.txt file was created successfully
                    File outputFile = new File(outPutPath, "test.txt");
                    return outputFile.exists(); // Return true if the file exists
                } else {
                    return false; // Return false if there was an error executing the script
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            return false; // Return false on exception
        }
    }

    public ArrayList<String> getphotos(String path, int n)
    {
        return new ArrayList<String>();
    }
}
