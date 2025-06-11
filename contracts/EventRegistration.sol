// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

interface IEvents {
    function getEvent(uint id) external view returns (
        uint, string memory, string memory, string memory, string memory, bool, uint, uint, string memory, address
    );
}

interface IUser {
    function getUser(uint id) external view returns (
        uint, string memory, string memory, string memory, bool;
    );
}

contract EventRegistration{
    address public eventAddress;
    address public userAddress;

    constructor(address _eventAddress, address _userAddress) public {
        eventAddress = _eventAddress;
        userAddress = _userAddress;
    }

    function registerForEvent(uint eventId) public {
        IEvents event = IEvents(eventAddress);
        IUser user = IUser(userAddress);

        uint eventCapacity = event.getEvent(eventId).capacity;
        uint eventDate = event.getEvent(eventId).date;
    }
}
