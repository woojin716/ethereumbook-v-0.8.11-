var FaucetContract = artifacts.require("Faucet.sol");

module.exports=function(callback){
FaucetContract.web3.eth.getGasPrice(function(error, result) {
    if(error){
      return callback(error);
    }
    var gasPrice = Number(result);
    console.log("Gas Price is " + gasPrice + " wei"); // "10000000000000"

    // Get the contract instance
    FaucetContract.deployed().then(function(FaucetContractInstance) {

        // Use the keyword 'estimateGas' after the function name to get the gas estimation for this particular function (aprove)
		FaucetContractInstance.send(web3.utils.toWei("1", "ether"));
        return FaucetContractInstance.withdraw.estimateGas(web3.utils.toWei("0.1", "ether"));

    }).then(function(result) {
        var gas = Number(result);

        console.log("gas estimation = " + gas + " units");
        console.log("gas cost estimation = " + (gas * gasPrice) + " wei");
        console.log("gas cost estimation = " + FaucetContract.web3.utils.fromWei((gas * gasPrice).toString(), "ether") + " ether");
        //tostring()추가 수정함. towei, fromwei 사용할 때 금액은 무조건 스트링으로 표현
      }).catch(function (error){
        callback(error);
    });
});
};
