package examples.testBCP.helpers.Generador;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Map;
import java.util.Random;

public class AV2Message {
    static Random random = new Random();

    String debtorParticipantCode;
    String creditorParticipantCode;
    String creationDate;
    String creationTime;
    String terminalId;
    String retrievalReferenteNumber;
    String trace;
    String debtorName;
    String debtorId;
    String debtorIdCode;
    String debtorPhoneNumber;
    String debtorAddressLine;
    String debtorMobileNumber;
    String transactionType;
    String channel;
    String creditorAddressLine;
    String creditorPhoneNumber;
    String creditorMobileNumber;
    String creditorCCI;
    String creditorCreditCard;
    String debtorTypeOfPerson;
    String currency;
    String proxyValue;
    String proxyType;
    String instructionId;
    String branchId;

    public AV2Message(
            String debtorParticipantCode,
            String creditorParticipantCode,
            String creationDate,
            String creationTime,
            String terminalId,
            String retrievalReferenteNumber,
            String trace,
            String debtorName,
            String debtorId,
            String debtorIdCode,
            String debtorPhoneNumber,
            String debtorAddressLine,
            String debtorMobileNumber,
            String transactionType,
            String channel,
            String creditorAddressLine,
            String creditorPhoneNumber,
            String creditorMobileNumber,
            String creditorCCI,
            String creditorCreditCard,
            String debtorTypeOfPerson,
            String currency,
            String proxyValue,
            String proxyType,
            String instructionId,
            String branchId
    ) {
        this.debtorParticipantCode = debtorParticipantCode;
        this.creditorParticipantCode = creditorParticipantCode;
        this.creationDate = creationDate;
        this.creationTime = creationTime;
        this.terminalId = terminalId;
        this.retrievalReferenteNumber = retrievalReferenteNumber;
        this.trace = trace;
        this.debtorName = debtorName;
        this.debtorId = debtorId;
        this.debtorIdCode = debtorIdCode;
        this.debtorPhoneNumber = debtorPhoneNumber;
        this.debtorAddressLine = debtorAddressLine;
        this.debtorMobileNumber = debtorMobileNumber;
        this.transactionType = transactionType;
        this.channel = channel;
        this.creditorAddressLine = creditorAddressLine;
        this.creditorPhoneNumber = creditorPhoneNumber;
        this.creditorMobileNumber = creditorMobileNumber;
        this.creditorCCI = creditorCCI;
        this.creditorCreditCard = creditorCreditCard;
        this.debtorTypeOfPerson = debtorTypeOfPerson;
        this.currency = currency;
        this.proxyValue = proxyValue;
        this.proxyType = proxyType;
        this.instructionId = instructionId;
        this.branchId = branchId;
    }


    public String toCSV() {
        return String.join(",", debtorParticipantCode, creditorParticipantCode, creationDate, creationTime, terminalId,
                retrievalReferenteNumber, trace, debtorName, debtorId, debtorIdCode, debtorPhoneNumber, debtorAddressLine,
                debtorMobileNumber, transactionType, channel, creditorAddressLine, creditorPhoneNumber,
                creditorMobileNumber, creditorCCI, creditorCreditCard, debtorTypeOfPerson, currency, proxyValue,
                proxyType, instructionId, branchId);
    }

    public static String returnCSVHeaders() {
        return "debtorParticipantCode,creditorParticipantCode,creationDate,creationTime,terminalId,retrievalReferenteNumber," +
                "trace,debtorName,debtorId,debtorIdCode,debtorPhoneNumber,debtorAddressLine,debtorMobileNumber," +
                "transactionType,channel,creditorAddressLine,creditorPhoneNumber,creditorMobileNumber," +
                "creditorCCI,creditorCreditCard,debtorTypeOfPerson,currency,proxyValue,proxyType,instructionId," +
                "branchId";
    }

    public static AV2Message fromMap(Map<String, Object> map) {
        return new AV2Message(
                String.valueOf(map.get("debtorParticipantCode")),
                String.valueOf(map.get("creditorParticipantCode")),
                LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMdd")),
                LocalDateTime.now().format(DateTimeFormatter.ofPattern("HHmmss")),
                String.valueOf(map.get("terminalId")),
                String.valueOf(map.get("retrievalReferenteNumber")),
                String.valueOf(map.get("trace")),
                String.valueOf(map.get("debtorName")),
                String.valueOf(map.get("debtorId")),
                String.valueOf(map.get("debtorIdCode")),
                String.valueOf(map.get("debtorPhoneNumber")),
                String.valueOf(map.get("debtorAddressLine")),
                String.valueOf(map.get("debtorMobileNumber")),
                String.valueOf(map.get("transactionType")),
                String.valueOf(map.get("channel")),
                String.valueOf(map.get("creditorAddressLine")),
                String.valueOf(map.get("creditorPhoneNumber")),
                String.valueOf(map.get("creditorMobileNumber")),
                String.valueOf(map.get("creditorCCI")),
                String.valueOf(map.get("creditorCreditCard")),
                String.valueOf(map.get("debtorTypeOfPerson")),
                String.valueOf(map.get("currency")),
                randomText(10 + GeneradorDeCSV.random.nextInt(2000)),
                randomProxyType(),
                "M" + LocalDateTime.now().format(DateTimeFormatter.ofPattern("MMddHHmmss")) +
                        String.format("%010d", GeneradorDeCSV.random.nextLong(1_000_000_0000L)),
                String.valueOf(map.get("branchId"))
        );
    }

    private static String randomText(int len) {
        String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < len; i++) {
            sb.append(chars.charAt(random.nextInt(chars.length())));
        }
        return sb.toString();
    }

    private static String randomProxyType() {
        String[] proxyTypes = {"MSISDN", "EMAIL", "DNI", "RUC", "CARD"};
        return proxyTypes[random.nextInt(proxyTypes.length)];
    }
}