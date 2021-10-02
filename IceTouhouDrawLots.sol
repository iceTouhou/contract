// SPDX-License-Identifier: GPL-3.0
pragma solidity  >=0.7.0 <0.9.0;

contract IceTouhouDrawLots {
    
    address public adminer;
    uint public participantsAmount;
    bool public projectLock;
    uint256[] public participants;
    
    event Shuffle(address from, address to, uint amount);

    constructor(uint _participantsAmount) {
        adminer = msg.sender;
        participantsAmount = _participantsAmount;
        for (uint256 i = 0; i < _participantsAmount; i++) {
            participants.push(i+1);
        }
    }
    
    function shuffle() external {
        require(msg.sender == adminer, "");
        require(projectLock == false, "");

        for (uint256 i = 0; i < participants.length; i++) {
            uint256 n = i + uint256(keccak256(abi.encodePacked(block.timestamp))) % (participants.length - i);
            uint256 temp = participants[n];
            participants[n] = participants[i];
            participants[i] = temp;
        }

        projectLock = true;
    }
    
    function getParticipants() public view returns (uint256[] memory){
        return participants;
    }
}
