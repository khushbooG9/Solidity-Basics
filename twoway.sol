pragma solidity ^0.4.22;

contract TwoWaySplit {

  // balances and account list are publicly visible

  mapping(address => uint) public beneficiaryBalance;
  
  // emit events for real-time listeners and state history

  event LogReceived(address sender, uint amount);
  event LogWithdrawal(address beneficiary, uint amount);

  

  
  // send ETH

  function pay(address Admin, address Charity) 
    public
    payable
    returns(bool success)
  {
    require(msg.value>0);
    uint adminfee = (msg.value*5)/1000;
    uint charityfund = (msg.value*995)/1000;

    beneficiaryBalance[Admin] += adminfee;
    beneficiaryBalance[Charity] += charityfund;
    
    emit LogReceived(msg.sender, msg.value);
    return true;
  }
  function getBalance() constant public returns(uint){
       
        return beneficiaryBalance[msg.sender];
    }

  function withdraw(uint amount)
    public
    returns(bool success)
  { 
    require(beneficiaryBalance[msg.sender]>=amount);
    
       msg.sender.transfer(amount);
       beneficiaryBalance[msg.sender] -= amount;
       emit LogWithdrawal(msg.sender, amount);
       return true;
  }
}
