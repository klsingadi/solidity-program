pragma solidity >= 0.7.0 <0.9.0;

contract learnmapping{

uint16 Flat_No;
string Flat_Owner;

mapping(uint16 => string) MyAssosiation;

function setassosiationdata(uint16 _Flat_No, string memory _Flat_Owner) public {
    MyAssosiation[_Flat_No]=_Flat_Owner;
}

function getassosiationdata(uint16 _Flat_No) public view returns (string memory) {
   return(MyAssosiation[_Flat_No]);
}
}