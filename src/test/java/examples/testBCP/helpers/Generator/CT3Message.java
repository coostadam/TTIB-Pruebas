package examples.testBCP.helpers.Generator;

import java.util.Map;

public class CT3Message {
    String debtorParticipantCode, creditorParticipantCode, responseDate, responseTime, terminalId, retrievalReferenteNumber,
            trace, amount, currency, transactionReference, responseCode, reasonCode, feeAmount, settlementDate,
            transactionType, debtorCCI, creditorCCI, creditorCreditCard, sameCustomerFlag, branchId, instructionId;

    public CT3Message(
            String debtorParticipantCode,
            String creditorParticipantCode,
            String responseDate,
            String responseTime,
            String terminalId,
            String retrievalReferenteNumber,
            String trace,
            String amount,
            String currency,
            String transactionReference,
            String responseCode,
            String reasonCode,
            String feeAmount,
            String settlementDate,
            String transactionType,
            String debtorCCI,
            String creditorCCI,
            String creditorCreditCard,
            String sameCustomerFlag,
            String branchId,
            String instructionId
    ) {
        this.debtorParticipantCode = debtorParticipantCode;
        this.creditorParticipantCode = creditorParticipantCode;
        this.responseDate = responseDate;
        this.responseTime = responseTime;
        this.terminalId = terminalId;
        this.retrievalReferenteNumber = retrievalReferenteNumber;
        this.trace = trace;
        this.amount = amount;
        this.currency = currency;
        this.transactionReference = transactionReference;
        this.responseCode = responseCode;
        this.reasonCode = reasonCode;
        this.feeAmount = feeAmount;
        this.settlementDate = settlementDate;
        this.transactionType = transactionType;
        this.debtorCCI = debtorCCI;
        this.creditorCCI = creditorCCI;
        this.creditorCreditCard = creditorCreditCard;
        this.sameCustomerFlag = sameCustomerFlag;
        this.branchId = branchId;
        this.instructionId = instructionId;
    }

    public static CT3Message fromMap(Map<String, Object> map) {
        return new CT3Message(
                String.valueOf(map.get("debtorParticipantCode")),
                String.valueOf(map.get("creditorParticipantCode")),
                String.valueOf(map.get("responseDate")),
                String.valueOf(map.get("responseTime")),
                String.valueOf(map.get("terminalId")),
                String.valueOf(map.get("retrievalReferenteNumber")),
                String.valueOf(map.get("trace")),
                String.valueOf(map.get("amount")),
                String.valueOf(map.get("currency")),
                String.valueOf(map.get("transactionReference")),
                String.valueOf(map.get("responseCode")),
                String.valueOf(map.get("reasonCode")),
                String.valueOf(map.get("feeAmount")),
                String.valueOf(map.get("settlementDate")),
                String.valueOf(map.get("transactionType")),
                String.valueOf(map.get("debtorCCI")),
                String.valueOf(map.get("creditorCCI")),
                String.valueOf(map.get("creditorCreditCard")),
                String.valueOf(map.get("sameCustomerFlag")),
                String.valueOf(map.get("branchId")),
                String.valueOf(map.get("instructionId"))
        );
    }

    public String toCSV() {
        return String.join(",", debtorParticipantCode, creditorParticipantCode, responseDate, responseTime,
                terminalId, retrievalReferenteNumber, trace, amount, currency, transactionReference, responseCode,
                reasonCode, feeAmount, settlementDate, transactionType, debtorCCI, creditorCCI, creditorCreditCard,
                sameCustomerFlag, branchId, instructionId);
    }

    public static String returnCSVHeaders() {
        return "debtorParticipantCode,creditorParticipantCode,responseDate,responseTime,terminalId,retrievalReferenteNumber," +
                "trace,amount,currency,transactionReference,responseCode,reasonCode,feeAmount,settlementDate," +
                "transactionType,debtorCCI,creditorCCI,creditorCreditCard,sameCustomerFlag,branchId,instructionId";
    }
}
