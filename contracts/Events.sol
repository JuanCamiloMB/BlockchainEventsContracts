// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract Events {
    uint public nextId = 1;

    struct Event {
        uint id;
        string name;
        string visibility;
        string description;
        string location;
        bool requireApproval;
        uint capacity;
        uint date; // Unix timestamp
        string creatorName;
        address creator;
    }

    mapping(uint => Event) public events;

    event EventCreated(uint id, string name, address creator, string creatorName, string visibility, string description, uint date, string location, bool requireApproval, uint capacity);
    event EventUpdated(uint id, string name, address updater, string updaterName, string visibility, string description, uint date, string location, bool requireApproval, uint capacity);

    function createEvent(
        string memory name,
        string memory visibility;
        string memory description,
        string memory location,
        bool requireApproval,
        uint capacity,
        uint date,
        string memory creatorName
    ) public {
        require(date > block.timestamp, "Event must be in the future");

        events[nextId] = Event(nextId, name, description, location, requireApproval, capacity, date, creatorName, msg.sender);
        emit EventCreated(nextId, name, msg.sender, creatorName, visibility, description, date, location, requireApproval, capacity);
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
