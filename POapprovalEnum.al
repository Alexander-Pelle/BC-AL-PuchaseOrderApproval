enum 50204 "Purchase Order Approval Status"
{
    Extensible = true;
    Caption = 'Purchase Order Approval Status';

    value(0; Open)
    {
        Caption = 'Open';
    }
    value(1; "Pending Approval")
    {
        Caption = 'Pending Approval';
    }
    value(2; Approved)
    {
        Caption = 'Approved';
    }

    value(3; Rejected)
    {
        Caption = 'Rejected';
    }
}