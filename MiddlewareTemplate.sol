contract BoardRoom {
    function getProposalBytes(uint _pid,bytes32 _param) returns (bytes32 b){}
    
    function getProposalUint(uint256 _pid,bytes32 _param) returns (uint256 u){}
    
    function getProposalExecuted(uint256 _pid) returns (bool b){}
    
    function hasWon(uint256 _pid) returns (bool ){}
    
    
    function getDelegationNumDelegations(uint256 _pid,uint256 _to) returns (uint256 u){}
    
    function getDelegationType(uint256 _pid,uint256 _to) returns (bool b){}
    
    
    function getMemberUint(uint256 _mid,bytes32 _param) returns (uint256 u){}
    
    function numMembersActive() constant returns (uint256 ){}
    
    function getMemberAddress(uint256 _mid) returns (address a){}
    
    function toMember(address ) constant returns (uint256 ){}
    
    function chair() constant returns (uint256 ){}
    
    
    function numExecuted() constant returns (uint256 ){}
    
    function numProposals() constant returns (uint256 ){}
    
    function numMembers() constant returns (uint256 ){}
    
    function numChildrenActive() constant returns (uint256 ){}
    
    function numChildren() constant returns (uint256 ){}
    
    function configAddr() constant returns (address ){}
    
    
    function parent() constant returns (address ){}
    
    function children(uint256 ) constant returns (address ){}
}


contract Middleware {
    function isMember(address memberAddress, address boardroomAddress) returns (bool isMember) {
        uint memberId = BoardRoom(boardroomAddress).toMember(memberAddress);
        
        if(BoardRoom(boardroomAddress).getMemberAddress(memberId) == memberAddress)
            return true;
    }
    
    function isPid(uint _pid, address boardroomAddress) returns (bool isPid) {
        // Is Proposal ID
        
        if(_pid >= 0 && _pid < BoardRoom(boardroomAddress).numProposals())
            return true;
    }
    
    function getBoardProposalBytes(address _boardroomAddress, uint _pid, bytes32 _param) returns (bytes32 b) {
        return BoardRoom(_boardroomAddress).getProposalBytes(_pid, _param);
    }
    
    
    function execute(uint _pid){
        address boardroomAddress = msg.sender;
    
        // Board Counts
        //uint boardNumExecuted = BoardRoom(boardroomAddress).numExecuted();
        //uint boardNumProposals = BoardRoom(boardroomAddress).numProposals();
        //uint numMembersActive = BoardRoom(boardroomAddress).numMembersActive();
        //uint boardNumMembers = BoardRoom(boardroomAddress).numMembers();
        //uint boardNumChildrenActive = BoardRoom(boardroomAddress).numChildrenActive();
        //uint boardNumChildren = BoardRoom(boardroomAddress).numChildren();
        
        
        // More Board Data
        //address boardConfigAddr = BoardRoom(boardroomAddress).configAddr();
        //uint boardBalance = boardroomAddress.balance;
        //address boardParent = BoardRoom(boardroomAddress).parent();
        //address boardChild = BoardRoom(boardroomAddress).children(0);
        
        
        // Proposal Bytes32 and Address Data
        //bytes32 proposalName = BoardRoom(boardroomAddress).getProposalBytes(_pid, "name");
        //bytes32 proposalData = BoardRoom(boardroomAddress).getProposalBytes(_pid, "value");
        //address proposalAddress = address(BoardRoom(boardroomAddress).getProposalBytes(_pid, "address"));
        
        
        // Proposal Value Data
        //proposalValue = BoardRoom(boardroomAddress).getProposalUint(_pid, "value");
        //uint proposalTransactionValue = msg.value;
        
        
        // Proposal Kind and Expiry Data
        //uint proposalKind = BoardRoom(boardroomAddress).getProposalUint(_pid, "kind");
        //uint proposalExpiry = BoardRoom(boardroomAddress).getProposalUint(_pid, "value");
        //uint proposalFrom = BoardRoom(boardroomAddress).getProposalUint(_pid, "from");
        
        
        // Proposal From Member Data
        //address memberAddress = BoardRoom(boardroomAddress).getMemberAddress(proposalFrom);
        //uint memberPermission = BoardRoom(boardroomAddress).getMemberUint(proposalFrom, "permission");
        //uint memberCreated = BoardRoom(boardroomAddress).getMemberUint(proposalFrom, "created");
        //bool memberIsChair = false;
        //if(BoardRoom(boardroomAddress).chair() == proposalFrom)
        //    memberIsChair = true;
        
        
        // Proposal Boolean Data (Executed and Won)
        //bool proposalExecuted = BoardRoom(boardroomAddress).getProposalExecuted(_pid);
        //bool proposalWon = BoardRoom(boardroomAddress).hasWon(_pid);
    }
}        

