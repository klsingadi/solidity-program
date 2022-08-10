//SPDX-License-Identifier: GPL-3.0

pragma solidity > 0.6.1;

contract decentralizedCollage{

    address public universityAdmin;
    constructor(){
        universityAdmin = msg.sender;
    }

    modifier onlyAdmin(){
        require(msg.sender==universityAdmin, "User is not admin");
        _;
    }
    struct collage{
        string collageName;
        address collageAddress;
        string collageRegNo;
        uint256 numOfStudents;
        bool blocked;
    }

    struct student{
        string sName;
        address cAddress;
        uint16 phoneNo;
        string enrolledCourse;
    }

    mapping(address => collage) Collages;
    mapping(address => mapping(string => student)) CollageStudents;


    function addNewCollage(string memory _collageName, address _collageAddress, string memory _regNo) public onlyAdmin{
        require(Collages[_collageAddress].collageAddress==address(0),"Collage already exist");
        Collages[_collageAddress] = collage(_collageName, _collageAddress, _regNo, 0, false);
    }

    function viewCollageDetails(address _collageAddres)public view returns(string memory, string memory, uint256){
        require(Collages[_collageAddres].collageAddress!=address(0),"Collage not found");
        return(Collages[_collageAddres].collageName, Collages[_collageAddres].collageRegNo, Collages[_collageAddres].numOfStudents);
    }

    function blockCollageToAddStudents(address _collageAddres) public onlyAdmin{
        require(Collages[_collageAddres].collageAddress!=address(0),"Collage not found");
        Collages[_collageAddres].blocked=true;
    }

    function unblockCollageToAddStudents(address _collageAddres) public onlyAdmin{
        require(Collages[_collageAddres].collageAddress!=address(0),"Collage not found");
        Collages[_collageAddres].blocked=false;
    }    

    function addNewStudent(address _collageAddres, string memory sName, uint16 phoneNo,string memory courseName)public{
        require(Collages[_collageAddres].collageAddress!=address(0),"Collage not found");
        require(!Collages[_collageAddres].blocked,"Collage Blocked to adding new students");
        Collages[_collageAddres].numOfStudents++;
        CollageStudents[_collageAddres][sName]=student(sName, _collageAddres,phoneNo,courseName);
    }

    function changeStudentCourse(address _collageAddres, string memory sName, string memory newCourse) public{
        require(Collages[_collageAddres].collageAddress!=address(0),"Collage not found");
        require(CollageStudents[_collageAddres][sName].cAddress!=address(0),"Student Not found");
        CollageStudents[_collageAddres][sName].enrolledCourse=newCourse;
    }

    function viewStudentDetails(address _collageAddres, string memory sName) public view returns(uint16, string memory, string memory){
        require(Collages[_collageAddres].collageAddress!=address(0),"Collage not found");
        require(CollageStudents[_collageAddres][sName].cAddress!=address(0),"Student Not found");
        return(CollageStudents[_collageAddres][sName].phoneNo, Collages[_collageAddres].collageName, CollageStudents[_collageAddres][sName].enrolledCourse);
    }


}