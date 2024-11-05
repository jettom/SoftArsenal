import java.io.*;
import java.nio.file.*;
import java.nio.file.attribute.BasicFileAttributes;
import java.time.*;
import java.time.format.DateTimeFormatter;
import java.util.*;

public class LogFileStatistics {

    private static final DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    public static void main(String[] args) {
        // 日志文件目录
        String logDirPath = "path/to/your/log/files";  // 替换为你的日志文件路径

        List<LogFileInfo> logFileInfoList = new ArrayList<>();

        try {
            File folder = new File(logDirPath);
            File[] logFiles = folder.listFiles();

            if (logFiles != null) {
                for (File file : logFiles) {
                    if (file.isFile() && file.getName().endsWith(".log")) {
                        LogFileInfo logFileInfo = processLogFile(file);
                        if (logFileInfo != null) {
                            logFileInfoList.add(logFileInfo);
                        }
                    }
                }
            }

            // 按文件创建日期排序
            logFileInfoList.sort(Comparator.comparing(LogFileInfo::getCreationDate));

            // 输出结果
            System.out.printf("%-15s %-30s %-20s %-20s %-10s%n", "Creation Date", "File Name", "Start Time", "End Time", "Duration (s)");
            for (LogFileInfo info : logFileInfoList) {
                System.out.printf("%-15s %-30s %-20s %-20s %-10d%n",
                        info.getCreationDate(),
                        info.getFileName(),
                        info.getStartTime().format(formatter),
                        info.getEndTime().format(formatter),
                        info.getDuration());
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private static LogFileInfo processLogFile(File file) {
        try {
            // 获取文件创建日期
            Path filePath = file.toPath();
            BasicFileAttributes attrs = Files.readAttributes(filePath, BasicFileAttributes.class);
            LocalDate creationDate = Instant.ofEpochMilli(attrs.creationTime().toMillis()).atZone(ZoneId.systemDefault()).toLocalDate();

            BufferedReader br = new BufferedReader(new FileReader(file));
            String firstLine = br.readLine();
            String lastLine = null;
            String currentLine;

            // 读取最后一行
            while ((currentLine = br.readLine()) != null) {
                lastLine = currentLine;
            }

            br.close();

            if (firstLine != null && lastLine != null) {
                LocalDateTime startTime = parseTimeFromLog(firstLine);
                LocalDateTime endTime = parseTimeFromLog(lastLine);

                if (startTime != null && endTime != null) {
                    long duration = Duration.between(startTime, endTime).getSeconds();
                    return new LogFileInfo(creationDate, file.getName(), startTime, endTime, duration);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        return null;
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

class LogFileInfo {
    private final LocalDate creationDate;
    private final String fileName;
    private final LocalDateTime startTime;
    private final LocalDateTime endTime;
    private final long duration;

    public LogFileInfo(LocalDate creationDate, String fileName, LocalDateTime startTime, LocalDateTime endTime, long duration) {
        this.creationDate = creationDate;
        this.fileName = fileName;
        this.startTime = startTime;
        this.endTime = endTime;
        this.duration = duration;
    }

    public LocalDate getCreationDate() {
        return creationDate;
    }

    public String getFileName() {
        return fileName;
    }

    public LocalDateTime getStartTime() {
        return startTime;
    }

    public LocalDateTime getEndTime() {
        return endTime;
    }

    public long getDuration() {
        return duration;
    }
}
