package examples.testBCP.helpers.Generator;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class CT5Message {
    String debtorParticipantCode;
    String creditorParticipantCode;
    String responseDate;
    String responseTime;
    String terminalId;
    String retrievalReferenteNumber;
    String trace;
    String amount;
    String currency;
    String transactionReference;
    String responseCode;
    String feeAmount;
    String settlementDate;
    String transactionType;
    String debtorCCI;
    String creditorCCI;
    String creditorCreditCard;
    String sameCustomerFlag;
    String instructionId;
    String creationDate;
    String creationTime;
    String channel;
    String interbankSettlementAmount;

    public CT5Message(AV2Message av2, AV3Message av3, CT2Message ct2, CT3Message ct3) {
        debtorParticipantCode = av2.debtorParticipantCode;
        creditorParticipantCode = av2.creditorParticipantCode;
        responseDate = nowDate();
        responseTime = nowTime();
        terminalId = av2.terminalId;
        retrievalReferenteNumber = av2.retrievalReferenteNumber;
        trace = av2.trace;
        amount = ct2.amount;
        currency = av2.currency;
        transactionReference = ct2.transactionReference;
        responseCode = av3.responseCode;
        feeAmount = ct2.feeAmount;
        settlementDate = ct3.settlementDate;
        transactionType = av2.transactionType;
        debtorCCI = ct2.debtorCCI;
        creditorCCI = av2.creditorCCI;
        creditorCreditCard = av2.creditorCreditCard;
        sameCustomerFlag = av3.sameCustomerFlag;
        instructionId = av2.instructionId;
        creationDate = av2.creationDate;
        creationTime = av2.creationTime;
        channel = av2.channel;
        interbankSettlementAmount = ct2.interbankSettlementAmount;
    }

    public String toCSV() {
        return String.join(",",
                debtorParticipantCode, creditorParticipantCode, responseDate, responseTime,
                terminalId, retrievalReferenteNumber, trace, amount, currency, transactionReference,
                responseCode, feeAmount, settlementDate, transactionType, debtorCCI, creditorCCI,
                creditorCreditCard, sameCustomerFlag, instructionId, creationDate, creationTime,
                channel, interbankSettlementAmount);
    }

    public static String returnCSVHeaders() {
        return "debtorParticipantCode,creditorParticipantCode,responseDate,responseTime,terminalId,retrievalReferenteNumber," +
                "trace,amount,currency,transactionReference,responseCode,feeAmount,settlementDate," +
                "transactionType,debtorCCI,creditorCCI,creditorCreditCard,sameCustomerFlag,instructionId," +
                "creationDate,creationTime,channel,interbankSettlementAmount";
    }

    private static String nowDate() {
        return LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"));
    }

    private static String nowTime() {
        return LocalDateTime.now().format(DateTimeFormatter.ofPattern("HHmmss"));
    }
}