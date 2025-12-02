tableextension 50201 "PO Approval Ext" extends "Purchase Header"
{
    fields
    {
        field(50200; "Approval Status"; Enum "Purchase Order Approval Status")
        {
            Caption = 'Approval Status';
            DataClassification = CustomerContent;
        }

        field(50201; "Approver User Id"; Code[50])
        {
            Caption = 'Approver User Id';
            DataClassification = CustomerContent;
            TableRelation = User."User Security ID";
        }

        field(50202; "Approval Comment"; Text[250])
        {
            Caption = 'Approval Comment';
            DataClassification = CustomerContent;
        }

        field(50203; "Approval Date"; DateTime)
        {
            Caption = 'Approval Date';
            DataClassification = CustomerContent;
        }
    }
}
