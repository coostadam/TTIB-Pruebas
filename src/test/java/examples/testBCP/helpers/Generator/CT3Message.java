package examples.testBCP.helpers.Generator;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.LinkedHashMap;
import java.util.Map;

public class CT3Message {
    String debtorParticipantCode, creditorParticipantCode, responseDate, responseTime, terminalId, retrievalReferenteNumber,
            trace, amount, currency, transactionReference, responseCode, reasonCode, feeAmount, settlementDate,
            transactionType, debtorCCI, creditorCCI, creditorCreditCard, sameCustomerFlag, branchId, instructionId;

    public CT3Message(AV2Message av2, AV3Message av3, CT2Message ct2) {
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
        reasonCode = av3.reasonCode;
        feeAmount = ct2.feeAmount;
        settlementDate = ct2.settlementDate;
        transactionType = av2.transactionType;
        debtorCCI = ct2.debtorCCI;
        creditorCCI = av2.creditorCCI;
        creditorCreditCard = av2.creditorCreditCard;
        sameCustomerFlag = av3.sameCustomerFlag;
        branchId = av2.branchId;
        instructionId = av2.instructionId;
    }

    public Map<String, Object> toMap() {
        Map<String, Object> map = new LinkedHashMap<>();
        map.put("debtorParticipantCode", debtorParticipantCode);
        map.put("creditorParticipantCode", creditorParticipantCode);
        map.put("responseDate", responseDate);
        map.put("responseTime", responseTime);
        map.put("terminalId", terminalId);
        map.put("retrievalReferenteNumber", retrievalReferenteNumber);
        map.put("trace", trace);
        map.put("amount", amount);
        map.put("currency", currency);
        map.put("transactionReference", transactionReference);
        map.put("responseCode", responseCode);
        map.put("reasonCode", reasonCode);
        map.put("feeAmount", feeAmount);
        map.put("settlementDate", settlementDate);
        map.put("transactionType", transactionType);
        map.put("debtorCCI", debtorCCI);
        map.put("creditorCCI", creditorCCI);
        map.put("creditorCreditCard", creditorCreditCard);
        map.put("sameCustomerFlag", sameCustomerFlag);
        map.put("branchId", branchId);
        map.put("instructionId", instructionId);
        return map;
    }

    public String toCSV() {
        return String.join(",", debtorParticipantCode, creditorParticipantCode, responseDate, responseTime,
                terminalId, retrievalReferenteNumber, trace, amount, currency, transactionReference, responseCode,
                reasonCode, feeAmount, settlementDate, transactionType, debtorCCI, creditorCCI, creditorCreditCard,
                sameCustomerFlag, branchId, instructionId);
    }

    private static String nowDate() {
        return LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"));
    }

    private static String nowTime() {
        return LocalDateTime.now().format(DateTimeFormatter.ofPattern("HHmmss"));
    }
}