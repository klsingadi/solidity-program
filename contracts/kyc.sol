//SPDX-License-Identifier: GPL-3.0

pragma solidity > 0.6.1;

contract kyc{
struct Bank{
    string BankName;
    address BankAddress;
    uint256 KYCCount;
    bool CanAddCustomer;
    bool KYCPrivilage;
}

struct Customer{
    string CustomerName;
    string CustomerData;
    address CustomerBank;
    bool KYCStatus; 
}

mapping (address => Bank) Banks;
mapping (string => Customer) BankCustomers;

function AddNewBank(string memory _BankName, address _BankAddress ) public {
    Banks[_BankAddress] = Bank(_BankName, _BankAddress, 0, true, true);
}


function AllowBankToDoKYC(address _BankAddress) public {
    Banks[_BankAddress].KYCPrivilage =true;
}

function BlockBankToDoKYC(address _BankAddress) public {
    Banks[_BankAddress].KYCPrivilage =false;
}

function AllowBankToAddCustomer(address _BankAddress) public {
    Banks[_BankAddress].CanAddCustomer =true;
}

function BlockBankToAddCustomer(address _BankAddress) public {
    Banks[_BankAddress].CanAddCustomer =true;
}

function AddNewCustomer(string memory _CustomerName, string memory _CustomerData, address _CustomerBank ) public {
    require(Banks[_CustomerBank].CanAddCustomer, "Does not have permission to add new customers");
    BankCustomers[_CustomerName] = Customer(_CustomerName, _CustomerData, _CustomerBank, false);
}

function AddNewCustomerRequestforKYC(string memory _CustomerName, address _CustomerBank)public {
    require(Banks[_CustomerBank].KYCPrivilage, "Does not have permission to do KYC");
    BankCustomers[_CustomerName].KYCStatus = true;
}

function ViewCustomerData(string memory _CustomerName) public view returns(string memory, address, bool){
    return(BankCustomers[_CustomerName].CustomerData, BankCustomers[_CustomerName].CustomerBank, BankCustomers[_CustomerName].KYCStatus);
}

}