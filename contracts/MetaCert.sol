// SPDX-License-Identifier: Unlicense

pragma solidity >=0.8.2 <0.9.0;

import "./libs/Ownable.sol";
import "./libs/MetaID1155.sol";

import "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";

abstract contract Security {
    modifier onlySender() {
        require(tx.origin == msg.sender, "The caller is another contract");
        _;
    }
}

contract MetaCert is MetaID1155, Security, Ownable {
    using EnumerableSet for EnumerableSet.UintSet;

    mapping(address => EnumerableSet.UintSet)
        internal addressToObtainedCertificates;

    EnumerableSet.UintSet private courseIds;

    constructor() MetaID1155("MetaCert", "MCERT") {}

    function mintCert(address _address, uint256 _courseId) external onlyOwner {
        require(isValidCourseId(_courseId), "Invalid courseId");

        require(
            !addressToObtainedCertificates[_address].contains(_courseId),
            "User already has the certificate"
        );
        _mint(_address, _courseId, 1); // target address, course id, amount hardcoded to only 1.
        addressToObtainedCertificates[_address].add(_courseId);
    }

    function isValidCourseId(uint256 _courseId) internal view returns (bool) {
        return courseIds.contains(_courseId);
    }

    function addNewCourse(uint256 _id) external onlyOwner {
        courseIds.add(_id);
    }

    function getCourseIds() external view returns (uint256[] memory) {
        uint256[] memory ids = new uint256[](courseIds.length());
        for (uint256 i = 0; i < courseIds.length(); i++) {
            ids[i] = courseIds.at(i);
        }
        return ids;
    }

    function setBaseTokenURI(string memory baseURI) external onlyOwner {
        _setBaseTokenURI(baseURI);
    }
}
