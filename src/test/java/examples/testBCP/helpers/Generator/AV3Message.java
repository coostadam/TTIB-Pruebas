package examples.testBCP.helpers.Generator;

import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Random;

public class AV3Message {
    static Random random = new Random();

    String debtorParticipantCode;
    String creditorParticipantCode;
    String creationDate;
    String creationTime;
    String terminalId;
    String retrievalReferenteNumber;
    String trace;
    String branchId;
    String debtorName;
    String debtorId;
    String debtorIdCode;
    String debtorPhoneNumber;
    String debtorAddressLine;
    String debtorMobileNumber;
    String transactionType;
    String channel;
    String instructionId;
    String currency;
    String proxyValue;
    String proxyType;

    String responseCode;
    String reasonCode;
    String creditorName;
    String creditorAddressLine;
    String creditorId;
    String creditorIdCode;
    String creditorPhoneNumber;
    String creditorMobileNumber;
    String creditorCCI;
    String creditorCreditCard;
    String sameCustomerFlag;

    public AV3Message(AV2Message av2) {
        debtorParticipantCode = av2.debtorParticipantCode;
        creditorParticipantCode = av2.creditorParticipantCode;
        creationDate = av2.creationDate;
        creationTime = av2.creationTime;
        terminalId = av2.terminalId;
        retrievalReferenteNumber = av2.retrievalReferenteNumber;
        trace = av2.trace;
        branchId = av2.branchId;
        debtorName = av2.debtorName;
        debtorId = av2.debtorId;
        debtorIdCode = av2.debtorIdCode;
        debtorPhoneNumber = av2.debtorPhoneNumber;
        debtorAddressLine = av2.debtorAddressLine;
        debtorMobileNumber = av2.debtorMobileNumber;
        transactionType = av2.transactionType;
        creditorAddressLine = av2.creditorAddressLine;
        channel = av2.channel;
        instructionId = av2.instructionId;
        currency = av2.currency;
        proxyValue = av2.proxyValue;
        proxyType = av2.proxyType;

        responseCode = random.nextBoolean() ? "00" : "05";
        reasonCode = randomReasonCode();
        creditorName = randomName();
        creditorId = String.valueOf(10000000 + random.nextInt(89999999));
        creditorIdCode = String.valueOf(1 + random.nextInt(6));
        creditorPhoneNumber = String.valueOf(3000000 + random.nextInt(999999));
        creditorMobileNumber = String.valueOf(900000000 + random.nextInt(99999999));
        creditorCCI = av2.creditorCCI;
        creditorCreditCard = av2.creditorCreditCard;
        sameCustomerFlag = (random.nextBoolean() ? "M" : "O");
    }

    public Map<String, Object> toMap() {
        Map<String, Object> map = new LinkedHashMap<>();
        map.put("debtorParticipantCode", debtorParticipantCode);
        map.put("creditorParticipantCode", creditorParticipantCode);
        map.put("creationDate", creationDate);
        map.put("creationTime", creationTime);
        map.put("terminalId", terminalId);
        map.put("retrievalReferenteNumber", retrievalReferenteNumber);
        map.put("trace", trace);
        map.put("branchId", branchId);
        map.put("debtorName", debtorName);
        map.put("debtorId", debtorId);
        map.put("debtorIdCode", debtorIdCode);
        map.put("debtorPhoneNumber", debtorPhoneNumber);
        map.put("debtorAddressLine", debtorAddressLine);
        map.put("debtorMobileNumber", debtorMobileNumber);
        map.put("transactionType", transactionType);
        map.put("creditorAddressLine", creditorAddressLine);
        map.put("channel", channel);
        map.put("instructionId", instructionId);
        map.put("currency", currency);
        map.put("proxyValue", proxyValue);
        map.put("proxyType", proxyType);

        map.put("responseCode", responseCode);
        map.put("reasonCode", reasonCode);
        map.put("creditorName", creditorName);
        map.put("creditorId", creditorId);
        map.put("creditorIdCode", creditorIdCode);
        map.put("creditorPhoneNumber", creditorPhoneNumber);
        map.put("creditorMobileNumber", creditorMobileNumber);
        map.put("creditorCCI", creditorCCI);
        map.put("creditorCreditCard", creditorCreditCard);
        map.put("sameCustomerFlag", sameCustomerFlag);

        return map;
    }

    public String toCSV() {
        return String.join(",", debtorParticipantCode, creditorParticipantCode, creationDate, creationTime, terminalId,
                retrievalReferenteNumber, trace, branchId, debtorName, debtorId, debtorIdCode, debtorPhoneNumber,
                debtorAddressLine, debtorMobileNumber, transactionType, channel, instructionId, responseCode,
                reasonCode, creditorName, creditorAddressLine, creditorId, creditorIdCode, creditorPhoneNumber,
                creditorMobileNumber, creditorCCI, creditorCreditCard, sameCustomerFlag, currency, proxyValue, proxyType);
    }

    private static String randomName() {
        String[] names = {"Pedro Gamero", "Lucía Fernández", "Carlos Ramos", "Elena Paredes", "Jorge Villanueva"};
        return names[random.nextInt(names.length)];
    }

    private static String randomReasonCode() {
        String[] reasons = {"AC11", "BE02", "CC03", "DD04"};
        return reasons[random.nextInt(reasons.length)];
    }
}