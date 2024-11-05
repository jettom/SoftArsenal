import java.io.*;
import java.nio.file.*;
import java.time.*;
import java.time.format.DateTimeFormatter;
import java.util.*;

public class LogFileStatistics {

    private static final DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    public static void main(String[] args) {
        // 日志文件目录
        String logDirPath = "path/to/your/log/files";

        try {
            File folder = new File(logDirPath);
            File[] logFiles = folder.listFiles();
            Map<LocalDate, Long> dailyExecutionTime = new HashMap<>();

            if (logFiles != null) {
                for (File file : logFiles) {
                    if (file.isFile() && file.getName().endsWith(".log")) {
                        processLogFile(file, dailyExecutionTime);
                    }
                }
            }

            // 汇总每一天的总执行时间
            for (Map.Entry<LocalDate, Long> entry : dailyExecutionTime.entrySet()) {
                System.out.println("Date: " + entry.getKey() + ", Total Execution Time (seconds): " + entry.getValue());
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private static void processLogFile(File file, Map<LocalDate, Long> dailyExecutionTime) {
        try (BufferedReader br = new BufferedReader(new FileReader(file))) {
            String firstLine = br.readLine();
            String lastLine = null;
            String currentLine;

            // 读取最后一行
            while ((currentLine = br.readLine()) != null) {
                lastLine = currentLine;
            }

            if (firstLine != null && lastLine != null) {
                LocalDateTime startTime = parseTimeFromLog(firstLine);
                LocalDateTime endTime = parseTimeFromLog(lastLine);

                if (startTime != null && endTime != null) {
                    long duration = Duration.between(startTime, endTime).getSeconds();
                    LocalDate date = startTime.toLocalDate();
                    dailyExecutionTime.merge(date, duration, Long::sum);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private static LocalDateTime parseTimeFromLog(String logLine) {
        // 假设日志行格式为 "yyyy-MM-dd HH:mm:ss - some log message"
        String timeString = logLine.split(" - ")[0];
        try {
            return LocalDateTime.parse(timeString, formatter);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
