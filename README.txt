Decentralized KYC Verification Project


Project is implemented using REMIX IDE and solidity programming language.

Bank and Customer structure are created to define the structure of each entity.
These entities are stored in mapping so that it is easily accessible from code.

Constructor is used to capture the admin(The person deploying the contract).
Modifiers are used to restrict the access to some of admin work.

Implemented functionality of BlockChain are as fallows:

1.AddNewBank: This function will add new bank to the blockchain. 
It takes address and bankName as input creates new Bank entity and 	stores in mapping.

2. GetCustomerDetails: This function will take bank address and shows details about 				the bank.
3. AddNewCustomer: This function will creates customer entity and add new customer 					to existing bank and stores it in mapping. 
It Takes customerName , customerDetatils and Bank Address as 	input and creates the entity.

4.CheckKYCStatus: This function checks whether the customer KYC is done or note.
It takes customeName and gives bool output showing KYC is 	done or not. 

5.AddNewCustomerRequestforKYC: This function will update the KYC status of 						Customer by checking the KYCPrivilage of bank which is updating. 					Takes CustomerName and address of bank as input.

6.BlockBankToAddCustomer: This function takes bank address and block it from 						adding new customers.

7.BlockBankToDoKYC: This function takes bank address as input and blocks bank 					from doing any KYC of customers.

8.AllowBankToAddCustomer: This function takes bank address as input and allows already blocked bank to add new customers.
9.AllowBankToDoKYC:This function takes bank address as input and allows already blocked bank to do KYC of new customers.