/*

6102a48061000e6000396000f3007c010000000000000000000000000000000000000000000000000000000060003504631360f0fc811461004f5780631c13bd03146100bf57806339ac7a081461012c578063fe0d94c1146101ab57005b6101b160043560243560443560008373ffffffffffffffffffffffffffffffffffffffff16630c4f284260206000827c010000000000000000000000000000000000000000000000000000000002600052600487815260200186815260200160006000866161da5a03f16101eb57005b6101bb6004356024356000600083101580156101d757508173ffffffffffffffffffffffffffffffffffffffff1663400e394960206000827c010000000000000000000000000000000000000000000000000000000002600052600460006000866161da5a03f16101cf57005b6101c5600435602435600060008273ffffffffffffffffffffffffffffffffffffffff16636772b2f360206000827c01000000000000000000000000000000000000000000000000000000000260005260048873ffffffffffffffffffffffffffffffffffffffff16815260200160006000866161da5a03f161022157005b60006000f35b8060005260206000f35b8060005260206000f35b8060005260206000f35b505060005183105b6101e3575b5b92915050565b5060016101dd565b5050600051949350505050565b505060005173ffffffffffffffffffffffffffffffffffffffff161461029b575b5b5092915050565b505060005190508373ffffffffffffffffffffffffffffffffffffffff168373ffffffffffffffffffffffffffffffffffffffff16639029444a60206000827c010000000000000000000000000000000000000000000000000000000002600052600486815260200160006000866161da5a03f16101f857005b6001915061021a56


clean[
  {
    "constant": false,
    "inputs": [
      {
        "name": "_boardroomAddress",
        "type": "address"
      },
      {
        "name": "_pid",
        "type": "uint256"
      },
      {
        "name": "_param",
        "type": "bytes32"
      }
    ],
    "name": "getBoardProposalBytes",
    "outputs": [
      {
        "name": "b",
        "type": "bytes32"
      }
    ],
    "type": "function"
  },
  {
    "constant": false,
    "inputs": [
      {
        "name": "_pid",
        "type": "uint256"
      },
      {
        "name": "boardroomAddress",
        "type": "address"
      }
    ],
    "name": "isPid",
    "outputs": [
      {
        "name": "isPid",
        "type": "bool"
      }
    ],
    "type": "function"
  },
  {
    "constant": false,
    "inputs": [
      {
        "name": "memberAddress",
        "type": "address"
      },
      {
        "name": "boardroomAddress",
        "type": "address"
      }
    ],
    "name": "isMember",
    "outputs": [
      {
        "name": "isMember",
        "type": "bool"
      }
    ],
    "type": "function"
  },
  {
    "constant": false,
    "inputs": [
      {
        "name": "_pid",
        "type": "uint256"
      }
    ],
    "name": "execute",
    "outputs": [],
    "type": "function"
  }
]


contract Middleware{function getBoardProposalBytes(address _boardroomAddress,uint256 _pid,bytes32 _param)returns(bytes32 b){}function isPid(uint256 _pid,address boardroomAddress)returns(bool isPid){}function isMember(address memberAddress,address boardroomAddress)returns(bool isMember){}function execute(uint256 _pid){}}

*/