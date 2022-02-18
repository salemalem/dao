pragma solidity ^0.8.10;

contract DAOtoken {
    function getAddressBalance(address myAddress) public view returns (uint256) {}
}

// SPDX-License-Identifier: MIT
contract Proposals {
    
    uint256 public id;
    address public dev;

    DAOtoken public daoToken;

    struct Proposal {
        address author;
        string title;
        string description;
        mapping(address => bool) upvotedAddresses;
        uint256 upvotes;
        bool active;
    }
    Proposal[] proposals;

    constructor(address DAOtokenAddress) {
        id = 0;
        dev = address(msg.sender);
        daoToken = DAOtoken(DAOtokenAddress);
    }

    function proposalAmount() public view returns(uint256) {
        return id;
    }

    function newProposal(string memory title, string memory description) public returns(uint256) { //string memory title, string memory description
        proposals.push();
        Proposal storage proposal = proposals[id];

        proposal.author = address(msg.sender);
        proposal.title  = title;
        proposal.description = description;
        proposal.upvotedAddresses[msg.sender] = true;
        proposal.upvotes = 1;
        proposal.active = true;

        id++;
        return id;
    }

    function getProposalAuthor(uint256 _id) public view returns(address) {
        require(proposals.length > _id, "404");

        return proposals[_id].author;
    }

    function getProposalTitle(uint256 _id) public view returns(string memory) {
        return proposals[_id].title;
    }

    function getProposalDescription(uint256 _id) public view returns(string memory) {
        return proposals[_id].description;
    }

    function getProposalUpvotes(uint256 _id) public view returns (uint256) {
        return proposals[_id].upvotes;
    }

    function getProposalStatus(uint256 _id) public view returns (bool active) {
        return proposals[_id].active;
    }

    function upvoteProposal(uint256 _id) public returns (uint256 newUpvoteCount) {
        require(daoToken.getAddressBalance(address(msg.sender)) > 0, "You need to hold DAO tokens for governance");
        if (!proposals[_id].upvotedAddresses[address(msg.sender)]) {
            proposals[_id].upvotes++;
            proposals[_id].upvotedAddresses[address(msg.sender)] = true;
        }
        return proposals[_id].upvotes;
    }

    function reOpenProposalStatus(uint256 _id) public returns (bool newActiveStatus) {
        require(dev == address(msg.sender));
        proposals[_id].active = true;
        
        return proposals[_id].active;
    }

    function closeProposal(uint256 _id) public returns (bool newActiveStatus) {
        require(dev == address(msg.sender));
        proposals[_id].active = false;
        
        return proposals[_id].active;
    }
}