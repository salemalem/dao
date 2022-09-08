// SPDX-License-Identifier: MIT
pragma solidity 0.8.16;

import "@openzeppelin/contracts@4.7.2/access/Ownable.sol";

contract Certificate is Ownable {
    mapping (address =>string)     private issuers;
    mapping (address =>string)     private receivers;
    mapping (address => uint256[]) private issuer_certs;
    mapping (address => uint256[]) private receiver_certs;
    // mapping (address => bool)      private authorized_issuer; 

    uint256 private cert_id;

    struct certificate {
        string  cert_type;
        uint256 cert_id;
        address issuer;
        address receiver;
        string  content;
        uint256 date;
    }

    certificate[] certificates;

    constructor() {
        cert_id = 0;
        issuers[msg.sender] = "Shyngys";
    }

    function get_issuer(address issuer) view external returns (string memory) {
        return issuers[issuer];
    }

    function get_receiver(address receiver) view external returns (string memory) {
        return receivers[receiver];
    }

    function get_cert_ids_of_issuer(address issuer) view external returns (uint256[] memory) {
        return issuer_certs[issuer];
    }

    function get_cert_ids_of_receiver(address receiver) view external returns (uint256[] memory) {
        return receiver_certs[receiver];
    }

    function register_issuer(address issuer, string memory issuer_name) external onlyOwner {
        // authorized_issuer[issuer] = true;
        issuers[issuer] = issuer_name;
    }

    function withdraw_issuer(address issuer) external onlyOwner {
        // authorized_issuer[issuer] = false;
        issuers[issuer] = "";
    }

    function issue_cert(string memory cert_type, string memory content, address receiver) external returns(uint256){
        require(keccak256(bytes(issuers[msg.sender])) != keccak256(bytes("")), "Unauthorized issuer! Please request to register, first.");
        certificates.push();

        certificate memory cert = certificates[cert_id];
        cert.cert_type = cert_type;
        cert.issuer = address(msg.sender);
        cert.cert_id = cert_id;
        cert.receiver = receiver;
        cert.content = content;
        cert.date = block.timestamp;

        issuer_certs[address(msg.sender)].push(cert_id);
        receiver_certs[receiver].push(cert_id);

        cert_id++;
        return cert_id;
    }

    function get_cert_by_id(uint256 _cert_id) external view returns(certificate memory) {
        return certificates[_cert_id];
    }
}
