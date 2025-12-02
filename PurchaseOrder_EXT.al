pageextension 50204 "PO Approval Page Ext" extends "Purchase Order"
{
    layout
    {
        addlast(General)
        {
            group(Approval)
            {
                Caption = 'Approval';

                field("Approval Status"; Rec."Approval Status")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Approver User Id"; Rec."Approver User Id")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Approval Comment"; Rec."Approval Comment")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Approval Date"; Rec."Approval Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        addlast(Processing)
        {
            action(SendForApproval)
            {
                Caption = 'Send for Approval';
                ApplicationArea = All;
                Image = SendTo;

                trigger OnAction()
                var
                    Setup: Record "PO Approval Setup";
                begin
                    Rec.TestField("Buy-from Vendor No.");

                    if Rec."Approval Status" <> Rec."Approval Status"::Open then
                        Error('Only purchase orders with approval status Open can be sent for approval.');

                    if not Setup.FindFirst() then
                        Error('PO Approval Setup is not defined.');

                    if (Rec."Amount Including VAT" < Setup."Minimum Amount") or
                       (Rec."Amount Including VAT" > Setup."Maximum Amount")
                    then
                        Error(
                          'No approver is defined for this amount (%1).',
                          Rec."Amount Including VAT");

                    Rec."Approver User Id" := Setup."Approver User Id";
                    Rec."Approval Status" := Rec."Approval Status"::"Pending Approval";
                    Rec."Approval Comment" := 'Sent for approval';
                    Rec."Approval Date" := CurrentDateTime;
                    Rec.Modify(true);

                    Message(
                      'Purchase order %1 has been sent for approval to %2.',
                      Rec."No.", Rec."Approver User Id");
                end;
            }

            action(ApprovePO)
            {
                Caption = 'Approve';
                ApplicationArea = All;
                Image = Approve;

                trigger OnAction()
                begin
                    if Rec."Approval Status" <> Rec."Approval Status"::"Pending Approval" then
                        Error('Only purchase orders with status Pending Approval can be approved.');

                    if Rec."Approver User Id" <> UserId then
                        Error(
                          'Only the assigned approver (%1) can approve this order.',
                          Rec."Approver User Id");

                    Rec."Approval Status" := Rec."Approval Status"::Approved;
                    Rec."Approval Comment" := 'Approved';
                    Rec."Approval Date" := CurrentDateTime;
                    Rec.Modify(true);

                    Message('Purchase order %1 has been approved.', Rec."No.");
                end;
            }

            action(RejectPO)
            {
                Caption = 'Reject';
                ApplicationArea = All;
                Image = Cancel;

                trigger OnAction()
                begin
                    if Rec."Approval Status" <> Rec."Approval Status"::"Pending Approval" then
                        Error('Only purchase orders with status Pending Approval can be rejected.');

                    if Rec."Approver User Id" <> UserId then
                        Error(
                          'Only the assigned approver (%1) can reject this order.',
                          Rec."Approver User Id");

                    Rec."Approval Status" := Rec."Approval Status"::Rejected;
                    Rec."Approval Comment" := 'Rejected';
                    Rec."Approval Date" := CurrentDateTime;
                    Rec.Modify(true);

                    Message('Purchase order %1 has been rejected.', Rec."No.");
                end;
            }
        }
    }
}
