// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {DeployBasicNft} from "script/DeployBasicNft.s.sol";
import {Test} from "forge-std/Test.sol";
import {BasicNft} from "src/BasicNft.sol";

contract TestBasicNft is Test {
    DeployBasicNft public deployer;
    BasicNft public basicNft;
    address public USER = makeAddr("user");
    string public constant PUG_TOKEN_URI =
        "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    function setUp() public {
        deployer = new DeployBasicNft();
        basicNft = deployer.run();
    }

    function testNameIsCorrect() public view {
        string memory expectedName = "Dogie";
        string memory actualName = basicNft.name();

        // String -> array of bytes32
        // == can only be done of primitive datatypes like uint256,bool,etc
        assert(
            (keccak256(abi.encodePacked(expectedName))) ==
                (keccak256(abi.encodePacked(actualName)))
        );
    }

    function testCanMintAndHaveABalance() public {
        vm.prank(USER);
        basicNft.mintNft(PUG_TOKEN_URI);

        assert(basicNft.balanceOf(USER) == 1);
        assert(
            keccak256(abi.encodePacked(PUG_TOKEN_URI)) ==
                keccak256(abi.encodePacked(basicNft.tokenURI(0)))
        );
    }
}
