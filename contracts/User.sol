// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract Users {
    uint public nextId = 1;

    struct User{
        uint id;
        string name;
        string email;
        string password;
        bool isActive;
    }

    mapping(uint => User) public users;

    event UserCreated(uint id, string name, string email);
    event UserUpdated(uint id, string name, string email);
    event UserDeactivated(uint id);

    function createUser(string memory name, string memory email, string memory password) public {
        users[nextId] = User(nextId, name, email, password, true);
        emit UserCreated(nextId, name, email);
        nextId++;
    }

    function getUser(uint id) public view returns (User memory) {
        return users[id];
    }

    function updateUser(uint id, string memory name, string memory email, string memory password) public {
        User storage usr = users[id];
        usr.name = name;
        usr.email = email;
        usr.password = password;
        emit UserUpdated(id, name, email);
    }

    function deactivateUser(uint id) public {
        User storage usr = users[id];
        usr.isActive = false;
        emit UserDeactivated(id);
    }
}