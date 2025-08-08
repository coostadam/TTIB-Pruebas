package examples.testBCP.helpers.Generator;

import java.util.Random;

import java.util.LinkedHashMap;
import java.util.Map;

public class CT2Message {
    static Random random = new Random();

    String debtorParticipantCode, creditorParticipantCode, creationDate, creationTime, terminalId, retrievalReferenteNumber,
            trace, channel, amount, currency, transactionReference, referenceTransactionId, transactionType,
            feeAmount, feeCode, applicationCriteria, debtorTypeOfPerson, debtorName, debtorAddressLine, debtorIdCode,
            debtorId, debtorPhoneNumber, debtorMobileNumber, debtorCCI, creditorName, creditorAddressLine,
            creditorPhoneNumber, creditorMobileNumber, creditorCCI, creditorCreditCard, sameCustomerFlag,
            purposeCode, unstructuredInformation, grossSalaryAmount, salaryPaymentIndicator,
            monthOfThePayment, yearOfThePayment, branchId, settlementDate, instructionId, interbankSettlementAmount;

    public CT2Message(AV2Message av2, AV3Message av3) {
        debtorParticipantCode = av2.debtorParticipantCode;
        creditorParticipantCode = av2.creditorParticipantCode;
        creationDate = av2.creationDate;
        creationTime = av2.creationTime;
        terminalId = av2.terminalId;
        retrievalReferenteNumber = av2.retrievalReferenteNumber;
        trace = av2.trace;
        channel = av2.channel;
        amount = String.valueOf(random.nextInt(10000));
        currency = av2.currency;
        transactionReference = randomText(10);
        referenceTransactionId = randomText(15);
        transactionType = av2.transactionType;
        feeAmount = String.valueOf(random.nextInt(100));
        feeCode = randomText(4);
        applicationCriteria = new String[]{"M", "E", "O"}[new Random().nextInt(3)];
        debtorTypeOfPerson = av2.debtorTypeOfPerson;
        debtorName = av2.debtorName;
        debtorAddressLine = av2.debtorAddressLine;
        debtorIdCode = av2.debtorIdCode;
        debtorId = av2.debtorId;
        debtorPhoneNumber = av2.debtorPhoneNumber;
        debtorMobileNumber = av2.debtorMobileNumber;
        debtorCCI = debtorCCI;
        creditorName = av3.creditorName;
        creditorAddressLine = av2.creditorAddressLine;
        creditorPhoneNumber = av2.creditorPhoneNumber;
        creditorMobileNumber = av2.creditorMobileNumber;
        creditorCCI = av2.creditorCCI;
        creditorCreditCard = av2.creditorCreditCard;
        sameCustomerFlag = av3.sameCustomerFlag;

        debtorCCI = "0987" + String.format("%016d", Math.abs(random.nextLong()) % 1000000000000L);
        purposeCode = "ERTF";
        unstructuredInformation = randomText(50);
        grossSalaryAmount = String.valueOf(1500 + random.nextInt(1000));
        String[] opcionesSalaryPayment = {"4", "5", "8", "9"};
        salaryPaymentIndicator = opcionesSalaryPayment[new Random().nextInt(opcionesSalaryPayment.length)];
        monthOfThePayment = "07";
        yearOfThePayment = "2025";
        branchId = av2.branchId;
        settlementDate = av2.creationDate;
        instructionId = av2.instructionId;
        interbankSettlementAmount = String.valueOf(Integer.parseInt(amount) + Integer.parseInt(feeAmount));
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
        map.put("channel", channel);
        map.put("amount", amount);
        map.put("currency", currency);
        map.put("transactionReference", transactionReference);
        map.put("referenceTransactionId", referenceTransactionId);
        map.put("transactionType", transactionType);
        map.put("feeAmount", feeAmount);
        map.put("feeCode", feeCode);
        map.put("applicationCriteria", applicationCriteria);
        map.put("debtorTypeOfPerson", debtorTypeOfPerson);
        map.put("debtorName", debtorName);
        map.put("debtorAddressLine", debtorAddressLine);
        map.put("debtorIdCode", debtorIdCode);
        map.put("debtorId", debtorId);
        map.put("debtorPhoneNumber", debtorPhoneNumber);
        map.put("debtorMobileNumber", debtorMobileNumber);
        map.put("debtorCCI", debtorCCI);
        map.put("creditorName", creditorName);
        map.put("creditorAddressLine", creditorAddressLine);
        map.put("creditorPhoneNumber", creditorPhoneNumber);
        map.put("creditorMobileNumber", creditorMobileNumber);
        map.put("creditorCCI", creditorCCI);
        map.put("creditorCreditCard", creditorCreditCard);
        map.put("sameCustomerFlag", sameCustomerFlag);
        map.put("purposeCode", purposeCode);
        map.put("unstructuredInformation", unstructuredInformation);
        map.put("grossSalaryAmount", grossSalaryAmount);
        map.put("salaryPaymentIndicator", salaryPaymentIndicator);
        map.put("monthOfThePayment", monthOfThePayment);
        map.put("yearOfThePayment", yearOfThePayment);
        map.put("branchId", branchId);
        map.put("settlementDate", settlementDate);
        map.put("instructionId", instructionId);
        map.put("interbankSettlementAmount", interbankSettlementAmount);
        return map;
    }

    public String toCSV() {
        return String.join(",", debtorParticipantCode, creditorParticipantCode, creationDate, creationTime,
                terminalId, retrievalReferenteNumber, trace, channel, amount, currency, transactionReference,
                referenceTransactionId, transactionType, feeAmount, feeCode, applicationCriteria, debtorTypeOfPerson,
                debtorName, debtorAddressLine, debtorIdCode, debtorId, debtorPhoneNumber, debtorMobileNumber,
                debtorCCI, creditorName, creditorAddressLine, creditorPhoneNumber, creditorMobileNumber,
                creditorCCI, creditorCreditCard, sameCustomerFlag, purposeCode, unstructuredInformation,
                grossSalaryAmount, salaryPaymentIndicator, monthOfThePayment, yearOfThePayment, branchId,
                settlementDate, instructionId, interbankSettlementAmount);
    }

    private static String randomText(int len) {
        String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < len; i++) {
            sb.append(chars.charAt(random.nextInt(chars.length())));
        }
        return sb.toString();
    }
}