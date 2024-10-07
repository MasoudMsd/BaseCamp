// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract UnburnableToken {
    mapping(address => uint) public balances;
    uint public totalSupply;
    uint public totalClaimed;
    mapping(address => bool) private hasClaimed;

    error TokensClaimed();
    error AllTokensClaimed();
    error UnsafeTransfer(address to);

    constructor() {
        totalSupply = 100_000_000;
    }

    function claim() public {
        if (hasClaimed[msg.sender]) {
            revert TokensClaimed();
        }

        if (totalClaimed + 1000 > totalSupply) {
            revert AllTokensClaimed();
        }

        hasClaimed[msg.sender] = true;
        balances[msg.sender] += 1000;
        totalClaimed += 1000;
    }

    function safeTransfer(address _to, uint _amount) public {
        if (_to == address(0)) {
            revert UnsafeTransfer(_to);
        }

        if (_to.balance == 0) {
            revert UnsafeTransfer(_to);
        }

        require(balances[msg.sender] >= _amount, "Insufficient balance");

        balances[msg.sender] -= _amount;
        balances[_to] += _amount;
    }
}
