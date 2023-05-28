pragma solidity ^0.7.6;

contract TimeLock {
    mapping(address => uint) public balances;
    mapping(address => uint) public lockTime;

//   添加金额 ，并且锁定时间 当前时间加一个星期
    function deposit() external payable {
        balances[msg.sender] += msg.value;
        lockTime[msg.sender] = block.timestamp + 1 weeks;
    }

// 继续添加时间  问题传入负数怎么办
    function increaseLockTime(uint _secondsToIncrease) public {

        require(int(_secondsToIncrease) >= 0, "a must be non-negative");
        lockTime[msg.sender] += _secondsToIncrease;
    }


// 取钱，看下时候账户是否有钱，和时间是否够了，够就取出所有钱
    function withdraw() public {
        require(balances[msg.sender] > 0, "Insufficient funds");
        require(block.timestamp > lockTime[msg.sender], "Lock time not expired");

        uint amount = balances[msg.sender];
        balances[msg.sender] = 0;

        (bool sent, ) = msg.sender.call{value: amount}("");
        require(sent, "Failed to send Ether");
    }

    

}
