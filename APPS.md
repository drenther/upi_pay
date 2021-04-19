# UPI Applications Status

## Summary

Verification period: 01/Apr/21 - 19/Apr/21 

### Working Android Applications

Name | Version | "Unverified Source" warning
-|-|-
BHIM CUB eWallet | 1.6.1 | Yes
BHIM DCB UPI | 2.1.16 | Yes
BHIM YesPay | 4.17
Cointab | 1.3.37
Freecharge | 9.11.1
iMobile | 12.6
MahaUpi | 1.7.0
Mobikwik | 22.5.2
OmegaPay | 1.2.28
Yuva Pay | 2.3.2

### Working iOS Applications

Name | Version | "Unverified Source" warning
-|-|-
BHIM AUPay | 1.1 | Yes
Cointab | 1.1.29
Freecharge | 4.8.2
Mobikwik | 23.0
Paytm | 9.4.0
WhatsApp | 2.21.71

## Codes

### UPI Setup Statuses

1. Works
2. Reserved
3. Bank account holders only
4. Error post UPI setup
5. UPI setup fails
6. UPI disabled
7. Under maintenance
8. Device verification fails
9. Device verification SMS fails
10. Unstable

### UPI Linking Implementation Status

1. Works
2. Implemented; but not getting discovered
3. Absent

### Transaction Functioning Status

1. Works
2. UPI ref not returned
3. Does not return to caller
4. Risk Threshold Exceeded Error
5. Daily Transaction Limit Exceeded Error
6. Security Error
7. Payment fails
8. Payment form is incomplete
9. Payment form not shown
10. Bails out stating invalid params
11. Bails out refusing the recipient
12. Unstable behaviour for intent call

## Android Status

Name | Version | UPI Setup Status | UPI Linking Status | Transaction Functioning Status | "Unverified Source" warning | Notes
-|-|-|-|-|-|-
Airtel | 4.21.0.2 | 1 | 1 | 3 | | Manual navigation forced, results in 'user_canceled' response
Amazon | 22.7.0.330 | 1 | 1 | 5
BHIM | 2.6.5 | 1 | 1 | 4
BHIM ALLBANK | 1.2.7 | 10 | 1
BHIM Andhra Bank | 1.2.37 | 9 | 1
BHIM AUPay | 1.0.11 | 1 | 1 | 7 | Yes
BHIM Axis Pay | 2.6.10.10 | 1 | 1 | 3
BHIM Bandhan UPI | 1.6.2 | 1 | 1 | 7 | Yes | "No value for TXN ID" error while paying
BHIM BOB Pay | 3.4.10 | 1 | 1 | 4
BHIM BOI UPI | 2.0.3 | 1 | 1 | 3 | Yes
BHIM Cent UPI | 2.0.11 | 1 | 1 | 9 | Yes
BHIM CORP UPI | 1.0.3 | 10 | 1
BHIM CSB Pay | 1.2.1 | 1 | 1 | 7 | | Payment not complete and abruptly returns to caller
BHIM CUB eWallet | 1.6.1 | 1 | 1 | Works | Yes
BHIM DCB UPI | 2.1.16 | 1 | 1 | Works | Yes
BHIM DLB UPI | 1.1.0 | 1 | 1 | 4
BHIM Equitas UPI | 2.0.1 | 1 | 1 | 12
BHIM IDFC First Bank UPI | 1.1.15 | 1 | 1 | 10 |  | 'Not valid merchant' error
BHIM Indian Bank UPI | 1.5.14 | 10 | 1
BHIM IndusPay UPI | 3.2.3 | 1 | 1 | 7 | Yes | Fails without any explicit error message
BHIM IOB UPI | 1.27 | 8 | 1
BHIM JetPay | 2.0.0 | 1 | 1 | 12 | | Exits as soon as launched and returns to caller
BHIM J&K Bank UPI | 1.1.5 | 8 | 2
BHIM KBL UPI | 1.2.7 | 1 | 1 | 10 | Yes
BHIM KVB Upay | 1.1.24 | 1 | 1 | 7
BHIM LOTZA UPI | 3.5.1 | 1 | 1 | 12
BHIM LVB Upaay | 1.3.5 | 9 | 2
BHIM Oriental Pay | 2.0.16 | 10 | 1
BHIM Paywiz V2 | 2.9 | 4 | 2
BHIM PNB | 2.1.2 | 4 | 1
BHIM PSB | 2.1.08 | 10 | 1
BHIM RBL Pay | 2.0.3 | 1 | 1 | 12
BHIM SBI Pay | 2.3.1 | 1 | 1 | 7 | Yes
BHIM@Synd UPI | 2.9.4 | 10 | 2
BHIM UCO UPI | 1.2.7 | 1 | 1 | 12
BHIM United UPI Pay | 2.0.8 | 8 | 2
BHIM Vijaya UPI | 1.2.0 | 8 | 1
BHIM YesPay | 4.17 | 1 | 1 | Works
BPay | 3.4.2 | 8 | 2
Bullet | 1.1.0 | 1 | 1 | 7
Canara Bank | 2.0.58 | 1 | 1 | 7 | Yes | "B07" error (parameter in UPI reqPay API response)
Cointab | 1.3.37 | 1 | 1 | Works
CRED | 2.1.17.15 | 1 | 1 | 4
CUB mBank Plus | 1.6.6 | 1 | 3
DakPay | 2.0.5 | 7 | 2
Digitbank DBS | 4.12.1 | 3 | 1
FamPay | 1.2.9 | 6 | 1
Freecharge | 9.11.1 | 1 | 1 | Works
Google Pay | 126.1.2 | 1 | 1 | 5
HDFC Bank | 10.0.7 | 8 | 1
HSBC Simply Pay | 1.22 | 1 | 1 | 2 | Yes
iMobile | 12.6 | 1 | 1 | Works
Khaalijeb | 2.4.26 | 6 | 2
LazyPay | 7.6.2 | 2 | 1
MahaUpi | 1.7.0 | 1 | 1 | Works
Mi Pay | 2.14.0-g | 1 | 1 | 3
Mobikwik | 22.5.2 | 1 | 1 | Works
MudraPay | 1.8.7 | 5 | 2
MyJio | 6.0.33 | 1 | 1 | 3
OmegaPay | 1.2.28 | 1 | 1 | Works
Paytm | 9.3.2 | 1 | 1 | 5
PayZapp | 4.09.00.03 | 8 | 2
PhonePe | 4.1.11 | 1 | 1 | 6
RBL MoBank | 8.0.18 | 1 | 1 | 8 | | Form doesn't have the amount and cannot be edited
Realme PaySa | 2.0.2 | 6 | 2
SIB Mirror+ | 8.0.18 | 8 | 2
Tranzapp | 1.8 | 1 | 1 | 7 | | "R03 payer name missing" error (parameter in UPI reqPay API response)
U-Mobile | 7.12.0 | 3 | 1
UltraCash | 1.10.49 | 1 | 1 | 7 | | "Transaction cancelled" error thrown
WhatsApp | 2.21.7.14 | 1 | 1 | 11 | | A pre-launch popup appears with message about refusing to pay the recipient
YesBank | 5.2.15 | 3 | 1
Yuva Pay | 2.3.2 | 1 | 1 | Works

