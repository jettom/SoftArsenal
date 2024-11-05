import java.io.*;
import java.nio.file.*;
import java.nio.file.attribute.BasicFileAttributes;
import java.time.*;
import java.time.format.DateTimeFormatter;
import java.util.*;

public class LogFileStatistics {

    // 支持的时间和日期格式
    private static final DateTimeFormatter formatterWithMillis = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.SSS");
    private static final DateTimeFormatter formatterWithoutMillis = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
    private static final DateTimeFormatter dateFormatterDash = DateTimeFormatter.ofPattern("yyyy-MM-dd");
    private static final DateTimeFormatter dateFormatterSlash = DateTimeFormatter.ofPattern("yyyy/MM/dd");

    public static void main(String[] args) {
        // 日志文件目录
        String logDirPath = "path/to/your/log/files";  // 替换为你的日志文件路径

        try {
            File folder = new File(logDirPath);
            File[] logFiles = folder.listFiles();

            if (logFiles != null) {
                // 按最后修改日期分组的结果
                Map<LocalDate, List<LogFileInfo>> logInfoMap = new HashMap<>();

                for (File file : logFiles) {
                    if (file.isFile() && file.getName().endsWith(".log")) {
                        LogFileInfo logFileInfo = processLogFile(file);
                        if (logFileInfo != null) {
                            logInfoMap.computeIfAbsent(logFileInfo.getLastModifiedDate(), k -> new ArrayList<>()).add(logFileInfo);
                        }
                    }
                }

                // 输出结果到不同的 CSV 文件
                for (Map.Entry<LocalDate, List<LogFileInfo>> entry : logInfoMap.entrySet()) {
                    LocalDate date = entry.getKey();
                    List<LogFileInfo> infoList = entry.getValue();
                    String outputCsvFile = "log_statistics_" + date.format(DateTimeFormatter.ofPattern("yyyyMMdd")) + ".csv"; // 根据日期创建文件名

                    try (BufferedWriter writer = new BufferedWriter(new FileWriter(outputCsvFile))) {
                        // 写入CSV文件的表头
                        writer.write("Last Modified Date,File Name,Start Time,End Time,Duration (s)");
                        writer.newLine();

                        // 写入每个日志文件的信息
                        for (LogFileInfo info : infoList) {
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
                }
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
            LocalDate lastModifiedDate = parseDate(Instant.ofEpochMilli(attrs.lastModifiedTime().toMillis()).atZone(ZoneId.systemDefault()).toLocalDate().toString());

            // 使用 BufferedReader 读取文件的第一行和最后一行
            String firstLine = null;
            String lastLine = null;
            try (BufferedReader br = new BufferedReader(new FileReader(file))) {
                firstLine = br.readLine(); // 读取第一行
                String currentLine;
                while ((currentLine = br.readLine()) != null) {
                    lastLine = currentLine; // 循环读取，直到最后一行
                }
            }

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

            // 提取日期部分并进行格式判断
            String datePart = timeString.substring(0, 10); // 日期部分是前10个字符
            String timePart = timeString.substring(11);    // 时间部分是剩余的部分

            LocalDate date;
            if (datePart.contains("/")) {
                date = LocalDate.parse(datePart, dateFormatterSlash);
            } else {
                date = LocalDate.parse(datePart, dateFormatterDash);
            }

            // 解析时间部分
            if (timePart.contains(".")) {
                return LocalDateTime.of(date, LocalTime.parse(timePart, formatterWithMillis));
            } else {
                return LocalDateTime.of(date, LocalTime.parse(timePart.substring(0, 8), formatterWithoutMillis));
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    private static LocalDate parseDate(String dateString) {
        try {
            // 尝试使用 yyyy-MM-dd 格式解析
            return LocalDate.parse(dateString, dateFormatterDash);
        } catch (Exception e) {
            try {
                // 如果解析失败，尝试使用 yyyy/MM/dd 格式解析
                return LocalDate.parse(dateString, dateFormatterSlash);
            } catch (Exception ex) {
                ex.printStackTrace();
                return null;
            }
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
