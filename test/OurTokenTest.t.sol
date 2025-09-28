//SPDX-License-Identifier:MIT
pragma solidity ^0.8.19;
import {Test} from "forge-std/Test.sol";
import {OurToken} from "../src/OurToken.sol";
import {DeployOurToken} from "../script/DeployOurToken.s.sol";

contract OurTokenTest is Test{
    OurToken public ourToken;
    DeployOurToken public deployer;

    address bob = makeAddr("bob");
    address alice = makeAddr("alice");
    uint256 public constant STARTINGBALANCE = 100 ether;

    function setUp() public{
        deployer = new DeployOurToken();
        ourToken = deployer.run();
        vm.prank(msg.sender);
        ourToken.transfer(bob,STARTINGBALANCE);
    
    }
    function testBobBalance() public{
        assertEq(ourToken.balanceOf(bob),STARTINGBALANCE);
    }
    function testallowance() public{
        vm.prank(bob);
        ourToken.approve(alice,50 ether);
        assertEq(ourToken.allowance(bob,alice),50 ether);
    }
    function testAliceSpent() public{
        vm.prank(bob);
        ourToken.approve(alice,50 ether);
        assertEq(ourToken.allowance(bob,alice),50 ether);
        vm.prank(alice);
        ourToken.transferFrom(bob,alice,50 ether);
        assertEq(ourToken.balanceOf(alice),50 ether);
        assertEq(ourToken.balanceOf(bob),50 ether);
        assertEq(ourToken.balanceOf(alice),50 ether);
    }

}
