permissionset 50206 "PO-APPROVAL-USER"
{
    Assignable = true;
    Caption = 'PO Approval - User';

    Permissions =
        tabledata "PO Approval Setup" = RIMD,
        tabledata "Purchase Header" = RIMD,
        page "PO Approval Setup List" = X,
        page "Purchase Order" = X,
        codeunit "PO Approval Subscribers" = X;
}

permissionset 50207 "PO-APPROVER"
{
    Assignable = true;
    Caption = 'PO Approval - Approver';

    Permissions =
        tabledata "PO Approval Setup" = RIMD,
        tabledata "Purchase Header" = RIMD,
        page "PO Approval Setup List" = X,
        page "Purchase Order" = X,
        codeunit "PO Approval Subscribers" = X;
}
