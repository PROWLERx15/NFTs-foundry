// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {BasicNft} from "src/BasicNft.sol";
import {MoodNft} from "src/MoodNft.sol";

contract MintBasicNft is Script {
    string public constant PUG_TOKEN_URI =
        "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    function run() external {
        address mostRecentlyDeployed_BasicNftContract = DevOpsTools
            .get_most_recent_deployment("BasicNft", block.chainid);
        MintNftOnContract(mostRecentlyDeployed_BasicNftContract);
    }

    function MintNftOnContract(address BasicNft_contractAddress) public {
        vm.startBroadcast();
        BasicNft(BasicNft_contractAddress).mintNft(PUG_TOKEN_URI);
        vm.stopBroadcast();
    }
}

contract MintMoodNft is Script {
    function run() external {
        address mostRecentlyDeployed_MoodNftContract = DevOpsTools
            .get_most_recent_deployment("MoodNft", block.chainid);
        MintMoodNftOnContract(mostRecentlyDeployed_MoodNftContract);
    }

    function MintMoodNftOnContract(address MoodNft_contractAddress) public {
        vm.startBroadcast();
        MoodNft(MoodNft_contractAddress).mintNft();
        vm.stopBroadcast();
    }
}

contract FlipMoodNft is Script {
    uint256 public constant SENDER_NFT_ID = 0;

    function run() external {
        address mostRecentlyDeployed_MoodNftContract = DevOpsTools
            .get_most_recent_deployment("MoodNft", block.chainid);
        FlipMoodNftOnContract(mostRecentlyDeployed_MoodNftContract);
    }

    function FlipMoodNftOnContract(address MoodNft_contractAddress) public {
        vm.startBroadcast();
        MoodNft(MoodNft_contractAddress).flipMood(SENDER_NFT_ID);
        vm.stopBroadcast();
    }
}
