// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract Events {
    uint public nextId = 1;

    struct Event {
        uint id;
        string name;
        string description;
        uint date; // Unix timestamp
        address creator;
    }

    mapping(uint => Event) public events;

    event EventCreated(uint id, string name, address creator);
    event EventUpdated(uint id, string name, address updater);

    function createEvent(string memory name, string memory description, uint date) public {
        require(date > block.timestamp, "Event must be in the future");

        events[nextId] = Event(nextId, name, description, date, msg.sender);
        emit EventCreated(nextId, name, msg.sender);
        nextId++;
    }

    function updateEvent(uint id, string memory name, string memory description, uint date) public {
        Event storage evt = events[id];
        require(evt.creator == msg.sender, "Not authorized");
        require(date > block.timestamp, "Event must be in the future");

        evt.name = name;
        evt.description = description;
        evt.date = date;

        emit EventUpdated(id, name, msg.sender);
    }

    function getEvent(uint id) public view returns (Event memory) {
        return events[id];
    }
}
