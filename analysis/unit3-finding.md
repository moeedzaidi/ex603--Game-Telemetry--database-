# Unit 3 Finding: Dashboard Data Audit

The dashboard reported that approximately half of all events ended in failure, which led leadership to freeze the quarterly ranked-mode rewards. Our initial review identified 200 participation records: 156 finished events (78%), 34 abandoned events (17%), and 10 contested events (5%). These results show that most events finished successfully, while the remaining records require further investigation. The available status counts alone do not establish the actual network-timeout rate.

The dashboard's reported figure needs to be checked against the underlying records and the rules used to classify a failure. In particular, abandoned or contested events should not automatically be treated as network timeouts without supporting evidence. The team should verify how missing information and event statuses were handled before accepting the reported rate.

We recommend keeping the ranked-mode rewards frozen only until the calculation has been verified. The team should correct the classification rules, recalculate the failure rate, and review the affected records before deciding whether to release or adjust the rewards.
