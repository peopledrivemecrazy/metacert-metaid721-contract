# MetaID

MetaID is the key component to connect the proof of personhood to an NFT issued by the MetaID721 contract. It allows for the minting of unique MetaIDs associated with Ethereum addresses.

**MetaID Contract Address**: 0xCC779eA62dde267a66D7C36e684Ee32d498c0a5F
**MetaCert Contract Address**: 0xE359d0F906955eb6Cc096d8F7F561f767DF997B8

## Dependencies

The MetaID contract relies on the following libraries:

- [MetaID721](./libs/MetaID721.sol): A custom implementation of the ERC 721 contract with transfer functions removed. _You cannot trade your identity_.

## Functionality

The MetaID contract has the following functions:

- `mintId`: Allows the contract owner to mint a MetaID for a specified address. The address should not already have a MetaID. Called from the [metaid-issuer-express](https://github.com/peopledrivemecrazy/metaid-issuer-express).

- `setBaseTokenURI`: Sets the base token URI with the nouns metadata.

Additionally, the contract includes the following features:

- The `hasId` mapping: Keeps track of addresses that already have a MetaID, preventing duplicate MetaID minting.

## Usage

To utilize the MetaID contract, follow these steps:

- Call the `mintId` function to mint a MetaID for a specific address. Only the contract owner can perform this action, and the address should not already have a MetaID.

<hr/>

Certainly! Here's an updated README based on the provided Solidity code:

---

# MetaCert

MetaCert is a the POAPS with MetaID1155 contract.

## Dependencies

- [MetaID1155](./libs/MetaID1155.sol): A custom implementation of the ERC 1155 contract with transfer functions removed. _You cannot trade your certificates_.

- [EnumerableSet](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/structs/EnumerableSet.sol): A library from the OpenZeppelin Contracts library, used for managing enumerable sets of unsigned integers.

## Functionality

The MetaCert contract introduces the following functions:

- `mintCert`: Allows the contract owner to mint a certificate for a specified address and course ID. The address should not already have the certificate, and the course ID should be valid.
- `isValidCourseId`: Internal function that checks if a given course ID is valid.
- `addNewCourse`: Permits the contract owner to add a new course ID to the list of valid course IDs.
- `getCourseIds`: Returns an array of all valid course IDs.
- `getCertByAddress`: Retrieves an array of course IDs for which a specific address has obtained certificates.
- `setBaseTokenURI`: Permits the contract owner to set the base token URI for the certificates. This URI is used as a prefix for generating the metadata URI for each token.
- `uri`: Retrieves the metadata URI for a specific certificate ID from the IPFS.

Additionally, the contract includes the following features:

- The `addressToObtainedCertificates` mapping: Tracks the certificates obtained by each address using an EnumerableSet to efficiently manage the list of certificate IDs.
- The `courseIds` set: Stores the valid course IDs using an EnumerableSet to manage the list of course IDs.
