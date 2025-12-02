table 50202 "PO Approval Setup"
{

    Caption = 'PO Approval Setup';

    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
        }

        field(2; "Approver User Id"; Code[50])
        {
            Caption = 'Approver User Id';
            TableRelation = User."User Security ID";
        }
        field(3; "Minimum Amount"; Decimal)
        {
            Caption = 'Minimum Amount';
        }
        field(4; "Maximum Amount"; Decimal)
        {
            Caption = 'Maximum Amount';
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
}
