// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MultiCandidateVoting {
    address public admin;
    mapping(address => bool) public voters;
    mapping(bytes32 => uint256) public votes;
    bytes32[] public candidateList;

    event VoteCast(address indexed voter, bytes32 candidate);
    event CandidateAdded(bytes32 candidate);

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only the admin can call this function");
        _;
    }

    modifier onlyVoter() {
        require(voters[msg.sender], "Only registered voters can participate");
        _;
    }

    constructor(address[] memory _voters, bytes32[] memory _initialCandidates) {
        admin = msg.sender;
        for (uint256 i = 0; i < _voters.length; i++) {
            require(_voters[i] != address(0), "Invalid voter address");
            voters[_voters[i]] = true;
        }

        for (uint256 i = 0; i < _initialCandidates.length; i++) {
            addCandidate(_initialCandidates[i]);
        }
    }

}
