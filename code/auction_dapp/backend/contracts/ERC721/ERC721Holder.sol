pragma solidity ^0.8.11;

import "./ERC721Receiver.sol";

//수정: abstract, override 추가
abstract contract ERC721Holder is ERC721Receiver {
  function onERC721Received(address, uint256, bytes memory) public override returns(bytes4) {
    return ERC721_RECEIVED;
  }
}
