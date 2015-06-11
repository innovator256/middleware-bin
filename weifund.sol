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

contract String{
    function parseDecimal(bytes32 byteString) returns (uint256 r){}
    function charAt(bytes32 b,uint256 char) returns (bytes1 ){}
}

contract WeiFundMiddleware {
    struct CampaignInstance {
        bytes32 name;
        bytes32 website;
        bytes32 video;
        address beneficiary;
        address config;
        uint timelimit;
        uint fundingGoal;
        uint category;
        uint instanceExpiry;
    }
    
    struct ContributionInstance {
        uint cid;
        uint sent;
        uint created;
        uint amount;
        uint instanceExpiry;
    }
    
    struct WeiFundInstance {
        uint numCampaigns;
        uint numContributions;
        mapping(bytes32 => uint) instanceIds; // Name to IDs
        mapping(bytes32 => uint) campaignNames;
        mapping(uint => CampaignInstance) campaigns;
        mapping(uint => ContributionInstance) contributions;
        // REFUNDS are available when multi-var returns are available
    }
    
    address weifundAddress = address(0);
    address stringAddress = address(0);
    
    mapping(address => mapping(address => WeiFundInstance)) instances;
    
    function newCampaign(address boardroomAddress, bytes32 _name,bytes32 _website,bytes32 _video,address _beneficiary,uint256 _goal,uint256 _timelimit,uint256 _category,address _config){
        
        WeiFundInstance w = instances[msg.sender][boardroomAddress];
        CampaignInstance c = w.campaigns[w.numCampaigns];
        c.name = _name;
        c.website = _website;
        c.video = _video;
        c.beneficiary = _beneficiary;
        c.config = _config;
        c.timelimit = _timelimit;
        c.fundingGoal = _goal;
        c.category = _category;
        c.instanceExpiry = now + (60 days);
        w.numCampaigns++;
    }
    
    function removeCampaign(address boardroomAddress, uint _instanceID){
        WeiFundInstance w = instances[msg.sender][boardroomAddress];
        CampaignInstance c = w.campaigns[_instanceID];
        
        if(c.instanceExpiry > now)
            delete w.campaigns[_instanceID];
    }
    
    function contribute(address boardroomAddress, uint _cid){
        WeiFundInstance w = instances[msg.sender][boardroomAddress];
        ContributionInstance c = w.contributions[w.numContributions];
        c.cid = _cid;
        c.created = now;
        c.instanceExpiry = now + (60 days);
        
        w.numContributions++;
    }
    
    function removeContribution(address boardroomAddress, uint _instanceID){
        WeiFundInstance w = instances[msg.sender][boardroomAddress];
        ContributionInstance c = w.contributions[_instanceID];
        
        if(c.instanceExpiry > now)
            delete w.contributions[_instanceID];
    }
    
    function execute(uint _pid) {
        address boardroomAddress = msg.sender;
        
        uint proposalFrom = BoardRoom(boardroomAddress).getProposalUint(_pid, "from");
        bytes32 proposalData = BoardRoom(boardroomAddress).getProposalBytes(_pid, "data");
        uint campaignId = String(stringAddress).parseDecimal(proposalData);
        address memberAddress = BoardRoom(boardroomAddress).getMemberAddress(proposalFrom);
        
        WeiFundInstance w = instances[memberAddress][boardroomAddress];
    
        if(msg.value == 0) {
            if(campaignId == 0) {
                CampaignInstance c = w.campaigns[campaignId];
                WeiFund(weifundAddress).newCampaign(c.name, c.website, c.video, c.beneficiary, c.fundingGoal, c.timelimit, c.category, c.config);
            } else {
                // Refund Would Go Here once multi-var returns are available
            }
        } else {
            if(w.contributions[campaignId].created == 0 || w.contributions[campaignId].sent != 0)
                return;
                
            w.contributions[campaignId].amount = msg.value;
            w.contributions[campaignId].sent = now;
            WeiFund(weifundAddress).contribute.value(msg.value)(w.contributions[campaignId].cid);
        }
    }
}