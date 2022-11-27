// SPDX-License-Identifier: UNIBO
pragma solidity ^0.8.0;

import "./packfactory.sol";

contract PackHelper is PackFactory {

  uint deliveringFee = 0.001 ether;

  modifier onlyOwnerOf(uint _packId) {
    require(msg.sender == packToSender[_packId]);
    _;
  }


  function setDeliveringFee(uint _fee) external onlyOwner {
    deliveringFee = _fee;
  }


  function changeReceiver(uint _packId, address _newReceiver) external onlyOwner {
    container[_packId].receiver = _newReceiver;
  }

  //restituisce i pacchiId dei sender
  function getPacksBySender(address _sender) external view returns(uint[] memory) {
    uint[] memory result = new uint[](senderPackCount[_sender]);
    uint counter = 0;
    for (uint i = 0; i < container.length; i++) {
      if (packToSender[i] == _sender) {
        result[counter] = i;
        counter++;
      }
    }
    return result;
  }

  //restituisce i pacchiId dei receiver
  function getPacksByReceiver(address _receiver) external view returns(uint[] memory) {
    uint[] memory result = new uint[](receiverPackCount[_receiver]);
    uint counter = 0;
    for (uint i = 0; i < container.length; i++) {
      if (packToReceiver[i] == _receiver) {
        result[counter] = i;
        counter++;
      }
    }
    return result;
  }

  //restituisce anche doppioni, funzioni sotto consentono di avere array con valori unici (costa però di più). 
  //Può servire x il futuro nel caso andiamo a scrivere un array andando a scrivere meno dati su blockchain
  function getAddressSenderDouble() internal view returns(address [] memory) {
    address[] memory result = new address[](container.length);
    uint counter = 0;
    for (uint i = 0; i < container.length; i++) {
        result[counter] = packToSender[i];
        counter++;
      }
      return result;
    }

  //restituisce anche doppioni, funzioni sotto consentono di avere array con valori unici (costa però di più)
  //Può servire x il futuro nel caso andiamo a scrivere un array andando a scrivere meno dati su blockchain
  function getAddressReceiverDouble() internal view returns(address[] memory) {
    address[] memory result = new address[](container.length);
    uint counter = 0;
    for (uint i = 0; i < container.length; i++) {
        result[counter] = packToReceiver[i];
        counter++;
      }
  
    return result;
  }

  //restituisce indirizzi unici senza doppioni. costosa ma utile in ottica futura
  function getAddressSender() external view returns(address[] memory) {
      bool doppio = false;
      uint count = 0;
      uint counter = 0;
      uint dim = 0;
      address[] memory array = getAddressSenderDouble();		  
      address[] memory temp = new address[](array.length);
      for(uint i = 0; i < array.length ; i++) {
	for(uint j = 0; j < array.length; j++) {
	    if(array[i] == temp[j]) {
	       doppio = true;
            }
	 }
	if(doppio == false) {
           temp[count] = array[i];
           count++;
	   dim++;	
	}
	doppio = false;
      }
      address[] memory result = new address[](dim);
      for(uint i = 0; i < array.length ; i++) {
	for(uint j = 0; j < dim; j++) {
	    if(array[i] == result[j]) {
		doppio = true;
            }
	}
	  if(doppio == false) {
             result[counter] = array[i];
	     counter++;	
	  }
	doppio = false;
       }
    return result;
   }


  //restituisce indirizzi unici senza doppioni. costosa ma utile in ottica futura
  function getAddressReceiver() public view returns(address[] memory) {
    bool doppio = false;
    uint count = 0;
    uint counter = 0;
    uint dim = 0;
    address[] memory array = getAddressReceiverDouble();		  
    address[] memory temp = new address[](array.length);
    for(uint i = 0; i < array.length ; i++) {
	for(uint j = 0; j < array.length; j++) {
	    if(array[i] == temp[j]) {
		doppio = true;
            }
	}
	if(doppio == false) {
           temp[count] = array[i];
           count++;
	   dim++;	
	}
	doppio = false;
     }
     address[] memory result = new address[](dim);
     for(uint i = 0; i < array.length ; i++) {
	for(uint j = 0; j < dim; j++) {
	    if(array[i] == result[j]) {
	       doppio = true;
            }
	}
        if(doppio == false) {
           result[counter] = array[i];
	   counter++;	
	}
	doppio = false;
     }
    return result;
  }
  
}
