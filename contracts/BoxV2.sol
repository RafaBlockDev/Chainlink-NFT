// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import "./Box.sol";

contract BoxV2 is Box {
    
    uint256 time;

    function increment() public {
        store(retrieve() + 1);
    }
}
