// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./AddressBook.sol";

contract AddressBookFactory {
    function deploy() public returns (address) {
        AddressBook newAddressBook = new AddressBook(msg.sender);
        return address(newAddressBook);
    }
}
