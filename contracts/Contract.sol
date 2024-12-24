// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GratitudeJournal {
    struct GratitudeEntry {
        string content;
        uint256 timestamp;
        address author;
    }
    
    // Mapping from user address to their gratitude entries
    mapping(address => GratitudeEntry[]) private userEntries;
    
    // Event emitted when a new gratitude entry is added
    event GratitudeAdded(address indexed user, string content, uint256 timestamp);
    
    /**
     * @dev Adds a new gratitude entry to the journal
     * @param _content The gratitude message to store
     */
    function addGratitude(string memory _content) public {
        require(bytes(_content).length > 0, "Gratitude content cannot be empty");
        require(bytes(_content).length <= 1000, "Content too long");
        
        GratitudeEntry memory newEntry = GratitudeEntry({
            content: _content,
            timestamp: block.timestamp,
            author: msg.sender
        });
        
        userEntries[msg.sender].push(newEntry);
        
        emit GratitudeAdded(msg.sender, _content, block.timestamp);
    }
    
    /**
     * @dev Retrieves all gratitude entries for the calling user
     * @return An array of gratitude entries
     */
    function getMyEntries() public view returns (GratitudeEntry[] memory) {
        return userEntries[msg.sender];
    }
}