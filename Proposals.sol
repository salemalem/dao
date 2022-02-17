pragma solidity ^0.8.10;

// SPDX-License-Identifier: MIT
contract Proposals {
    
    uint256[] public id_numbers;
    mapping (uint256 => string[]) public proposals; // {id: {title: description}}

    function proposalAmount() public view returns(uint256) {
        return id_numbers.length;
    }

    function newProposal(string memory title, string memory description) public returns(uint256) {
        uint256 id = id_numbers.length;
        id_numbers.push(id);
        proposals[id][0] = title;
        proposals[id][1] = description;

        return id;
    }

    function getProposalTitle(uint256 id) public view returns(string memory) {
        return proposals[id][0];
    }

    function getProposalDescription(uint256 id) public view returns(string memory) {
        return proposals[id][1];
    }
}