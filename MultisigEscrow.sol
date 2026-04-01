// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

/**
 * @title MultisigEscrow
 * @dev 2-of-3 Escrow system for secure commerce.
 */
contract MultisigEscrow is ReentrancyGuard {
    address public buyer;
    address public seller;
    address public arbiter;
    
    uint256 public amount;
    bool public released;

    mapping(address => bool) public approvals;

    event FundsReleased(address indexed to, uint256 amount);
    event Approved(address indexed approver);

    constructor(address _seller, address _arbiter) payable {
        require(msg.value > 0, "Must fund escrow");
        buyer = msg.sender;
        seller = _seller;
        arbiter = _arbiter;
        amount = msg.value;
    }

    /**
     * @dev Approve the release of funds.
     */
    function approve() external {
        require(msg.sender == buyer || msg.sender == seller || msg.sender == arbiter, "Unauthorized");
        approvals[msg.sender] = true;
        emit Approved(msg.sender);

        _checkAndRelease();
    }

    function _checkAndRelease() internal {
        if (released) return;

        uint256 approvalCount = 0;
        if (approvals[buyer]) approvalCount++;
        if (approvals[seller]) approvalCount++;
        if (approvals[arbiter]) approvalCount++;

        // 2-of-3 threshold
        if (approvalCount >= 2) {
            released = true;
            uint256 payout = amount;
            amount = 0;
            
            // Logic to determine recipient (usually Seller, or Buyer if refund)
            address recipient = (approvals[seller] && (approvals[buyer] || approvals[arbiter])) ? seller : buyer;
            
            payable(recipient).transfer(payout);
            emit FundsReleased(recipient, payout);
        }
    }
}
