pragma solidity ^0.8.10;

// SPDX-License-Identifier: MIT
contract Proposals {
    
    uint256[] public id_numbers;
    string[][2] public proposals; // {id: {title: description}}

    function proposalAmount() public view returns(uint256) {
        return id_numbers.length;
    }

    function newProposal(string memory title, string memory description) public returns(uint256) {
        uint256 id = id_numbers.length;
        id_numbers.push(id);
        proposals.push([title, description]);

        return id;
    }

    function getProposalTitle(uint256 id) public view returns(string memory) {
        return proposals[id][0];
    }

    function getProposalDescription(uint256 id) public view returns(string memory) {
        return proposals[id][1];
    }
}