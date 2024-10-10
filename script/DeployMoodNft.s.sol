// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {MoodNft} from "src/MoodNft.sol";
import {console} from "forge-std/console.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract DeployMoodNft is Script {
    function run() external returns (MoodNft) {
        string memory sadSvg = vm.readFile("images/Dynamic Nft/Sad.svg");
        string memory happySvg = vm.readFile("images/Dynamic Nft/Happy.svg");

        vm.startBroadcast();
        MoodNft moodnft = new MoodNft(
            SvgToImageURI(happySvg),
            SvgToImageURI(sadSvg)
        );
        vm.stopBroadcast();

        return moodnft;
    }

    function SvgToImageURI(
        string memory svg
    ) public pure returns (string memory) {
        string memory baseURL = "data:image/svg+xml;base64,";
        string memory svgBase64Encoded = Base64.encode(
            bytes(string(abi.encodePacked(svg)))
        );
        return string(abi.encodePacked(baseURL, svgBase64Encoded));
    }
}
