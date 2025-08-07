package examples.testBCP.helpers.Generator;

import java.util.Map;

public class AV3Message {
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

    public AV3Message(
            String debtorParticipantCode,
            String creditorParticipantCode,
            String creationDate,
            String creationTime,
            String terminalId,
            String retrievalReferenteNumber,
            String trace,
            String branchId,
            String debtorName,
            String debtorId,
            String debtorIdCode,
            String debtorPhoneNumber,
            String debtorAddressLine,
            String debtorMobileNumber,
            String transactionType,
            String channel,
            String instructionId,
            String responseCode,
            String reasonCode,
            String creditorName,
            String creditorAddressLine,
            String creditorId,
            String creditorIdCode,
            String creditorPhoneNumber,
            String creditorMobileNumber,
            String creditorCCI,
            String creditorCreditCard,
            String sameCustomerFlag,
            String currency,
            String proxyValue,
            String proxyType
    ) {
        this.debtorParticipantCode = debtorParticipantCode;
        this.creditorParticipantCode = creditorParticipantCode;
        this.creationDate = creationDate;
        this.creationTime = creationTime;
        this.terminalId = terminalId;
        this.retrievalReferenteNumber = retrievalReferenteNumber;
        this.trace = trace;
        this.branchId = branchId;
        this.debtorName = debtorName;
        this.debtorId = debtorId;
        this.debtorIdCode = debtorIdCode;
        this.debtorPhoneNumber = debtorPhoneNumber;
        this.debtorAddressLine = debtorAddressLine;
        this.debtorMobileNumber = debtorMobileNumber;
        this.transactionType = transactionType;
        this.channel = channel;
        this.instructionId = instructionId;
        this.responseCode = responseCode;
        this.reasonCode = reasonCode;
        this.creditorName = creditorName;
        this.creditorAddressLine = creditorAddressLine;
        this.creditorId = creditorId;
        this.creditorIdCode = creditorIdCode;
        this.creditorPhoneNumber = creditorPhoneNumber;
        this.creditorMobileNumber = creditorMobileNumber;
        this.creditorCCI = creditorCCI;
        this.creditorCreditCard = creditorCreditCard;
        this.sameCustomerFlag = sameCustomerFlag;
        this.currency = currency;
        this.proxyValue = proxyValue;
        this.proxyType = proxyType;
    }


    public static AV3Message fromMap(Map<String, Object> map) {
        return new AV3Message(
                String.valueOf(map.get("debtorParticipantCode")),
                String.valueOf(map.get("creditorParticipantCode")),
                String.valueOf(map.get("creationDate")),
                String.valueOf(map.get("creationTime")),
                String.valueOf(map.get("terminalId")),
                String.valueOf(map.get("retrievalReferenteNumber")),
                String.valueOf(map.get("trace")),
                String.valueOf(map.get("branchId")),
                String.valueOf(map.get("debtorName")),
                String.valueOf(map.get("debtorId")),
                String.valueOf(map.get("debtorIdCode")),
                String.valueOf(map.get("debtorPhoneNumber")),
                String.valueOf(map.get("debtorAddressLine")),
                String.valueOf(map.get("debtorMobileNumber")),
                String.valueOf(map.get("transactionType")),
                String.valueOf(map.get("channel")),
                String.valueOf(map.get("instructionId")),
                String.valueOf(map.get("responseCode")),
                String.valueOf(map.get("reasonCode")),
                String.valueOf(map.get("creditorName")),
                String.valueOf(map.get("creditorAddressLine")),
                String.valueOf(map.get("creditorId")),
                String.valueOf(map.get("creditorIdCode")),
                String.valueOf(map.get("creditorPhoneNumber")),
                String.valueOf(map.get("creditorMobileNumber")),
                String.valueOf(map.get("creditorCCI")),
                String.valueOf(map.get("creditorCreditCard")),
                String.valueOf(map.get("sameCustomerFlag")),
                String.valueOf(map.get("currency")),
                String.valueOf(map.get("proxyValue")),
                String.valueOf(map.get("proxyType"))
        );
    }

    public String toCSV() {
        return String.join(",", debtorParticipantCode, creditorParticipantCode, creationDate, creationTime, terminalId,
                retrievalReferenteNumber, trace, branchId, debtorName, debtorId, debtorIdCode, debtorPhoneNumber,
                debtorAddressLine, debtorMobileNumber, transactionType, channel, instructionId, responseCode,
                reasonCode, creditorName, creditorAddressLine, creditorId, creditorIdCode, creditorPhoneNumber,
                creditorMobileNumber, creditorCCI, creditorCreditCard, sameCustomerFlag, currency, proxyValue, proxyType);
    }

    public static String returnCSVHeaders() {
        return "debtorParticipantCode,creditorParticipantCode,creationDate,creationTime,terminalId,retrievalReferenteNumber," +
                "trace,branchId,debtorName,debtorId,debtorIdCode,debtorPhoneNumber,debtorAddressLine,debtorMobileNumber," +
                "transactionType,channel,instructionId,responseCode,reasonCode,creditorName,creditorAddressLine," +
                "creditorId,creditorIdCode,creditorPhoneNumber,creditorMobileNumber,creditorCCI,creditorCreditCard," +
                "sameCustomerFlag,currency,proxyValue,proxyType";
    }
}
