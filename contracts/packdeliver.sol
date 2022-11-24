// SPDX-License-Identifier: UNIBO
pragma solidity ^0.8.0;

import "./packhelper.sol";

contract PackDeliver is PackHelper {

  function isContainerNotEmpty() private view returns(bool) {
    if (container.length > 0){
        return true;
    } else {
        return false;
    }
  }

  function remove(uint index, Pack[] memory array) internal pure {
    array[index] = array[array.length - 1];
    delete array[index];
  }

  //aggiornamenti stato consegna
  function _delivering(Pack[] memory _toDeliver) internal {
    uint256[] memory pCodes = new uint256[](_toDeliver.length);
    uint index = 0;
    for (uint i = 0; i < _toDeliver.length; i++){
      _toDeliver[i].delivered = true;
      isDeliveredMap[_toDeliver[i].pCode] = _toDeliver[i].delivered;
      pCodes[index] = _toDeliver[i].pCode;
      index++;
      remove(i, _toDeliver);
    }
    for (uint i = 0; i < container.length; i++){
      for(uint j = 0; j < pCodes.length; j++){
        if(pCodes[j] == container[i].pCode){
          container[i].delivered = true;
          remove(i, container);
        }
      }
    }
  }

  //controllo indirizzi e coordinate
  function _checkDelivering(address _receiver) internal {
    require(isContainerNotEmpty() == true);
    uint dim = 0;
    for (uint i = 0; i < container.length; i++){
      if((coordinateFromReceiver[container[i].receiver].lat == coordinateFromReceiver[_receiver].lat) 
        && (coordinateFromReceiver[container[i].receiver].long == coordinateFromReceiver[_receiver].long)){
        dim++;
      }
    }
    Pack[] memory toDeliver = new Pack[](dim);
    uint index = 0;
    for (uint i = 0; i < container.length; i++){
      if((coordinateFromReceiver[container[i].receiver].lat == coordinateFromReceiver[_receiver].lat) 
        && (coordinateFromReceiver[container[i].receiver].long == coordinateFromReceiver[_receiver].long)){
        toDeliver[index] = container[i];
        index++;
      }
    }
    _delivering(toDeliver);
  }

  //avviene consegna e trasferimento NFT da sender a receiver
  function deliver() public onlyOwner {
    address[] memory receivers = getAddressReceiver();
    uint dim = 0;
    for (uint i = 0; i < receivers.length; i++){
      uint[] memory count = new uint[](receivers.length);
      _checkDelivering(receivers[i]); //check coordinate
      count[i] = mintedPerWallet[receivers[i]];
      dim = dim + count[i];
      if(i == 0){
        for(uint j = 1; j <= count[i]; j++){
          if(ownerOf(j) == msg.sender){
            approve(address(this), j);
            transferFrom(msg.sender, receivers[i], j);
          }
        }
      }
      else {
        for(uint j = count[i - 1] + 1; j <= dim; j++){
          if(ownerOf(j) == msg.sender){
            approve(address(this), j);
            transferFrom(msg.sender, receivers[i], j);
          }
        }
      }
    }
  }

  function getContainerElements() public view returns(Pack[] memory){
    return container;
  }
} 
