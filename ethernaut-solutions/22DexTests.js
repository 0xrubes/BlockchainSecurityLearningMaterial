const balance = {
    token1: Number,
    token2: Number
}

const dexBalance = [100.0, 100.0];
const myBalance = [10.0, 10.0];


//var dexToken = balance(100,100);
//var myToken = balance(10,10);




function getSwapPrice(from, to, amount) {
    console.log("Swap Price: ", (amount * (dexBalance[to] / dexBalance[from]).toFixed(2)));
    return amount * (dexBalance[to] / dexBalance[from]);
}


function swap(from, to, amount) {
    if (myBalance[from] < amount) {
        console.log("Not enough to swap");
    }
    else {
        const swapAmount = getSwapPrice(from, to, amount);
        myBalance[from] -= amount;
        dexBalance[from] += amount;

        myBalance[to] += swapAmount;
        dexBalance[to] -= swapAmount;
    }
    console.log("New Balances: ", dexBalance.map(function(each_element){
        return Number(each_element.toFixed(2));
    }), "   ",myBalance.map(function(each_element){
        return Number(each_element.toFixed(2));
    }));
    console.log("Summed token amount", (myBalance[0] + myBalance[1]).toFixed(2))
    
}


swap(0,1, myBalance[0]);
swap(1,0, myBalance[1]);

swap(0,1, myBalance[0]);
swap(1,0, myBalance[1]);

//-> figured out with this script that the repeatedly swapping your 
//   whole balance for the other token will enable you to drain the whole pool
