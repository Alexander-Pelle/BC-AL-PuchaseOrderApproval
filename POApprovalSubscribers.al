codeunit 50205 "PO Approval Subscribers"
{
    Subtype = Normal;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePostPurchaseDoc', '', false, false)]
    local procedure OnBeforePostPurchaseDoc(
        var PurchaseHeader: Record "Purchase Header";
        PreviewMode: Boolean;
        CommitIsSupressed: Boolean;
        var HideProgressWindow: Boolean;
        var ItemJnlPostLine: Codeunit "Item Jnl.-Post Line";
        var IsHandled: Boolean)
    begin

        if PurchaseHeader."Document Type" <> PurchaseHeader."Document Type"::Order then
            exit;

        if PurchaseHeader."Approval Status" <> PurchaseHeader."Approval Status"::Approved then begin

            IsHandled := true;
            Error(
              'Purchase order %1 cannot be posted because it is not approved. Current approval status: %2',
              PurchaseHeader."No.", Format(PurchaseHeader."Approval Status"));
        end;
    end;
}
