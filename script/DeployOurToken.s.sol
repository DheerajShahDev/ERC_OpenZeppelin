//SPDX-License-Identifier:MIT
pragma solidity ^0.8.19;
import {Script} from "forge-std/Script.sol";
import {OurToken} from "../src/OurToken.sol";
contract DeployOurToken is Script{
    function run() external returns(OurToken){
        uint256 INITIAL_SUPPLY = 100 ether;
        vm.startBroadcast();
        OurToken ot = new OurToken(INITIAL_SUPPLY);
        vm.stopBroadcast();
        return ot;
    }
}