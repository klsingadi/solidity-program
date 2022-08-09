pragma solidity >= 0.7.0 <0.9.0;

contract learnmapping{

uint16 Flat_No;
string Flat_Owner;

mapping(uint16 => string) MyAssosiation;
function stringsEquals(string memory s1, string memory s2) public pure returns (bool) { 
        bytes memory b1 = bytes(s1); 
        bytes memory b2 = bytes(s2); 
        uint256 l1 = b1.length; 
        if (l1 != b2.length) return false; 
        for (uint256 i = 0; i < l1; i++) { 
            if (b1[i] != b2[i]) return false; 
        } 
        return true; 
} 

function setassosiationdata(uint16 _Flat_No, string memory _Flat_Owner) public {
    MyAssosiation[_Flat_No]=_Flat_Owner;
}

function getassosiationdata(uint16 _Flat_No) public view returns (string memory) {
   return(MyAssosiation[_Flat_No]);
}
}