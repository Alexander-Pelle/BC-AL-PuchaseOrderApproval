# Purchase Order Approval Flow (Business Central AL)

This extension adds a simple, custom approval flow on top of standard Purchase Orders in Dynamics 365 Business Central.

## What it does

- Adds an **approval status** to Purchase Orders:
  - `Open → Pending Approval → Approved / Rejected`
- Lets users:
  - **Send for Approval**
  - **Approve**
  - **Reject**
- Blocks posting of Purchase Orders unless they are **Approved**.
- Uses a small **Approval Setup** table to define:
  - Approver user
  - Minimum and maximum approval amounts

## Objects

- **Enum**
  - `50200 Purchase Order Approval Status`
- **Table Extension**
  - `50201 PO Approval Ext` (extends `Purchase Header`)
    - Fields:
      - `Approval Status`
      - `Approver User Id`
      - `Approval Comment`
      - `Approval Date`
- **Setup**
  - Table `50202 PO Approval Setup`
  - Page `50203 PO Approval Setup List`
- **Page Extension**
  - `50204 PO Approval Page Ext` (extends `Purchase Order`)
    - Adds an “Approval” group to the page
    - Adds actions: **Send for Approval**, **Approve**, **Reject**
- **Codeunit (event subscriber)**
  - `50205 PO Approval Subscribers`
    - Subscribes to `Purch.-Post` and stops posting if the order is not Approved
- **Permission Sets**
  - `50206 PO-APPROVAL-USER`
  - `50207 PO-APPROVER`

## How it works

1. A record in **PO Approval Setup** links an approver user to an amount range.
2. On a Purchase Order:
   - **Send for Approval**:
     - Validates the PO amount against setup
     - Sets `Approval Status` to `Pending Approval`
     - Stores the approver user and timestamp
   - **Approve**:
     - Can only be run by the assigned approver
     - Sets status to `Approved`
   - **Reject**:
     - Can only be run by the assigned approver
     - Sets status to `Rejected`
3. When posting:
   - The event subscriber in `PO Approval Subscribers` checks the PO
   - If `Approval Status <> Approved`, posting is blocked with an error

## Setup and testing

1. Publish the extension to a sandbox from VS Code.
2. In Business Central:
   - Open **PO Approval Setup** and create a line with:
     - Code (e.g. `DEFAULT`)
     - Approver user
     - Min/Max amount range
   - Assign the permission sets `PO-APPROVAL-USER` and `PO-APPROVER` to the test user.
3. Create a Purchase Order:
   - Fill in vendor and lines so the total fits the Min/Max range.
   - Use **Send for Approval** → status should become `Pending Approval`.
   - Try to **Post** → posting should be blocked.
   - Use **Approve** as the approver → status becomes `Approved`.
   - Post again → posting should succeed.
