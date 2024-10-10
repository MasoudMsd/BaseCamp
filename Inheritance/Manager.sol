// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Manager {
    uint[] public employeeIds;

    function addReport(uint _employeeId) public {
        employeeIds.push(_employeeId);
    }

    function resetReports() public {
        delete employeeIds;
    }
}