## iOS Status

Name | Version | UPI Setup Status | UPI Linking Status | Transaction Functioning Status | "Unverified Source" warning | Notes
-|-|-|-|-|-|-
Airtel | 4.7.50 | 1 | 3
Allahabad emPower | 3.0.1 | 10 | 3
Amazon | 17.7.0 | 1 | 3
BHIM | 2.6.5 | 1 | 3
BHIM Andhra Bank | 2.4 | 9 | 3
BHIM AUPay | 1.1 | 1 | 1 | Works | Yes
BHIM Axis Pay | 3.3.3 | 1 | 3
BHIM Bandhan UPI | 1.0.1 | 1 | 3
BHIM BOB Pay | 1.9 | 1 | 3
BHIM BOI UPI | 2.0.3 | 1 | 3
BHIM Cent UPI | 2.0.11 | 1 | 3
BHIM DCB UPI | 1.0 | 9 | 3
BHIM DLB UPI | 1.3 | 1 | 3
BHIM IDFC First Bank UPI | 1.9 | 1 | 3
BHIM Indian Bank UPI | 1.6.1 | 10 | 3
BHIM JK Bank UPI | 1.1.2 | 8 | 1
BHIM KVB Upay | 1.1.16 | 1 | 1 | 9
BHIM LOTZA Pay | 3.5 | 1 | 1 | 7 | | "Invalid intent" error
BHIM LVB Upaay | 1.3.4 | 8 | 3
BHIM RBL Pay | 2.0 | 4 | 3
BHIM SBI Pay | 1.3.4 | 1 | 3
BHIM@Synd UPI | 2.3 | 10 | 1
BHIM UCO UPI | 1.6 | 1 | 3
BHIM United UPI | 2.7 | 8 | 1
BHIM Vijaya UPI | 1.4 | 8 | 1
BHIM Yes Pay | 4.17 | 8 | 3
BPay | 2.0.5 | 6 | 3
Bullet | 1.1.0 | 1 | 1 | 8 | | Submit button is disabled in the payment form
Canara Bank | 2.0.38 | 1 | 3
Cointab | 1.1.29 | 1 | 1 | Works
CRED | 2.5.8 | 1 | 3
Digibank DBS | 4.12.2 | 3 | 3
FamPay | 2.0.7 | 6 | 1
Freecharge | 4.8.2 | 1 | 1 | Works
Google Pay | 118.1.8 | 1 | 1 | 5
HDFC Bank | 10.0.7 | 5 | 3
HSBC Simply Pay | 2.3.2 | 1 | 3
iMobile | 6.9 | 1 | 3
LazyPay | 4.5.0 | 2 | 3
Mobikwik | 23.0 | 1 | 1 | Works
MyJio | 6.0.23 | 1 | 3
Paytm | 9.4.0 | 1 | 1 | Works
PhonePe | 5.6.00 | 1 | 1 | 6
RBL MoBank | 8.0.21 | 6 | 3
SIB Mirror+ | 8.0.14 | 4 | 3
U-Mobile | 7.12.0 | 3 | 3
WhatsApp | 2.21.71 | 1 | 1 | Works
YesBank | 5.2.14 | 3 | 3
