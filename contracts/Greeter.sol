//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.4;

import "hardhat/console.sol";
import "usingtellor/contracts/UsingTellor.sol";

//This contract has access to all functions in UsingTellor
contract Greeter is UsingTellor {
    string private greeting;
    uint256 public btcPrice;
    
    constructor(string memory _greeting, address payable _tellorAddress) UsingTellor(_tellorAddress) {
        console.log("Deploying a Greeter with greeting:", _greeting);
        greeting = _greeting;
    }

    function greet() public view returns (string memory) {
        return greeting;
    }

    function setGreeting(string memory _greeting) public {
        console.log("Changing greeting from '%s' to '%s'", greeting, _greeting);
        greeting = _greeting;
    }

    function setBtcPrice() public {
      bytes memory _b = abi.encode("SpotPrice",abi.encode("btc","usd"));
      bytes32 _btcQueryId = keccak256(_b);

      bool _didGet;
      uint256 _timestamp;
      bytes memory _value;

      (_value, _timestamp) = getDataBefore(_btcQueryId, block.timestamp-10 minutes);
      btcPrice = abi.decode(_value,(uint256));
    }

}
