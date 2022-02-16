// Version of Solidity compiler this program was written for
pragma solidity ^0.8.11;

contract owned {
	address owner;
	// Contract constructor: set owner
	constructor() {
		owner = payable(msg.sender);
	}
	// Access control modifier
	modifier onlyOwner {
	    require(msg.sender == owner, "Only the contract owner can call this function");
	    _;
	}
}

contract mortal is owned {
	// Contract destructor
	function destroy() public onlyOwner {
		selfdestruct(payable(owner));
	}
}

contract Faucet is mortal {
	event Withdrawal(address indexed to, uint amount);
	event Deposit(address indexed from, uint amount);

    // Give out ether to anyone who asks
    function withdraw(uint withdraw_amount) public {
        // Limit withdrawal amount
		require(withdraw_amount <= 0.1 ether);
		require(payable(this).balance >= withdraw_amount, //수정함
			"Insufficient balance in faucet for withdrawal request");
        // Send the amount to the address that requested it
        payable(msg.sender).transfer(withdraw_amount);
		emit Withdrawal(msg.sender, withdraw_amount);
    }
    // Accept any incoming amount
    receive () external payable { //수정함
		emit Deposit(msg.sender, msg.value);
	}
}
