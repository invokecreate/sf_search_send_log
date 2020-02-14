({
    getSendLogResults: function (component, event, helper) {
    var action = component.get("c.searchSendLog");
    var sendLogEmail = component.get("v.sendLogEmail");
    action.setParams({ Email: sendLogEmail });
    action.setCallback(this, function(response) {
        var temp = response.getReturnValue();
        var json = JSON.parse(temp.toString());
        var primNode = json.items;
        var sendArray = [];
        for(var i in primNode) {
            var arrVals = primNode[i].values;
            sendArray.push(arrVals);
        }
        component.set("v.sendLogResults",sendArray);
    });
    $A.enqueueAction(action);
  }
});