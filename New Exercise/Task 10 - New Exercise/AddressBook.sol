// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract AddressBook is Ownable {
    struct Contact {
        uint id;
        string firstName;
        string lastName;
        uint[] phoneNumbers;
    }

    mapping(uint => Contact) private contacts;
    uint private nextId = 1;

    error ContactNotFound(uint id);

    constructor(address initialOwner) Ownable(initialOwner) {}

    function addContact(string memory _firstName, string memory _lastName, uint[] memory _phoneNumbers) public onlyOwner {
        Contact memory newContact = Contact(nextId, _firstName, _lastName, _phoneNumbers);
        contacts[nextId] = newContact;
        nextId++;
    }

    function deleteContact(uint _id) public onlyOwner {
        if (contacts[_id].id == 0) {
            revert ContactNotFound(_id);
        }
        delete contacts[_id];
    }

    function getContact(uint _id) public view returns (Contact memory) {
        if (contacts[_id].id == 0) {
            revert ContactNotFound(_id);
        }
        return contacts[_id];
    }

    function getAllContacts() public view returns (Contact[] memory) {
        uint count = 0;
        for (uint i = 1; i < nextId; i++) {
            if (contacts[i].id != 0) {
                count++;
            }
        }

        Contact[] memory allContacts = new Contact[](count);
        uint index = 0;
        for (uint i = 1; i < nextId; i++) {
            if (contacts[i].id != 0) {
                allContacts[index] = contacts[i];
                index++;
            }
        }

        return allContacts;
    }
}
