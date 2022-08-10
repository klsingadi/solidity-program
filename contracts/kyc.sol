//SPDX-License-Identifier: GPL-3.0

pragma solidity > 0.6.1;

contract kyc{

address kycadmin;

constructor() public{
    kycadmin = msg.sender;
}

modifier OnlyAdmin() {
    require(msg.sender==kycadmin, "User is not admin");
    _;
}

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


function AddNewBank(string memory _BankName, address _BankAddress ) public OnlyAdmin {
    require(Banks[_BankAddress].BankAddress!= _BankAddress, "Bank already exists!");
    Banks[_BankAddress] = Bank(_BankName, _BankAddress, 0, true, true);
}

function GetBankDetails(address _BankAddress) public view returns(string memory, address,uint256, bool, bool ) {
    require(Banks[_BankAddress].BankAddress!= address(0), "Bank not found!");
    return(Banks[_BankAddress].BankName,Banks[_BankAddress].BankAddress,Banks[_BankAddress].KYCCount ,Banks[_BankAddress].CanAddCustomer, Banks[_BankAddress].KYCPrivilage );
}

function AddNewCustomer(string memory _CustomerName, string memory _CustomerData, address _CustomerBank ) public {
    require(Banks[_CustomerBank].BankAddress!= address(0), "Bank not found!");
    require(Banks[_CustomerBank].CanAddCustomer, "Does not have permission to add new customers!");
    //require(BankCustomers[_CustomerName].CustomerName!= _CustomerName, "Customer already exists!");
    BankCustomers[_CustomerName] = Customer(_CustomerName, _CustomerData, _CustomerBank, false);
}

function CheckKYCStatus(string memory _CustomerName)public view returns(bool){
    require(BankCustomers[_CustomerName].CustomerBank!= address(0), "Customer does not exists!");
    return(BankCustomers[_CustomerName].KYCStatus);
}

function AddNewCustomerRequestforKYC(string memory _CustomerName, address _CustomerBank)public {
    require(Banks[_CustomerBank].BankAddress!= address(0), "Bank not found!");
    require(Banks[_CustomerBank].KYCPrivilage, "Does not have permission to do KYC!");
    Banks[_CustomerBank].KYCCount++;
    BankCustomers[_CustomerName].KYCStatus = true;
}


function BlockBankToAddCustomer(address _BankAddress) public OnlyAdmin{
    require(Banks[_BankAddress].BankAddress!= address(0), "Bank not found!");
    Banks[_BankAddress].CanAddCustomer =false;
}


function BlockBankToDoKYC(address _BankAddress) public OnlyAdmin{
    require(Banks[_BankAddress].BankAddress!= address(0), "Bank not found!");
    Banks[_BankAddress].KYCPrivilage =false;
}

function AllowBankToAddCustomer(address _BankAddress) public OnlyAdmin{
    require(Banks[_BankAddress].BankAddress!= address(0), "Bank not found!");
    Banks[_BankAddress].CanAddCustomer =true;
}


function AllowBankToDoKYC(address _BankAddress) public OnlyAdmin {
    require(Banks[_BankAddress].BankAddress!= address(0), "Bank not found!");
    Banks[_BankAddress].KYCPrivilage =true;
}


function ViewCustomerData(string memory _CustomerName) public view returns(string memory, address, bool){
    require(BankCustomers[_CustomerName].CustomerBank!= address(0), "Customer not found!");
    return(BankCustomers[_CustomerName].CustomerData, BankCustomers[_CustomerName].CustomerBank, BankCustomers[_CustomerName].KYCStatus);
}

}