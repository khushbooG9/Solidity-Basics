pragma solidity ^0.4.22;

contract TwoWaySplitdirect {

  // balances and account list are publicly visible

  
  address[2]  beneficiaryList;

  // emit events for real-time listeners and state history

  
  event LogSent(address sentTo, uint amount);
 
  constructor(address Admin, address Charity) public {
    beneficiaryList[0]=Admin;
    beneficiaryList[1]=Charity;
    
  }

  // send ETH

  function pay() 
    public
    payable
    returns(bool success)
  {
    if(msg.value<=0) { revert();}

    
    uint adminfee = (msg.value*5)/1000;
    uint charityfund = (msg.value*995)/1000;

    beneficiaryList[0].transfer(adminfee);
    emit LogSent(beneficiaryList[0], adminfee);
    beneficiaryList[1].transfer(charityfund);
    emit LogSent(beneficiaryList[1], charityfund);
    
    return true;
  }
}