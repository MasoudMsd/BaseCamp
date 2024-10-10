// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

abstract contract Employee {
    uint public idNumber;
    uint public managerId;

    constructor(uint _idNumber, uint _managerId) {
        idNumber = _idNumber;
        managerId = _managerId;
    }

    function getAnnualCost() public virtual returns (uint);
}
