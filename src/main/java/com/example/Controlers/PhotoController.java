package com.example.Controlers;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;

public class PhotoController {
    String currentPath;
    String scriptPath;
    String galerryPath;
    boolean isLinux;
    public PhotoController()
    {
        isLinux = !System.getProperty("os.name").toLowerCase().contains("windows");

        Path currentRelativePath = Paths.get("");
        String s = currentRelativePath.toAbsolutePath().toString();
        System.out.println(s);
        try {
            currentPath = new java.io.File(".").getCanonicalPath();
            System.out.println("Current dir:" + currentPath);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        if(isLinux) galerryPath = "gallery";
        else galerryPath = "C:\\gallery";
        scriptPath = "snap.sh";
    }
    public boolean takeSnapshot(String teracotaFolder,String fileName) {

        // Non-Windows: Use shell script to take the snapshot
        teracotaFolder = galerryPath+teracotaFolder;
        String outputFilePath;

        try {
            if(!isLinux) {
                outputFilePath = teracotaFolder+"\\"+fileName;
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
                File outputFile = new File(teracotaFolder, fileName);
                //outputFile.createNewFile();
                ImageIO.write(img, "jpg", outputFile); // Write the image to a file

                return outputFile.exists();// Return true if the image was created
            }
            else {
                teracotaFolder = teracotaFolder.replace("\\","/");
                outputFilePath = teracotaFolder+"/"+fileName;
                // Build the command
                ProcessBuilder processBuilder = new ProcessBuilder(
                        "bash", scriptPath, outputFilePath
                );
                processBuilder.redirectErrorStream(true); // Combine standard output and error streams

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

                // Return true if the script succeeded, false otherwise
                return exitCode == 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false; // Return false on exception
        }
    }

    public ArrayList<String> getPhotos(String terracotaFolder, int n)
    {
        ArrayList<String> fileNames = new ArrayList<>();
        String outputFilePath;
        if(isLinux)
        {
            outputFilePath = galerryPath+"/"+terracotaFolder;
            terracotaFolder = terracotaFolder.replace("\\","/");
        }
        else outputFilePath = galerryPath+"\\"+terracotaFolder;

        File folder = new File(outputFilePath);
        File[] listOfFiles = folder.listFiles();
        //System.out.println(listOfFiles.length);
        if(listOfFiles != null) {
            for (int i = listOfFiles.length; i >=0; i--) {
                if (listOfFiles[i].isFile()) fileNames.add("gallery/"+terracotaFolder+"/"+listOfFiles[i].getName());
                if(fileNames.size() >=n)break; // return only specific number of n
            }
        }
        return fileNames;
    }
    public String getActualPhoto(int terracotaFolder)
    {
        if(isLinux) return "gallery/"+terracotaFolder+"/custom/temp.jpg";
        return "gallery\\"+terracotaFolder+"\\custom\\temp.jpg";
    }
    public boolean createPhotoDir(String terracotaFolder)
    {
        File theDir;
        if (isLinux) theDir = new File(galerryPath+"/"+terracotaFolder);
        else theDir = new File(galerryPath+"\\"+terracotaFolder);
        if (!theDir.exists()){
            theDir.mkdirs();
        }
        if(isLinux) theDir = new File(galerryPath+"/"+terracotaFolder+"/custom");
        else theDir = new File(galerryPath+"\\"+terracotaFolder+"\\custom");
        if (!theDir.exists()){
            theDir.mkdirs();
        }
        return true;
    }
    public boolean deletetePhotoDir(String terracotaFolder)
    {
        File theDir;
        if(isLinux) theDir = new File(galerryPath+"/"+terracotaFolder);
        else theDir = new File(galerryPath+"\\"+terracotaFolder);
        if (!theDir.exists()){
            theDir.delete();
        }
        return true;
    }
}