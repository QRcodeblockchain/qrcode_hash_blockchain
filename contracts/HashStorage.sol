// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract HashStorage {

    mapping(string => bool) private hashExists;
    mapping(string => bool) private hashActive; // Mapping to track if a hash is active
    // bool private initialized; // A flag to manage initialization status

    event HashStored(string hash);
    event HashDeleted(string hash);
    event HashStoreFailed(string hash, string reason);
    event HashDeleteFailed(string hash, string reason);

    // Function to initialize the contract (optional based on your use case)
    // function initialize() public {
    //     require(!initialized, "Contract is already initialized.");
    //     initialized = true;
    // }

    // Function to store hash
    function storeHash(string[] memory hashes) public returns (bool) {
        bool allStored = true;

        for (uint i = 0; i < hashes.length; i++) {
            if (!hashExists[hashes[i]]) {
                hashExists[hashes[i]] = true;
                hashActive[hashes[i]] = true; // Mark hash as active
                // emit HashStored(hashes[i]);
            } else {
                // emit HashStoreFailed(hashes[i], "Hash already exists");
                allStored = false; // At least one hash was already present
            }
        }

        return allStored; // Return true if all hashes were stored successfully
    }

    // Function to delete (expire) hash
    function deleteHash(string memory hash) public returns (string memory) {
        // require(initialized, "Contract is not initialized.");
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
        if (!hashExists[hash] && !hashActive[hash]) {
                    return true;
        } else {
                    return false;
         }
    }
    // Migration function to batch insert hashes
    // function migrateData(string[] calldata hashes, bool[] calldata actives) public {
    //     require(!initialized, "Contract is already initialized."); // Ensure not initialized or use another check for migration permission
    //     require(hashes.length == actives.length, "Data length mismatch");

    //     for (uint256 i = 0; i < hashes.length; i++) {
    //         hashExists[hashes[i]] = true;
    //         hashActive[hashes[i]] = actives[i];
    //     }

    //     initialized = true; // Mark as initialized after migration
    // }
}
