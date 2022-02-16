pragma solidity ^0.8.11;

contract calledContract {
    event callEvent(address sender, address origin, address from);
    function calledFunction() public {
        emit callEvent(msg.sender, tx.origin, address(this)); //수정함
    }
}

library calledLibrary {
    event callEvent(address sender, address origin,  address from);
    function calledFunction() public {
        emit callEvent(msg.sender, tx.origin, address(this)); //수정함
    }
}

contract caller {

    function make_calls(calledContract _calledContract) public {

    // Calling calledContract and calledLibrary directly
    _calledContract.calledFunction();
    calledLibrary.calledFunction();

    // Low-level calls using the address object for calledContract
    //아래 부분 수정함(function require(bool) 에러 해결)
    // 추가 수정사항: keccak256() now accept only a single bytes argument. Moreover, the argument is not padded.
    //This was changed to make more explicit and clear how the arguments are concatenated.
    (bool success1, ) = address(_calledContract).
            call(abi.encodeWithSignature("calledFunction()")); //수정함
    require(success1);
    (bool success2, ) = address(_calledContract).
            delegatecall(abi.encodeWithSignature("calledFunction()")); //수정함
    require(success2);



	}
}
