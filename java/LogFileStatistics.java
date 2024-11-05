import java.io.*;
import java.nio.file.*;
import java.nio.file.attribute.BasicFileAttributes;
import java.time.*;
import java.time.format.DateTimeFormatter;
import java.util.*;

public class LogFileStatistics {

    // 支持的时间格式
    private static final DateTimeFormatter formatterWithMillis = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.SSS");
    private static final DateTimeFormatter formatterWithoutMillis = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    public static void main(String[] args) {
        // 日志文件目录
        String logDirPath = "path/to/your/log/files";  // 替换为你的日志文件路径
        String outputCsvFile = "log_statistics.csv";   // 输出CSV文件名

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

            // 按文件更新日期排序
            logFileInfoList.sort(Comparator.comparing(LogFileInfo::getLastModifiedDate));

            // 输出结果到CSV文件
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(outputCsvFile))) {
                // 写入CSV文件的表头
                writer.write("Last Modified Date,File Name,Start Time,End Time,Duration (s)");
                writer.newLine();

                // 写入每个日志文件的信息
                for (LogFileInfo info : logFileInfoList) {
                    String line = String.format("%s,%s,%s,%s,%d",
                            info.getLastModifiedDate(),
                            info.getFileName(),
                            info.getStartTime().format(formatterWithMillis),
                            info.getEndTime().format(formatterWithMillis),
                            info.getDuration());
                    writer.write(line);
                    writer.newLine();
                }

                System.out.println("结果已成功写入到 " + outputCsvFile);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private static LogFileInfo processLogFile(File file) {
        try {
            // 获取文件更新日期
            Path filePath = file.toPath();
            BasicFileAttributes attrs = Files.readAttributes(filePath, BasicFileAttributes.class);
            LocalDate lastModifiedDate = Instant.ofEpochMilli(attrs.lastModifiedTime().toMillis()).atZone(ZoneId.systemDefault()).toLocalDate();

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
                    long duration = Duration.between(startTime, endTime).toMillis() / 1000;
                    return new LogFileInfo(lastModifiedDate, file.getName(), startTime, endTime, duration);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        return null;
    }

    private static LocalDateTime parseTimeFromLog(String logLine) {
        try {
            // 假设时间在每行的前19或23个字符内
            String timeString = logLine.substring(0, Math.min(23, logLine.length()));

            // 使用 '.' 判断格式
            if (timeString.contains(".")) {
                return LocalDateTime.parse(timeString, formatterWithMillis);
            } else {
                return LocalDateTime.parse(timeString.substring(0, 19), formatterWithoutMillis);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}

class LogFileInfo {
    private final LocalDate lastModifiedDate;
    private final String fileName;
    private final LocalDateTime startTime;
    private final LocalDateTime endTime;
    private final long duration;

    public LogFileInfo(LocalDate lastModifiedDate, String fileName, LocalDateTime startTime, LocalDateTime endTime, long duration) {
        this.lastModifiedDate = lastModifiedDate;
        this.fileName = fileName;
        this.startTime = startTime;
        this.endTime = endTime;
        this.duration = duration;
    }

    public LocalDate getLastModifiedDate() {
        return lastModifiedDate;
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
