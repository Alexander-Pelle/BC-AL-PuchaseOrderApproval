page 50203 "PO Approval Setup List"
{
    PageType = List;
    SourceTable = "PO Approval Setup";
    Caption = 'PO Approval Setup List';
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field("Approver User Id"; Rec."Approver User Id")
                {
                    ApplicationArea = All;
                }
                field("Minimum Amount"; Rec."Minimum Amount")
                {
                    ApplicationArea = All;
                }
                field("Maximum Amount"; Rec."Maximum Amount")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

}