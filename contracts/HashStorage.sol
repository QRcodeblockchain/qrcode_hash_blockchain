// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract HashStorage {
    mapping(string => bool) private hashExists;
    mapping(string => bool) private hashActive; // New mapping to track if a hash is active

    event HashStored(string hash);
    event HashDeleted(string hash);
    event HashStoreFailed(string hash, string reason);
    event HashDeleteFailed(string hash, string reason);

    // Function to store hash
    function storeHash(string memory hash) public returns (bool) {
        if (hashExists[hash] && hashActive[hash]) {
            emit HashStoreFailed(hash, "Hash already exists");
            return false; // Hash already exists, indicate failure
        }
        hashExists[hash] = true;
        hashActive[hash] = true; // Mark hash as active
        emit HashStored(hash);
        return true; // Hash stored successfully
    }

    // Function to delete (expire) hash
    function deleteHash(string memory hash) public returns (string) {
        if (!hashExists[hash]) {
            emit HashDeleteFailed(hash, "Hash does not exist");
            return "Hash does not exist"; // Hash does not exist, cannot expire
        }
        if (!hashActive[hash]) {
            emit HashDeleteFailed(hash, "Hash already expired");
            return "Hash already expired"; // Hash already expired
        }
        
        hashActive[hash] = false; // Mark hash as expired
        emit HashDeleted(hash);
        return "Hash expired successfully"; // Hash expired successfully
    }

    // Function to verify hash
    function verifyHash(string memory hash) public view returns (bool) {
        return hashExists[hash] && hashActive[hash];
    }
}
