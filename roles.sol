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

contract WeiFund {
    function userCampaigns(address _addr,uint256 _u_cid)returns(uint256 cid){}
    
    function refund(uint256 _cid){}
    
    function numCampaigns()constant returns(uint256 ){}
    
    function users(address )constant returns(uint256 numCampaigns){}
    
    function newCampaign(bytes32 _name,bytes32 _website,bytes32 _video,address _beneficiary,uint256 _goal,uint256 _timelimit,uint256 _category,address _config){}
    
    function contribute(uint256 _cid){}
    
    function payout(uint256 _cid){}
}

address stringAddress = address(0);

contract String {
    function parseDecimal(bytes32 byteString) returns (uint256 r){}
    function charAt(bytes32 b,uint256 char) returns (bytes1 ){}
}

contract RolesMiddleware {
    struct RoleInstance {
        uint pid;
        uint mid;
        uint position;
        uint created;
        uint verified;
        uint instanceExpiry;
    }
    
    mapping(address => mapping(address => uint)) numRoles;
    mapping(address => mapping(address => mapping(uint => RoleInstance))) roles; // member => board => rid => Role
    
    function assignRole(address _boardroomAddress, uint _mid, uint _position) {
        uint _numRoles = numRoles[msg.sender][_boardroomAddress];
        RoleInstance r = roles[msg.sender][_boardroomAddress][_numRoles];
        
        if(r.verified > 0 || (r.verified == 0 && r.instanceExpiry > now))
            return;
        
        r.mid = _mid;
        r.position = _position;
        r.created = now;
        r.instanceExpiry = now + (60 days);
        numRoles[msg.sender][_boardroomAddress] += 1;
    }
    
    function execute(uint _pid) {
    }
}
          